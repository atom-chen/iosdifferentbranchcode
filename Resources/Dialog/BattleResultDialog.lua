BattleResultDialog = class()

function BattleResultDialog:enterReplayScene()
    if self.lock then return end
    if self.synOver then
        self.lock = true
    	ReplayLogic.isZombie = false
    	display.runScene(ReplayScene.new(), PreBattleScene)
    	UserStat.stat(UserStatType.BATTLE_END_VIDEO)
    else
        self.replayButtonDown = true
    end
end

function BattleResultDialog:ctor(result)

    music.playBackgroundMusic(nil)
    music.playEffect("music/afterBattle.mp3")

	self.view = CCNode:create()
	self.view:setContentSize(General.winSize)
	screen.autoSuitable(self.view, {screenAnchor=General.anchorCenter})
	local temp
	local array
	
	CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_A8)
	temp = UI.createSpriteWithFile("images/dialogItemBattleResultBg.png",CCSizeMake(1024, 496))
	CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
	screen.autoSuitable(temp, {screenAnchor=General.anchorLeftBottom, x=0, y=0, scaleType=screen.SCALE_WIDTH_FIRST})
	self.view:addChild(temp)
	temp = UI.createButton(CCSizeMake(70, 73), self.enterReplayScene, {callbackParam=self, image="images/battleEndVideo.png"})
	screen.autoSuitable(temp, {screenAnchor=General.anchorRightBottom, nodeAnchor=General.anchorCenter, x=-80, y=70, scaleType=screen.SCALE_NORMAL})
	self.view:addChild(temp)
	temp = UI.createLabel(StringManager.getString("labelBattleEndVideo"), General.font1, 15, {colorR = 255, colorG = 255, colorB = 255})
	screen.autoSuitable(temp, {screenAnchor=General.anchorRightBottom, x=-10, y=21, nodeAnchor=General.anchorRight, scaleType=screen.SCALE_NORMAL})
	self.view:addChild(temp)

	local bg = nil
	bg = CCNode:create()
	bg:setContentSize(CCSizeMake(1024, 768))
	screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType=screen.SCALE_CUT_EDGE})
	self.view:addChild(bg)
	
	local s = bg:getScale()
	bg:setScale(0.5*s)
	bg:runAction(CCEaseBackOut:create(CCScaleTo:create(0.1, s, s)))
	
	local numberToTime = getParam("actionTimeNumberTo", 1000)/1000
	
	temp = UI.createButton(CCSizeMake(169, 65), self.endBattle, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonReturnHome"), fontSize=22+BIGGER_SIZE_OFF, fontName=General.font3, lineOffset=-12})
	screen.autoSuitable(temp, {x=512, y=133, nodeAnchor=General.anchorCenter})
	bg:addChild(temp)
	
	if BattleLogic.isGuide then
        temp = UI.createGuidePointer(90)
        temp:setPosition(600, 133)
        bg:addChild(temp)
	end
	temp = UI.createLabel(StringManager.getString("labelGot"), General.font1, 15, {colorR = 255, colorG = 255, colorB = 255})
	screen.autoSuitable(temp, {x=512, y=439, nodeAnchor=General.anchorCenter})
	bg:addChild(temp)
	temp = UI.createLabel(StringManager.getString("labelLost"), General.font1, 15, {colorR = 255, colorG = 255, colorB = 255})
	screen.autoSuitable(temp, {x=512, y=260, nodeAnchor=General.anchorCenter})
	bg:addChild(temp)
	
	local keys = {"food", "oil", "score"}
	for i=1, 3 do
		local key = keys[i]
		
		temp = UI.createLabel("0", General.font4, 30, {colorR = 255, colorG = 255, colorB = 255})
		screen.autoSuitable(temp, {x=524, y=458-53*i, nodeAnchor=General.anchorRight})
		bg:addChild(temp)
		temp:runAction(CCNumberTo:create(numberToTime, 0, result[key], "", ""))
		temp = UI.createScaleSprite("images/" .. key .. ".png",CCSizeMake(60, 36))
		screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=554, y=443-53*i})
		bg:addChild(temp)
		temp = UI.createSpriteWithFile("images/dialogItemBattleResultSeperator.png",CCSizeMake(665, 2))
		screen.autoSuitable(temp, {nodeAnchor=General.anchorBottom, x=512, y=433-53*i})
		bg:addChild(temp)
		if i<3 then
			ResourceLogic.changeResource(key, result[key])
		else
			UserData.userScore = UserData.userScore + result[key]
			EventManager.sendMessage("EVENT_OTHER_OPERATION", {type="Set", key="score", value=UserData.userScore})
		end
	end
	
	local items = {}
	local costTroops = result.costTroops
	for i=1, 10 do
	    if costTroops[i]>0 then
	        table.insert(items, {i, costTroops[i], UserData.researchLevel[i]})
	    end
	end
	for i=1, 5 do
	    if result.costWeapons[i]>0 then
	        table.insert(items, {i+10, result.costWeapons[i], UserData.researchLevel[i+10]})
	    end
	end
	local checkSyncError = SoldierLogic.deploySoldier(costTroops) or BattleLogic.costWeapon(result.costWeapons)
	if result.zombieDeployed then
	    table.insert(items, {0,0})
	    SoldierLogic.deployZombies()
	end
	if result.clanDeployed then
	    table.insert(items, {0,UserData.clanInfo[2]})
	end
	local len = #items
	local bx = 454-26*len
	for i=1, len do
		local cell = CCNode:create()
		cell:setContentSize(CCSizeMake(48, 63))
		screen.autoSuitable(cell, {x=bx+52*i, y=179})
		bg:addChild(cell)
		if items[i] then
			temp = UI.createSpriteWithFile("images/dialogItemBattleResultItemB.png",CCSizeMake(48, 63))
			screen.autoSuitable(temp, {x=0, y=0})
			cell:addChild(temp)
			if items[i][1]>0 then
			    if items[i][1]<=10 then
        			SoldierHelper.addSoldierHead(cell, items[i][1], 0.42)
        	    elseif items[i][1]<=15 then
        			WeaponHelper.addWeaponHead(cell, items[i][1]-10, 0.42)
        	    end
        		temp = UI.createStar(items[i][3], 11, 9)
        		screen.autoSuitable(temp, {x=2, y=3})
        		cell:addChild(temp)
    			temp = UI.createLabel("x" .. items[i][2], General.font4, 15, {colorR = 255, colorG = 121, colorB = 123})
    			screen.autoSuitable(temp, {x=6, y=55, nodeAnchor=General.anchorLeft})
    			cell:addChild(temp)
    		elseif items[i][2]==0 then
    		    temp = UI.createSpriteWithFile("images/zombieTombIcon.png",CCSizeMake(24, 47))
                screen.autoSuitable(temp, {x=12, y=3})
                cell:addChild(temp)
            else
    		    temp = UI.createSpriteWithFile("images/leagueIcon/" .. items[i][2] .. ".png",CCSizeMake(32, 37))
                screen.autoSuitable(temp, {x=8, y=8})
                cell:addChild(temp)
    		end
		else
			temp = UI.createSpriteWithFile("images/dialogItemBattleResultItemB.png",CCSizeMake(48, 63))
			screen.autoSuitable(temp, {x=0, y=0})
			cell:addChild(temp)
		end
	end

	temp = UI.createSpriteWithFile("images/battleEndLight.png")
	temp:setScale(7.5)
	temp:setOpacity(128)
	screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=512, y=545})
	bg:addChild(temp)
	temp:runAction(CCRepeatForever:create(CCRotateBy:create(1, 20)))
	temp = UI.createSpriteWithFile("images/battleEndRibbon.png",CCSizeMake(605, 197))
	screen.autoSuitable(temp, {x=207, y=410})
	bg:addChild(temp)
	if result.stars>0 then
		temp = UI.createLabel(StringManager.getString("labelVictory"), General.font3, 35, {colorR = 97, colorG = 255, colorB = 49})
		screen.autoSuitable(temp, {x=512, y=516, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
	else
		temp = UI.createLabel(StringManager.getString("labelDefeat"), General.font3, 35, {colorR = 255, colorG = 97, colorB = 49})
		screen.autoSuitable(temp, {x=512, y=516, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
	end
	temp = UI.createSpriteWithFile("images/battleStar1.png",CCSizeMake(139, 131))
	screen.autoSuitable(temp, {x=317, y=515})
	bg:addChild(temp)
	temp = UI.createSpriteWithFile("images/battleStar1.png",CCSizeMake(193, 183))
	screen.autoSuitable(temp, {x=413, y=534})
	bg:addChild(temp)
	temp = UI.createSpriteWithFile("images/battleStar1.png",CCSizeMake(139, 131))
	screen.autoSuitable(temp, {x=566, y=517})
	bg:addChild(temp)
	if result.stars>=1 then
		temp = UI.createSpriteWithFile("images/battleStar0.png",CCSizeMake(142, 133))
		screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=388, y=581})
		bg:addChild(temp)
		local sx, sy = temp:getScaleX(), temp:getScaleY()
		temp:setScale(0)
		array=CCArray:create()
		array:addObject(CCDelayTime:create(0.1))
		array:addObject(CCEaseBackOut:create(CCScaleTo:create(0.3, sx, sy)))
		temp:runAction(CCSequence:create(array))
		if result.stars>=2 then
			temp = UI.createSpriteWithFile("images/battleStar0.png",CCSizeMake(196, 185))
			screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=512, y=625})
			bg:addChild(temp,1)
			temp:setScale(0)
			array=CCArray:create()
			array:addObject(CCDelayTime:create(0.4))
			array:addObject(CCEaseBackOut:create(CCScaleTo:create(0.3, 1, 1)))
			temp:runAction(CCSequence:create(array))
			if result.stars==3 then
				temp = UI.createSpriteWithFile("images/battleStar0.png",CCSizeMake(142, 133))
				screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=637, y=581})
				bg:addChild(temp)
				temp:setScale(0)
				array=CCArray:create()
				array:addObject(CCDelayTime:create(0.7))
				array:addObject(CCEaseBackOut:create(CCScaleTo:create(0.3, sx, sy)))
				temp:runAction(CCSequence:create(array))
			end
		end
	end
	temp = UI.createLabel(StringManager.getString("damagePercent"), General.font2, 15+NORMAL_SIZE_OFF, {colorR = 255, colorG = 255, colorB = 255})
	screen.autoSuitable(temp, {x=512, y=630, nodeAnchor=General.anchorCenter})
	bg:addChild(temp, 2)
	temp = UI.createLabel("0%", General.font4, 25, {colorR = 111, colorG = 164, colorB = 74})
	screen.autoSuitable(temp, {x=512, y=600, nodeAnchor=General.anchorCenter})
	bg:addChild(temp, 2)
	temp:runAction(CCNumberTo:create(numberToTime, 0, result.percent, "", "%"))
    
    if (not BattleLogic.isReverge or BattleLogic.isLeagueBattle) and UserData.enemyId==nil then
        checkSyncError = true
    end
	if not checkSyncError then
    	EventManager.sendMessage("EVENT_BATTLE_END", result)
    	
    	-- begin syn network
    	local update = {}
    	local deleted = result.costTraps
    	local hits = {}
    	local scene = display.getCurrentScene()
    	for id, buildData in pairs(result.resourceBuilds) do
    	    local b = scene.builds[id]
    	    if buildData.resources and b.buildData.bid~=TOWN_BID and b.getExtendInfo then
    	        local ext = b:getExtendInfo()
    	        ext.resource = ext.resource - math.floor(buildData.resources[b.resourceType]*(1-buildData.hitpoints/buildData.max))
    	        table.insert(update, {id, json.encode(ext)})
    	    end
    	    if buildData.hitpoints<buildData.max then
    	        table.insert(hits, {id, buildData.hitpoints})
    	    end
    	end
    	local params = {}
        if not BattleLogic.isLeagueBattle then
        	if #update>0 then
        	    params.eupdate = json.encode(update)
        	end
        	if #deleted>0 then
        	    params.delete = json.encode(deleted)
        	end
        	if #hits>0 then
        	    params.hits = json.encode(hits)
        	end
        	params.isReverge = BattleLogic.isReverge
        	BattleLogic.isReverge = nil
        	local hitem = {-result.score, result.stars, result.percent, UserData.userScore, result.food, result.oil, UserData.userName, items}
        	if UserData.clan>0 then
        	    hitem[9] = UserData.clanInfo[2]
        	    hitem[10] = UserData.clanInfo[5]
        	end
    	    params.history = json.encode(hitem)
    	    params.score = -result.score
    	    params.shieldTime = timer.getServerTime(result.shieldTime)
    	else
    	    params.isLeague = 1
    	    params.lscore = 0
    	    if result.stars>0 then
    	        params.lscore = BattleLogic.enemyMtype*2+1
    	        UserData.clanInfo[3] = UserData.clanInfo[3]+params.lscore
    	    end
    	    params.cid = UserData.clan
    	    params.bid = BattleLogic.leagueBattleId
    	    params.ecid = BattleLogic.enemyClan
    	end
    	params.replay = json.encode({seed=ReplayLogic.randomSeed, data=ReplayLogic.buildData, cmdList=ReplayLogic.cmdList})
    	params.uid = UserData.userId
    	if params.isReverge and not BattleLogic.isLeagueBattle then
            params.eid = BattleLogic.enemyId
            BattleLogic.revergeItem.revenged = true
            BattleLogic.revergeItem = nil
        else
        	params.eid = UserData.enemyId
            UserData.enemyId = nil
        end
    	-- shieldTime
        network.httpRequest("synBattleData", self.synBattleDone, {isPost=true, params=params}, self)
        for key, value in pairs(params) do
            print(key, value)
        end
        
        --syn score to rank
        if not BattleLogic.isLeagueBattle then
            network.httpRequest(network.scoreUrl .. "updateScore", doNothing, {params={uid=UserData.userId, score=UserData.userScore}})
            network.httpRequest(network.scoreUrl .. "updateScore", doNothing, {params={uid=params.eid, score=UserData.enemyScore-result.score}})
        else
            BattleLogic.isLeagueBattle = nil
    		UserData.shouldOpenLeagueWar = true
        end
    	UserStat.stat(UserStatType.BATTLE_END)
    else
        if display.getCurrentScene(0) then
            display.getCurrentScene(0).synOver = false
        end
    end
end

function BattleResultDialog:endBattle()
    if self.lock then return end
    if self.synOver then
        self.lock = true
    	display.popScene(PreBattleScene)
    	self.synOver = false
    else
        self.endButtonDown = true
    end
end

function BattleResultDialog:synBattleDone()
    if self.endButtonDown then
    	display.popScene(PreBattleScene)
    	SoldierLogic.isInit = true
    elseif self.replayButtonDown then
    	ReplayLogic.isZombie = false
    	display.runScene(ReplayScene.new(), PreBattleScene)
    	UserStat.stat(UserStatType.BATTLE_END_VIDEO)
    else
        self.synOver = true
    end
end
