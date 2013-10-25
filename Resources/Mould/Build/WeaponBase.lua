
WeaponHelper = {}

WeaponHelper.headPos = {[1]={x=-7, y=-26}, [2]={x=5, y=0}}

function WeaponHelper.addWeaponHead(bg, wid, scale)
	local head = UI.createSpriteWithFile("images/weapon" .. wid .. ".png")
	local p=copyData(WeaponHelper.headPos[wid])
	p.scale = scale
	screen.autoSuitable(head, p)
	bg:addChild(head)
	return head
end

function WeaponHelper.create(wid, wlevel, scene,seed, x, y)
    local winfo = StaticData.getWeaponInfo(wid)
    if wid==2 then
        --1000 height
        local weapon = MissileSplash.new(winfo.levels[wlevel].value, 200, x, y+500, x, y, winfo.range, GroupTypes.Attack, 1, wid)
	    weapon:addToScene(scene)
	elseif wid==1 then
        local a,b,c=4253,7027,9973
	    local d = (x*10000+y)%c+(seed%c)
	    local function addMissile()
	        d = (a*d+b)%c
	        local angle = math.rad(d%360)
	        d = (a*d+b)%c
	        local r = d/c*winfo.radius
	        local px, py = x+r*math.cos(angle)*scene.mapGrid.sizeX, y+r*math.sin(angle)*scene.mapGrid.sizeY
            --missile
            local weapon = MissileSplash.new(winfo.levels[wlevel].value/winfo.num, 100, px, py+600, px, py, winfo.range, GroupTypes.Attack, 1, wid)
    	    weapon:addToScene(scene)
	    end
	    scene.ground:runAction(CCRepeat:create(CCSequence:createWithTwoActions(CCCallFunc:create(addMissile),CCDelayTime:create(winfo.interval)),6))
	end
end

WeaponBase = class(BuildMould)

function WeaponBase:initWithSetting(setting)
	local dataCallList = setting.callList or {}
	self.weapons = setting.weapons or {0,0,0,0,0}
	local callList = {}
	local totalSpace = 0
	for i=1, #dataCallList do
		local winfo = StaticData.getWeaponInfo(dataCallList[i][1])
		callList[i] = {wid=winfo.wid, num=dataCallList[i][2], perTime = winfo.time}
		totalSpace = totalSpace + callList[i].num
	end
	totalSpace = totalSpace + self:getCurSpace()
	self.callList = callList
	self.totalSpace = totalSpace
	if setting.beginTime then
	    self.beginTime = timer.getTime(setting.beginTime)
	end
end

function WeaponBase:getExtendInfo()
	local callList = self.callList
	local ret = {weapons=self.weapons}
	if #callList ~= 0 then
	    local data = {}
    	for i=1, #callList do
    		data[i] = {callList[i].wid, callList[i].num}
    	end
    	ret.callList=data
    	ret.beginTime = timer.getServerTime(self.beginTime)
	end
	return ret
end

function WeaponBase:addBuildInfo(bg, addInfoItem)
    addInfoItem(bg, 1, self:getCurSpace(), nil, self.buildData.extendValue1, "Weapon")
    local temp = UI.createLabel(StringManager.getFormatString("allweapons", {num=self:getCurSpace(), max=self.buildData.extendValue1}), General.font1, 15, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=360, y=272, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    -- TODO
    infos = {}
    local off=0
    for i=1, 8 do
        infos[i] = {}
        if self.weapons[i] and self.weapons[i]>0 then
            infos[i-off].wid = i
            infos[i-off].num = self.weapons[i]
            infos[i-off].level = UserData.researchLevel[10+i]
        else
            off = off+1
        end
    end
    local scrollView = UI.createScrollViewAuto(CCSizeMake(630, 98), true, {offx=1, offy=2, disx=5, size=CCSizeMake(74,94), infos=infos, cellUpdate=UI.updateScrollItemStyle1})
    screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorTop, x=360, y=246})
    bg:addChild(scrollView.view)
    return 1, 134
end

