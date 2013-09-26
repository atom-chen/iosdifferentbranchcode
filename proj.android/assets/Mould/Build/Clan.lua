Clan = class(BuildMould)

function Clan:ctor(bid, setting)
    self.level0shadow = true
    if setting.t then
        self.requestTime = timer.getTime(setting.t)
    end
    if setting.ts then
        self.troops = setting.ts
    end
    self.receiveNum = setting.n or 0
end

function Clan:addBuildInfo(bg, addInfoItem)
    if self.buildLevel==0 then return 0 end
    addInfoItem(bg, 1, self:getCurSpace(), nil, self.buildData.extendValue1, "Camp")
    local temp = UI.createLabel(StringManager.getString("alltroops"), General.font1, 15, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=360, y=272, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    -- TODO
    smap = {}
    if self.troops then
        for _, s in ipairs(self.troops) do
            local id, level = s[1], s[2]
            if smap[id] then
                smap[id].num = smap[id].num+1
            else
                smap[id] = {bid=id, num=1, level=level}
            end
        end
    end
    
    infos = {}
    local off=0
    for i=1, 10 do
        infos[i] = {}
        if smap[i] then
            infos[i-off] = smap[i]
        else
            off = off+1
        end
    end
    local scrollView = UI.createScrollViewAuto(CCSizeMake(630, 98), true, {offx=1, offy=2, disx=5, size=CCSizeMake(74,94), infos=infos, cellUpdate=UI.updateScrollItemStyle1})
    screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorTop, x=360, y=246})
    bg:addChild(scrollView.view)
    return 1, 134
end

function Clan:addBuildUpgrade(bg, addUpgradeItem)
	local bdata = self.buildData
	local maxData = StaticData.getMaxLevelData(bdata.bid)
	local nextLevel = StaticData.getBuildData(bdata.bid, bdata.level+1)
	
	addUpgradeItem(bg, 1, bdata.extendValue1, nextLevel.extendValue1, maxData.extendValue1, "Camp")
	return 1
end

function Clan:getExtendInfo()
    local ret = {n=self.receiveNum}
    if self.requestTime then
        ret.t = timer.getServerTime(self.requestTime)
    end
    if self.troops and #(self.troops)>0 then
        ret.ts = self.troops
    end
	return ret
end

function Clan:addChildMenuButs(buts)
	if UserData.clan~=0 then
	    if self.requestTime and self.requestTime>timer.getTime()-1200 then
    		table.insert(buts, {image="images/menuItemRequest.png", callback=doNothing, callbackParam=self, extend={time=self.requestTime+1200-timer.getTime(), background="images/dialogItemC.png", text=StringManager.getString("labelNextRequest")}})
    	else
    		table.insert(buts, {image="images/menuItemRequest.png", text=StringManager.getString("buttonRequest"), callback=self.requestTroops, callbackParam=self})
    	end
	end
	table.insert(buts, {image="images/menuItemLeague.png", text=StringManager.getString("buttonLeague"), callback=display.showDialog, callbackParam=ClanDialog})
end

function Clan:getCurSpace()
    local curspace = 0
    if self.troops then
        for _, s in ipairs(self.troops) do
            print("test", json.encode(s))
            curspace = curspace + StaticData.getSoldierInfo(s[1]).space
        end
    end
    return curspace
end

function Clan:requestTroops()
    self.requestTime = timer.getTime()
    self.receiveNum = 0
	network.httpRequest(network.chatUrl .. "request", doNothing, {params={uid=UserData.userId, cid=UserData.clan, name=UserData.userName, space=self:getCurSpace(), max=self.buildData.extendValue1}})
	--EventManager.sendMessage("EVENT_OTHER_OPERATION", {type="Add", key="donate"})
	self.buildView:setFocus(false)
end

