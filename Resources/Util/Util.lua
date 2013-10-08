-- 用于拷贝一个table，只拷贝字符串或数值类型
function copyData(oldTable)
	local newTable = {}
	for i, v in pairs(oldTable) do
		if type(v) == "number" or type(v) == "string" then
			newTable[i] = v
		end
	end
	return newTable
end

local sortFunctionCache = {}

function getSortFunction(key, reverse)
    local fkey = key .. ((reverse and 1) or 0)
    if not sortFunctionCache[fkey] then
        if reverse then
            sortFunctionCache[fkey] = function(a, b)
                return a[key]>b[key]
            end
        else
            sortFunctionCache[fkey] = function(a, b)
                return a[key]<b[key]
            end
        end
    end
    return sortFunctionCache[fkey]
end

function cmpData(oldData, newData)
	for k, v in pairs(oldData) do
		local diff = false
		if newData[k]==nil then 
			diff = true
		elseif type(v)~="table" then
			if v~=newData[k] then diff = true end
		else
			diff = not cmpData(v, newData[k])
		end
		if diff then return false end
	end
	for k, v in pairs(newData) do
		if oldData[k]==nil then return false end
	end
	return true
end

-- 用于获取一个限制范围之后的数值
function squeeze(value, min, max)
	if min and value<min then
		return min
	elseif max and value>max then
		return max
	else
		return value
	end
end

-- 延时异步调用，不要滥用
function delayCallback(delay, callback, params)
	local entryId = nil
	local function callOnce()
		callback(params)
		if entryId then
			CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(entryId)
		end
	end
	entryId = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(callOnce, delay, false)
end

function removeSelf(node)
    node:removeFromParentAndCleanup(true)
end

-- 延时删除节点，主要用于某些显示之后不需要维持其存在，但仍需要动画完毕后才进行的自动删除
function delayRemove(delay, node)
	--node:retain()
	--local function removeAndRelease()
	--	node:removeFromParentAndCleanup(true)
	--	node:release()
	--end
	--delayCallback(delay, removeAndRelease)
	local array = CCArray:create()
	array:addObject(CCDelayTime:create(delay))
	array:addObject(CCCallFuncN:create(removeSelf))
	node:runAction(CCSequence:create(array))
end

-- 啥都不做的空方法
function doNothing()
end

function changeFunction(entry, delegate)
	if not entry.changed then
		entry.changed = true
		local baseCallback = entry.callback
		entry.callback = function(...)
			return baseCallback(delegate, ...)
		end
	end
end

-- 为一个节点注册事件，包括点击和更新事件
function simpleRegisterEvent(node, events, delegate)
	if not events then
		return
	end
	local update = events.update
	local other = events.enterOrExit
	local entryId = nil
	if delegate then
		if update then
			changeFunction(update, delegate)
		end
		if other and not other.changed then
			changeFunction(other, delegate)
		end
	end
	local function onEnterOrExit(eventType)
		if eventType=="enter" then
			if update and not update.pause and not entryId then
				entryId = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(update.callback, update.inteval or 1, false)
			end
			if other then
				other.callback(true)
			end
		elseif eventType=="exit" then
			if update and not update.pause then
				CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(entryId)
				entryId = nil
			end
			if other then
				other.callback(false)
			end
		end
	end
	node:registerScriptHandler(onEnterOrExit)
	if node:getParent() then
		onEnterOrExit("enter")
	end
end

-- 判断一个点击是否在节点上
function isTouchInNode(node, x, y, alphaTouch)
    if not node then return end
	local parent = node
	while parent do
		if not parent:isVisible() then
			return false
		end
		parent = parent:getParent()
	end
	local point = node:convertToNodeSpace(CCPointMake(x,y))
	local size = node:getContentSize()
	if point.x >0 and point.y > 0 and point.x < size.width and point.y < size.height then
		if alphaTouch and node.isAlphaTouched then
			return not node:isAlphaTouched(point)
		else
			return true
		end
	else
		return false
	end
end

-- 注册一个按钮的点击事件
function simpleRegisterButton(node, setting)
	local isTouched = false
	
	local params = setting or {}
	local priority = params.priority or -1
	
	local layer
	if setting.layer then
	    layer = setting.layer
	else
	    layer = CCTouchLayer:create(priority, true)
    	layer:setContentSize(node:getContentSize())
    	node:addChild(layer)
	end
	local buttonTouched = params.nodeChangeHandler
	
	local clickedCallback = params.callback or doNothing
	local callbackParam = params.callbackParam
	local alphaTouch = params.alphaTouch
	
	local function onTouchBegan(x, y)
		if not isTouched and isTouchInNode(layer, x, y, alphaTouch) then
			isTouched = true
			if buttonTouched then
				buttonTouched(isTouched, node)
			end
			return true
		else
			return false
		end
	end
	
	local function onTouchMoved(x, y)
		if isTouched and not isTouchInNode(layer, x, y) then
			isTouched = false
			if buttonTouched then
				buttonTouched(isTouched, node)
			end
		elseif not isTouched and isTouchInNode(layer, x, y) then
			isTouched = true
			if buttonTouched then
				buttonTouched(isTouched, node)
			end
		end
	end
	
	local function onTouchEnded(eventType)
		if isTouched then
			isTouched = false
			if buttonTouched then
				buttonTouched(isTouched, node)
			end
			if eventType==CCTOUCHENDED then
				clickedCallback(callbackParam)
			end
		end
	end
	
	--按钮只接收一个ID，其他的在上层抛弃
	local function onTouch(eventType, id, x, y)
		if eventType == CCTOUCHBEGAN then
			return onTouchBegan(x, y)
		elseif eventType == CCTOUCHMOVED then
			return onTouchMoved(x, y)
		else
			return onTouchEnded(eventType)
		end
	end
	
	layer:registerScriptTouchHandler(onTouch)
end

function recurSetColor(sprite, color)
	CCExtendSprite:recurSetColor(sprite, color)
end

function checkMaxRect(rect, sprite)
    local size = sprite:getContentSize()
    if size.width > rect[3] then
        if rect[3]>0 then
            rect[1] = rect[1]-(size.width - rect[3])/2
        end
        rect[3] = size.width
    end
    if size.height > rect[4] then
        rect[4] = size.height
    end
end

function printArray(arr)
    local res = ""
    for k, v in ipairs(arr) do
        res = res .. v
    end
    print(res)
end

function Enum(...)
    local enums = {}
    for i, enum in ipairs({...}) do
        enums[enum] = i
    end
    return enums
end

function assertNotEqual(value1, value2)
    if value1==value2 then
        print("assert error! the value shouldn't be " .. tostring(value2))
        local a=nil
        a=a/2
        -- make an error to print.
    end
end


require "Util.Class"
require "Util.character"
require "Util.json"
require "Util.queue"
require "Util.Random"
require "Util.Action"
require "Util.MapGrid"
require "Util.RhombGrid"

require "Util.Touch"
require "Util.World"
require "Util.Ray"