function WeaponBase:addBuildUpgrade(bg, addUpgradeItem)
    local bdata = self.buildData
    local maxData = StaticData.getMaxLevelData(bdata.bid)
    local nextLevel = StaticData.getBuildData(bdata.bid, bdata.level+1)
    addUpgradeItem(bg, 1, bdata.extendValue1, nextLevel.extendValue1, maxData.extendValue1, "Weapon")
    
	local temp = UI.createLabel(StringManager.getString("unlockweapon"), General.font1, 15, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=360, y=272, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
	
    temp = CCNode:create()
    temp:setContentSize(CCSizeMake(74, 94))
    UI.updateScrollItemStyle1(temp, nil, {wid=self.buildLevel+1})
	screen.autoSuitable(temp, {nodeAnchor=General.anchorTop, x=360, y=247})
	bg:addChild(temp)
	return 1
end

function WeaponBase:callWeapon(wid)
    if self.totalSpace>=self.buildData.extendValue1 then
        return false
    end
    if wid>self.buildData.level then
		display.pushNotice(UI.createNotice(StringManager.getFormatString("needLevel", {level=wid, name=StringManager.getString("dataBuildName" .. self.buildData.bid)})))
	else
    	local winfo = StaticData.getWeaponInfo(wid)
		local food = winfo.levels[UserData.researchLevel[wid+10] or 1].cost
		if ResourceLogic.getResource("food")>=food then
		    ResourceLogic.changeResource("food", -food)
        	local callList = self.callList
        	local queueLength = #callList
        	local isNew = true
        	if queueLength > 0 then
        		for i = 1, queueLength do
        			if callList[i].wid == wid then
        				callList[i].num = callList[i].num+1
        				isNew = false
        				break
        			end
        		end
        	else
        		self.beginTime = timer.getTime()
        	end
        	if isNew then
        		callList[queueLength+1] = {wid=wid, num=1, perTime = winfo.time}
        	end
        	self.totalSpace = self.totalSpace + 1
	        return true
		else
			display.pushNotice(UI.createNotice(StringManager.getString("noticeTrainNoFood")))
		end
	end
	return false
end

function WeaponBase:cancelCallWeapon(wid)
	local callList = self.callList
	for i = 1, #callList do
		if callList[i].wid == wid then
			callList[i].num = callList[i].num-1
			self.totalSpace = self.totalSpace - 1
			if callList[i].num == 0 then
				table.remove(callList,i)
				if i==1 then
					self.beginTime = timer.getTime()
				end
			end
			ResourceLogic.changeResource("food", math.ceil(StaticData.getWeaponInfo(wid).levels[UserData.researchLevel[10+wid]].cost/2))
			return true
		end
	end
	return false
end

function WeaponBase:accCall()
	local t = math.ceil(self:getTotalTime())
    local cost = CrystalLogic.computeCostByTime(t)
    if CrystalLogic.changeCrystal(-cost) then
        self.beginTime = 0
        for _,w in ipairs(self.callList) do
            self.weapons[w.wid] = self.weapons[w.wid]+w.num
        end
        self.callList = {}
	    UserStat.addCrystalLog(CrystalStatType.ACC_SOLDIER, timer.getTime(), cost)
	    display.closeDialog()
	    return true
	end
	return false
end

function WeaponBase:getCurSpace()
    local ret = 0
	for i=1, #(self.weapons) do
	    ret = ret + self.weapons[i]
	end
	return ret
end

function WeaponBase:getSingleTime()
	local callList = self.callList
	if #callList > 0 then
		local ret = callList[1].perTime-(timer.getTime()-self.beginTime)
		if ret<0 then ret=0 end
		return ret
	else
		return 0
	end
end
	
function WeaponBase:getTotalTime()
	local callList = self.callList
	if #callList > 0 then
		local ttime = 0
		for i = 1, #callList do
			local c = callList[i]
			ttime = ttime + c.num * c.perTime
		end
		ttime = ttime - (callList[1].perTime - self:getSingleTime())
		return ttime
	else
		return 0
	end
end

function WeaponBase:addChildMenuButs(buts)
	table.insert(buts, {image="images/menuItemWeapon.png", text=StringManager.getString("labelCreate"), callback=WeaponDialog.show, callbackParam=self})
end

function WeaponBase:getBuildView()
	local bid = self.buildData.bid
	local level = self.buildData.level
	
	local frame = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("build" .. bid .. "_1.png")
	if not frame then
		CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
	    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("images/build/build" .. bid .. ".plist")
		CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
	end
	local build = CCSpriteBatchNode:create("images/build/build" .. bid .. ".png", 4)
	local temp = UI.createSpriteWithFrame("build" .. bid .. "_" .. level .. ".png")
	local ssize = temp:getContentSize()
	build:setContentSize(ssize)
	local w = ssize.width/2
	screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=w})
	build:addChild(temp)
	
	temp = UI.createSpriteWithFrame("build" .. bid .. "_action1.png")
	screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=w})
	build:addChild(temp, -1, TAG_ACTION)
	
	temp = UI.createSpriteWithFrame("build" .. bid .. "_" .. level .. "light.png")
	screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=w})
	build:addChild(temp, 1, TAG_LIGHT)
	
    temp = build
    build = CCNode:create()
    build:setContentSize(ssize)
    screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=temp:getContentSize().width/2, y=0})
    build:addChild(temp, 0, TAG_SPECIAL)
	
	return build