function Clan:updateOperationLogic(diff)
    if UserData.clanTroops then
        local l = #(UserData.clanTroops)
        while l>self.receiveNum do
            self.receiveNum = self.receiveNum+1
            if not self.troops then
                self.troops = {}
            end
            table.insert(self.troops, {UserData.clanTroops[self.receiveNum][2], UserData.clanTroops[self.receiveNum][3]})
            local sname = StringManager.getString("dataSoldierName" .. UserData.clanTroops[self.receiveNum][2])
            display.pushNotice(UI.createNotice(StringManager.getFormatString("noticeRecvDonate", {name=sname}),255))
        end
    end
    if UserData.clan==0 then
        self.receiveNum = 0
        self.requestTime = nil
        UserData.clanTroops = nil
        if self.buildView and self.buildView.clanIcon then
            self.buildView.clanIcon:removeFromParentAndCleanup(true)
            self.buildView.clanIcon = nil
        end
    else
        if self.buildView and not self.buildView.clanIcon then
            self.buildView.clanIcon = UI.createSpriteWithFile("images/leagueIcon/" .. UserData.clanInfo[2] .. ".png",CCSizeMake(61, 69))
            screen.autoSuitable(self.buildView.clanIcon, {nodeAnchor=General.anchorBottom, x=self.buildView.view:getContentSize().width/2, y=70})
            self.buildView.view:addChild(self.buildView.clanIcon, 10)
        end
    end
end

function Clan:getBuildView()
	local bid = self.buildData.bid
	local level = self.buildData.level
	
	local build  = UI.createSpriteWithFile("images/build/" .. bid .. "/league" .. level .. ".png")
	return build
end

function Clan:changeNightMode(isNight)
	local bid = self.buildData.bid
	local build = self.buildView.build
	if self.buildLevel<3 or not build then return end
	if isNight then
		local ox = build:getContentSize().width/2

        local sp = {nodeAnchor=General.anchorBottom, x=ox, y=49}
        
		local light = UI.createSpriteWithFile("images/build/" .. bid .. "/leagueLight3.png")
		screen.autoSuitable(light, sp)
		build:addChild(light, 10, TAG_LIGHT)
	else
		local light = build:getChildByTag(TAG_LIGHT)
		if light then
			light:removeFromParentAndCleanup(true)
		end
	end
end

function Clan:getLevel0Build()
	local gsize = self.buildData.gridSize
	local temp = UI.createSpriteWithFile("images/build/2/league0.png")
	screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=138, y=getParam("buildViewOffy2", 0)})

    local build = temp

	return temp
end

function Clan:rebuilt()
    local data = StaticData.getBuildData(self.buildData.bid, 1)
    if ResourceLogic.checkAndCost(data, self.rebuilt, self) then
		self:upgradeOver()
		self.buildView.state.movable = true
		if self.buildView.state.isFocus then
		    self.buildView:setFocus(false)
		end
	end
end

function Clan:getBuildShadow()
    return self:getShadow("images/shadowGrid.png", -106, 23, 212, 163)
end

ClanTomb = class(BuildMould)

function ClanTomb:ctor(bid, setting)
    self.buildData = {bid=bid, level=1, hitPoints=0, gridSize=2, soldierSpace=1}
    self.icon = setting.icon
end

function ClanTomb:getBuildView()
	local build = UI.createSpriteWithFrame("clanTomb.png")
	
    local clanIcon = UI.createSpriteWithFile("images/leagueIcon/" .. self.icon .. ".png",CCSizeMake(38, 43))
    screen.autoSuitable(clanIcon, {nodeAnchor=General.anchorBottom, x=build:getContentSize().width/2, y=49})
    build:addChild(clanIcon, 10)
	return build
end

function ClanTomb:updateBattle(diff)
    if self.buildView.scene.isReplay then return end
    if #(BattleLogic.clanTroops)>0 then
        local soldier = table.remove(BattleLogic.clanTroops, 1)
        local s = SoldierHelper.create(soldier[1], {isFighting=true, level=soldier[2]})

    	local x, y = s:getMoveArroundPosition(self)
    	x, y = math.floor(x), math.floor(y)
    	s:addToScene(self.buildView.scene, {x, y})
    	table.insert(self.buildView.scene.soldiers, s)
    	s:playAppearSound()
    	table.insert(ReplayLogic.cmdList, {math.floor((timer.getTime()-ReplayLogic.beginTime)*1000)/1000, "s", soldier[1], x, y, soldier[2]})
    	--BattleLogic.incSoldier(item.id)
    end
end

--²»Òªµ×²¿Í¼Æ¬
function ClanTomb:getBuildBottom()
end