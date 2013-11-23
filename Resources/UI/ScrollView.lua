do
    local function nodeChangeHandler(bIsTouched, nNode)
        if bIsTouched then
            -- ÁÐ±í¿òµÄÉùÒô
            music.playEffect("music/but.mp3")
            nNode:setScale(0.99)
            if nNode.setValOffset then
                nNode:setValOffset(20, true)
            end
        else
            nNode:setScale(1)
            if nNode.setValOffset then
                nNode:setValOffset(0, true)
            end
        end
    end
    
    local ScrollButton = {}
    ScrollButton.__index = ScrollButton
    
    function ScrollButton:executeTouchBegan(touchEvent, touch)
        self.nodeChangeHandler(true, self.view)
        self.nodeTouched = true
    end
    
    function ScrollButton:executeTouchMoved(touch, newPoint)
        local scrollView = self.scrollView
        if not touch.isMoved then
            scrollView:addChildTouch(touch.bx, touch.by)
            scrollView:changeChildTouch(touch.bx, touch.by, newPoint.x, newPoint.y)
        else
            scrollView:changeChildTouch(touch.x, touch.y, newPoint.x, newPoint.y)
        end
        if isTouchInNode(self.view, newPoint.x, newPoint.y) then
            if not self.nodeTouched then
                self.nodeChangeHandler(true, self.view)
                self.nodeTouched = true
            end
        else
            if self.nodeTouched then
                self.nodeChangeHandler(false, self.view)
                self.nodeTouched = false
            end
        end
    end
    
    function ScrollButton:executeTouchEnded(touch)
        self.nodeChangeHandler(false, self.view)
        self.nodeTouched = false
        if not touch.isMoved then
            self.clickedCallback(self.callbackParam)
        else
            self.scrollView:removeChildTouch(touch.x, touch.y)
        end
    end
    
    function ScrollButton:executeTouchCanceled(touch)
        if self.nodeTouched then
            self.nodeChangeHandler(false, self.view)
            self.nodeTouched = false
        end
        if touch.isMoved then
            self.scrollView:removeChildTouch(touch.x, touch.y)
        end
    end
    
    function ScrollButton:new(button, scrollView, callback, callbackParam, setting)
        local self = {clickedCallback = callback, callbackParam=callbackParam, scrollView=scrollView, view=button}
        setmetatable(self, ScrollButton)
        
        local xm, ym = 0, 0
        if scrollView.isX then
            xm=1
        else
            ym=1
        end 
        
        local params = setting or {}
        self.nodeChangeHandler = params.nodeChangeHandler or nodeChangeHandler
        Touch.registerMultiTouch(button, false, params.priority or display.DIALOG_BUTTON_PRI, self, {XMOVE=xm, YMOVE=ym})
        
        return self
    end
    
    local ScrollView = {}
    ScrollView.__index = ScrollView
    
    function ScrollView:addItem(node, setting)
        local params = setting or {}
        local offx, offy = params.offx or 0, params.offy or 0
        local disx, disy = params.disx or 0, params.disy or 0
        local index = (params.index  or 1) - 1
        local rowmax = params.rowmax or 1
            
        local off, length, endoff = 0, 0, 0
        local nsize = node:getContentSize()
            
        local x, y = 0, 0
        if self.isX then
            x = math.floor(index / rowmax) * (nsize.width + disx) 
            y = (index % rowmax) * (nsize.height + disy)
            off = offx + x
            length = nsize.width
            endoff = disx/2
        else
            x = (index % rowmax) * (nsize.width + disx) 
            y = math.floor(index / rowmax) * (nsize.height + disy)
            off = offy + y
            length = nsize.height
            endoff = disy/2
        end
        node:setAnchorPoint(General.anchorCenter)
        node:setPosition(offx + x + nsize.width/2, -(y + offy + nsize.height/2))
        node:setVisible(false)
        self.bg:addChild(node)
        local newItem = {off = off, length = length, endoff = endoff, view = node}
        self.items[1 + #self.items] = newItem
    end
    
    function ScrollView:prepare()
        local items = self.items
        local size = self.view:getContentSize()
        local bg = self.bg
        local state = self.state
        
        local rectmin, rectmax = 0, 0
        if self.isX then
            self.off_max = 0
            rectmin = -bg:getPositionX()
            rectmax = rectmin + size.width
        else
            self.off_min = size.height
            rectmax = bg:getPositionY()
            rectmin = rectmax - size.height
        end
        if not self.delayInitCell then
            table.sort(items, getSortFunction("off"))
            local itemsNum = #items
            local lastItem = items[itemsNum]
            if lastItem == nil then
                lastItem = {off=0, length=0, endoff=0}
            end
            if self.isX then
                self.off_min = squeeze(size.width - (lastItem.off + lastItem.length + lastItem.endoff), nil, self.off_max)
            else
                self.off_max = squeeze(lastItem.off + lastItem.length + lastItem.endoff, self.off_min)
            end
            local index = 1
            while index<=itemsNum do
                local item = items[index]
                if item.off + item.length >= rectmin and item.off < rectmax then
                    item.view:setVisible(true)
                    if not state.first then state.first = index end
                    state.last = index
                end
                index = index + 1
            end
            if #items == 0 then
                self.movable = false
            end
        else
            self.dataInitedLength = 0
            local itemsNum = self.dataLength
            local index = 1
            local lastItem = {off=0, length=0, endoff=0}
            while index<=itemsNum do
                local item = self:initCell(index)
                lastItem = item
                self.dataInitedLength = index
                if item.off + item.length < rectmin then
                    item.view:setVisible(false)
                elseif item.off<rectmax then
                    item.view:setVisible(true)
                    if not state.first then state.first = index end
                    state.last = index
                else
                    item.view:setVisible(false)
                    break
                end
                index = index + 1
            end
            if self.isX then
                self.off_min = squeeze(size.width - (lastItem.off + lastItem.length + lastItem.endoff), nil, self.off_max)
            else
                self.off_max = squeeze(lastItem.off + lastItem.length + lastItem.endoff, self.off_min)
            end
            self.movable = (self.dataLength>0)
        end
    end
    
    function ScrollView:refreshItem(direction, rectmin, rectmax)
        local items = self.items
        local state = self.state
        if direction == -1 then
            while state.first<=#items and items[state.first].off + items[state.first].length < rectmin do
                items[state.first].view:setVisible(false)
                state.first = state.first + 1
            end
            while state.last+1<=#items and items[state.last+1].off < rectmax do
                items[state.last+1].view:setVisible(true)
                state.last = state.last + 1
            end
            if self.delayInitCell then
                while self.dataInitedLength<self.dataLength and state.last==self.dataInitedLength do
                    self.dataInitedLength = self.dataInitedLength+1
                    local item = self:initCell(self.dataInitedLength)
                    local size = self.view:getContentSize()
                    if self.isX then
                        self.off_min = squeeze(size.width - (item.off + item.length + item.endoff), nil, self.off_max)
                    else
                        self.off_max = squeeze(item.off + item.length + item.endoff, self.off_min)
                    end
                    if item.off<rectmax then
                        item.view:setVisible(true)
                        state.last = state.last + 1
                    else
                        item.view:setVisible(false)
                    end
                end
            end
        else
            while state.first-1>0 and items[state.first-1].off + items[state.first-1].length > rectmin do
                items[state.first-1].view:setVisible(true)
                state.first = state.first - 1
            end
            while state.last>0 and items[state.last].off > rectmax do
                items[state.last].view:setVisible(false)
                state.last = state.last - 1
            end
        end
    end
    
    function ScrollView:moveBy(off)
        if off == 0 then return end
        local rectmin, rectmax, direction = 0, 0, 1
        local bg = self.bg
        local size = self.view:getContentSize()
        if self.isX then
            local base = bg:getPositionX()
            rectmin = - (base + off)
            rectmax = rectmin + size.width
            bg:setPositionX(base + off)
            if off<0 then direction = -1 end
        else
            local base = bg:getPositionY()
            rectmax = base + off
            rectmin = rectmax - size.height
            bg:setPositionY(base + off)
            if off>0 then direction = -1 end
        end
        self:refreshItem(direction, rectmin, rectmax)
    end
    
    function ScrollView:getTouchPoint()
        local x, y, s = 0, 0, 0
        for _, point in pairs(self.selfTouches) do
            x = x+point.x
            y = y+point.y
            s = s+1
        end
        for _, point in pairs(self.childTouches) do
            x = x+point.x
            y = y+point.y
            s = s+1
        end
        if s~=0 then
            return {x=x/s, y=y/s}
        end
    end
    
    function ScrollView:executeTouchBegan(touchEvent, touch)
        if touchEvent then
            self.selfTouches = touchEvent.touches
        end
        self.state.touchPoint = self:getTouchPoint()
    end
    
    function ScrollView:addChildTouch(x, y)
        table.insert(self.childTouches, {x=x, y=y})
        self.state.touchPoint = self:getTouchPoint()
    end
    
    function ScrollView:executeTouchesMoved(touchEvent)
        if touchEvent then
            self.selfTouches = touchEvent.touches
        end
        if not self.movable then return end
        local state = self.state
        local touchPoint = self:getTouchPoint()
        local bg = self.bg
        local cPoint = bg:convertToNodeSpace(CCPointMake(touchPoint.x, touchPoint.y))
        local tcPoint = bg:convertToNodeSpace(CCPointMake(state.touchPoint.x, state.touchPoint.y))
        local off, base = nil
        if self.isX then
            off = cPoint.x - tcPoint.x
            base = bg:getPositionX()
        else
            off = cPoint.y - tcPoint.y
            base = bg:getPositionY()
        end
        if base<self.off_min or base>self.off_max then
            off = off/2
        end
        self:moveBy(off)
        state.touchPoint = touchPoint
    end
    
    function ScrollView:changeChildTouch(fx, fy, tx, ty)
        if fx==tx and fy==ty then return end
        for _, point in pairs(self.childTouches) do
            if point.x==fx and point.y==fy then
                point.x = tx
                point.y = ty
            end
        end
        self:executeTouchesMoved()
    end
    
    function ScrollView:executeTouchesEnded(touchEvent, touch)
        if touchEvent then
            self.selfTouches = touchEvent.touches
        end
        if not self.movable then return end
        local touchPoint = self:getTouchPoint()
        if touchPoint == nil then
            local base, bg = 0, self.bg
            if self.isX then
                base = bg:getPositionX()
            else
                base = bg:getPositionY()
            end
            local off=0
            if base<self.off_min then
                off = self.off_min - base
            elseif base>self.off_max then
                off = self.off_max - base
            end
            self:moveBy(off)
            -- TEST
            if self.moveCallback then
                self.moveCallback(self.moveCallbackDelegate)
            end
        end
    end
    
    function ScrollView:removeChildTouch(x, y)
        local rmKey = nil
        for key, point in pairs(self.childTouches) do
            if point.x==x and point.y==y then
                rmKey = key
                break
            end
        end
        self.childTouches[rmKey] = nil
        self:executeTouchesEnded()
    end
    
    function ScrollView:addChildTouchNode(node, callback, callbackParam, setting)
        ScrollButton:new(node, self, callback, callbackParam, setting)
    end
    
    function ScrollView:createButton(size, callback, setting)
        local params = setting or {}
        local buttonImage = params.image
        local buttonText = params.text
        
        local node
        node = CCExtendNode:create(CCSizeMake(0,0), false)
        
        if buttonImage then
            local sprite = nil
            if size then
                sprite = UI.createSpriteWithFile(buttonImage, size)
            else
                sprite = UI.createSpriteWithFile(buttonImage)
                size = sprite:getContentSize()
            end
            sprite:setAnchorPoint(General.anchorLeftBottom)
            node:addChild(sprite)
        end
        
        node:setContentSize(size)
        
        if buttonText then
            local fontSize = params.fontSize or 18
            local fontName = params.fontName or General.font1
            local colorR, colorG, colorB = params.colorR or 255, params.colorG or 255, params.colorB or 255
            local lineOffset = params.lineOffset or 0
            local label = UI.createLabel(buttonText, fontName, fontSize, {size = CCSizeMake(size.width, size.height), colorR = colorR, colorG = colorG, colorB = colorB, lineOffset=lineOffset})
            screen.autoSuitable(label, {nodeAnchor=General.anchorCenter, x=size.width/2, y=size.height/2})
            node:addChild(label)
        end
        local nodeChangeHandler = params.nodeChangeHandler
        ScrollButton:new(node, self, callback, params.callbackParam, {priority=params.priority or display.DIALOG_BUTTON_PRI-1, nodeChangeHandler=nodeChangeHandler})
        return node
    end
    
    function ScrollView:new(size, isX, priority)
        local clipNode = CCExtendNode:create(size, true)
        local layer = CCLayer:create()
        clipNode:addChild(layer)
        local bg = CCNode:create()
        bg:setAnchorPoint(General.anchorLeftBottom)
        bg:setPosition(0, size.height)
        clipNode:addChild(bg)
        
        local off_min, off_max = 0, 0
        local state = {}
        local items = {}
        
        local self = {view = clipNode, bg=bg, items=items, state=state, off_max=off_max, off_min=off_min, isX=isX, pageSize=pageSize, movable=true;
            selfTouches={}, childTouches={}}
        setmetatable(self, ScrollView)
        
        local xm, ym = 0, 0
        if isX then
            xm=1
        else
            ym=1
        end 
        Touch.registerMultiTouch(clipNode, true, priority or display.DIALOG_PRI, self, {XMOVE=xm, YMOVE=ym})
        return self
    end
    
    function ScrollView:initCell(dindex)
        if dindex>=1 and dindex<=self.dataLength then
            local data = self.datas[dindex]
            local cellSetting = self.cellSetting
            while data.isNewLine do
                cellSetting.offx = cellSetting.offx + (data.offx or 0)
                cellSetting.offy = cellSetting.offy + (data.offy or 0)
                table.remove(self.datas, dindex)
                self.dataLength = self.dataLength-1
                data = self.datas[dindex]
            end
            local cell = CCExtendNode:create(cellSetting.size, false)
            pcall(cellSetting.cellUpdate, cell, self, data)
            local offx, offy = cellSetting.offx, cellSetting.offy
            local disx, disy = cellSetting.disx, cellSetting.disy
            local index = cellSetting.beginIndex +dindex - 1
            local rowmax = cellSetting.rowmax
                
            local off, length, endoff = 0, 0, 0
            local nsize = cellSetting.size
                
            local x, y = 0, 0
            if cellSetting.sizeChange then
                nsize = cell:getContentSize()
                local lastItem = self.items[dindex-1] or {length=0}
                if self.isX then
                    x = (lastItem.off or cellSetting.offx) + lastItem.length - cellSetting.offx + cellSetting.disx
                    y = 0
                    off = cellSetting.offx + x
                    length = nsize.width
                    endoff = cellSetting.disx/2
                else
                    x = 0
                    y = (lastItem.off or cellSetting.offy) + lastItem.length - cellSetting.offy + cellSetting.disy
                    off = cellSetting.offy + y
                    length = nsize.height
                    endoff = cellSetting.disy/2
                end
            else
                if self.isX then
                    x = math.floor(index / rowmax) * (nsize.width + cellSetting.disx) 
                    y = (index % rowmax) * (nsize.height + cellSetting.disy)
                    off = cellSetting.offx + x
                    length = nsize.width
                    endoff = cellSetting.disx/2
                else
                    x = (index % rowmax) * (nsize.width + cellSetting.disx) 
                    y = math.floor(index / rowmax) * (nsize.height + cellSetting.disy)
                    off = cellSetting.offy + y
                    length = nsize.height
                    endoff = cellSetting.disy/2
                end
            end
            cell:setAnchorPoint(General.anchorCenter)
            cell:setPosition(cellSetting.offx + x + nsize.width/2, -(y + cellSetting.offy + nsize.height/2))
            self.bg:addChild(cell)
            local newItem = {off = off, length = length, endoff = endoff, view = cell}
            self.items[dindex] = newItem
            return newItem
        end
    end
    
    function ScrollView:setDatas(cellSetting)
        self.cellSetting = cellSetting
        self.datas = cellSetting.infos
        self.dataLength = #(cellSetting.infos)
        self.delayInitCell = true
        
        cellSetting.beginIndex = cellSetting.beginIndex or 0
        cellSetting.offx = cellSetting.offx or 0
        cellSetting.offy = cellSetting.offy or 0
        cellSetting.disx = cellSetting.disx or 0
        cellSetting.disy = cellSetting.disy or 0
        cellSetting.rowmax = cellSetting.rowmax or 1
    end
    
    function UI.createScrollView(size, isX)
        return ScrollView:new(size, isX)
    end
    
    function UI.createScrollViewAuto(size, isX, params)
        local scrollView = ScrollView:new(size, isX, params.priority)
        scrollView:setDatas(params)
        scrollView:prepare()
        if params.dismovable then
            scrollView.movable = false
        end
        return scrollView
    end
end