end

function WeaponBase:getDoorPosition()
    return {81, 38}
end

function WeaponBase:updateOperationLogic()
    local temp
	local trainLight = self.buildView.build:getChildByTag(TAG_LIGHT)
	if #(self.callList)>0 then
	    --[[
	    if not trainLight then

    		trainLight = UI.createSpriteWithFile("images/build/" .. self.buildData.bid .. "/WeaponBaseLight1.png")
    		screen.autoSuitable(trainLight,{nodeAnchor=General.anchorLeftBottom, x=self.buildView.build:getContentSize().width/2+23, y=13})
    		self.buildView.build:addChild(trainLight, 10, TAG_LIGHT)
    		
    		local array = CCArray:create()
    		array:addObject(CCFadeOut:create(1))
    		array:addObject(CCFadeIn:create(1))
    		trainLight:runAction(CCRepeatForever:create(CCSequence:create(array)))
	    end
	    --]]
		local perTime = self.callList[1].perTime
		local wid = self.callList[1].wid
		if not self.buildView.timeProcess then
			self.buildView:createTimeProcess("images/buildItemTrainFiller.png", self.beginTime+perTime, perTime)
			self.noticeWid = nil
		else
		    while perTime>0 and self.beginTime+perTime <= timer.getTime() do
		        self.beginTime = self.beginTime + perTime
		        self.callList[1].num = self.callList[1].num-1
		        self.weapons[self.callList[1].wid] = self.weapons[self.callList[1].wid]+1
		        if self.callList[1].num==0 then
		            table.remove(self.callList, 1)
		            if #(self.callList)==0 then
		                perTime=0
		                wid = self.noticeWid
		            else
		                perTime = self.callList[1].perTime
		                wid = self.callList[1].wid
		            end
		        end
    			self.buildView.timeProcess.totalTime = perTime
    			self.buildView.timeProcess.endTime = self.beginTime + perTime
    		end
		end
		if self.noticeWid ~= wid then
		    self.noticeWid = wid
		    local tag = 101
		    temp = self.buildView.timeProcess.view:getChildByTag(tag)
		    if temp then
		        temp:removeFromParentAndCleanup(true)
		    end
		    temp = UI.createSpriteWithFile("images/dialogItemTrainButtonB.png", CCSizeMake(79, 75))
		    WeaponHelper.addWeaponHead(temp, wid, 0.66)
		    screen.autoSuitable(temp, {nodeAnchor=General.anchorRight, x=-15, y=self.buildView.timeProcess.view:getContentSize().height/2})
		    self.buildView.timeProcess.view:addChild(temp, 0, tag)
		end
		if self.buildView.notice then
			self.buildView.notice:removeFromParentAndCleanup(true)
			self.buildView.notice = nil
		end
	end
	if #(self.callList)==0 then
	    if trainLight then
	        trainLight:removeFromParentAndCleanup(true)
	    end
		if self.buildView.timeProcess then
		    self.noticeWid = nil
			self.buildView.timeProcess.view:removeFromParentAndCleanup(true)
			self.buildView.timeProcess = nil
		end
		if self.totalSpace>=self.buildData.extendValue1 then
		    if self.buildView.notice then
		        self.buildView:showNotice("", 0.7)
		    end
		else
		    local text = StringManager.getString("labelCreate")
    		if not self.buildView.notice or self.buildView.noticeText~=text then
    			self.buildView:showNotice(text, 0.7)
    		end
		end
	end
end

function WeaponBase:getBuildShadow()
end
