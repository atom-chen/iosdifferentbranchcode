ResearchDialog = {}

do
	local showMainTab
	
	local function accResearch(force)
	    local leftTime = UserData.researchItem.endTime - timer.getTime()
	    local cost = CrystalLogic.computeCostByTime(leftTime)
	    if force then
	        if CrystalLogic.changeCrystal(-cost) then
	            UserData.researchItem.endTime = 0
	        end
	    else
	        local name = StringManager.getString("dataSoldierName" .. UserData.researchItem.rid)
	        display.showDialog(AlertDialog.new(StringManager.getString("alertTitleFinish"), StringManager.getFormatString("alertTextFinishUpgrade", {num=cost, name=name}), {callback=accResearch, param=true, crystal=cost}))
	    end
	end
	
	local function showResearchingTab(bg)
	    bg:removeAllChildrenWithCleanup(true)
        local temp = nil
        temp = CCNode:create()
        temp:setContentSize(CCSizeMake(119, 114))
        screen.autoSuitable(temp, {x=155, y=185})
        bg:addChild(temp)
        local temp1 = UI.createSpriteWithFile("images/dialogItemTrainButton.png",CCSizeMake(119, 114))
        screen.autoSuitable(temp1)
        temp:addChild(temp1)
        SoldierHelper.addSoldierHead(temp, UserData.researchItem.rid)
        
        --{x=407, y=159}
        temp = UI.createButton(CCSizeMake(163, 63), accResearch, {image="images/buttonGreen.png"})
        screen.autoSuitable(temp, {x=489, y=191, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp1 = UI.createSpriteWithFile("images/crystal.png",CCSizeMake(51, 49))
        screen.autoSuitable(temp1, {x=105, y=8})
        temp:addChild(temp1)
        local leftTime = UserData.researchItem.endTime - timer.getTime()
        local costLabel = UI.createLabel(tostring(CrystalLogic.computeCostByTime(leftTime)), General.font4, 36, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
        screen.autoSuitable(costLabel, {x=98, y=31, nodeAnchor=General.anchorRight})
        temp:addChild(costLabel)
        local timeLabel = UI.createLabel(StringManager.getTimeString(leftTime), General.font4, 28, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
        screen.autoSuitable(timeLabel, {x=489, y=281, nodeAnchor=General.anchorCenter})
        bg:addChild(timeLabel)
        temp = UI.createLabel(StringManager.getString("labelTotalTime"), General.font1, 18, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=489, y=317, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("labelFinishResearch"), General.font1, 18, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=489, y=241, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("titleResearching"), General.font3, 28, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        
        local function update(diff)
            leftTime = UserData.researchItem.endTime - timer.getTime()
            timeLabel:setString(StringManager.getTimeString(leftTime))
            costLabel:setString(tostring(CrystalLogic.computeCostByTime(leftTime)))
            if leftTime<0 then
                display.closeDialog()
            end
        end
        simpleRegisterEvent(bg, {update={callback=update, inteval=1}})
	end
	
	local function upgradeResearch(param)
	    local rinfo = param.rinfo
	    if ResourceLogic.checkAndCost({costType="food", costValue=rinfo.cost}, upgradeResearch, param) then
    		UserData.researchItem={rid=rinfo.id, endTime=timer.getTime() + rinfo.time}
    		showResearchingTab(param.bg)
    	end
	end
	
	local function showSoldierUpgradeTab(param)
		local labLevel = display.getCurrentScene():getMaxLevel(1002)
		local bg, temp = param.bg, nil
		local lid = param.id
		local slevel = UserData.researchLevel[lid]
		local rinfo = StaticData.getResearchInfo(lid, slevel+1)
		if not rinfo then
			display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorResearchMax")))
	    elseif rinfo.requireLevel>labLevel then
			display.pushNotice(UI.createNotice(StringManager.getFormatString("needLevel", {level=rinfo.requireLevel, name=StringManager.getString("dataBuildName1002")})))
		else
			bg:removeAllChildrenWithCleanup(true)
			temp = UI.createLabel(StringManager.getFormatString("titleUpgrade", {level=slevel+1}), General.font3, 30)
			screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=360, y=489})
			bg:addChild(temp)
			
    		local sinfo = StaticData.getSoldierInfo(lid)
    		local sdata = StaticData.getSoldierData(lid, slevel)
    		local ndata = StaticData.getSoldierData(lid, slevel+1)
    		local mdata = StaticData.getSoldierData(lid, sinfo.levelMax)
    		
    		temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    		screen.autoSuitable(temp, {x=36, y=22})
    		bg:addChild(temp)
    		
    		temp = UI.createButton(CCSizeMake(107, 49), showMainTab, {callbackParam=bg, image="images/buttonBack.png"})
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=70, y=488})
    		bg:addChild(temp)
    		
    		SoldierHelper.addSoldierFeature(bg, lid)
    		
    		UI.addInfoItem(bg, 1, sdata.dps, ndata.dps, mdata.dps, "Dps")
    		UI.addInfoItem(bg, 2, sdata.hitpoints,ndata.hitpoints, mdata.hitpoints, "Hitpoints")
    		UI.addInfoItem(bg, 3, sdata.cost, ndata.cost, mdata.cost, "TrainFood", "images/food.png")
    		
    		for i=1, 6 do
    			temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(300, 2))
    			screen.autoSuitable(temp, {x=371, y=307-i*29})
    			bg:addChild(temp)
    		end
    		
    		local colorProperty = {colorR = 33, colorG = 93, colorB = 165}
    		temp = UI.createLabel(StringManager.getString("propertyFavorite"), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=280})
    		bg:addChild(temp)
    		temp = UI.createLabel(StringManager.getString("propertyDamageType"), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=251})
    		bg:addChild(temp)
    		temp = UI.createLabel(StringManager.getString("propertyTargets"), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=222})
    		bg:addChild(temp)
    		temp = UI.createLabel(StringManager.getString("propertyHouseSpace"), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=193})
    		bg:addChild(temp)
    		temp = UI.createLabel(StringManager.getString("propertyTrainTime"), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=164})
    		bg:addChild(temp)
    		temp = UI.createLabel(StringManager.getString("propertyMoveSpeed"), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=135})
    		bg:addChild(temp)
    		
    		colorProperty = {colorR = 0, colorG = 0, colorB = 0}
    		
    		local tempStr
    		
    		tempStr = StringManager.getString("dataBuildType" .. sinfo.favorite)
    		if sinfo.favoriteRate > 1 then
    			tempStr = tempStr .. StringManager.getFormatString("favoriteRate", {rate=sinfo.favoriteRate})
    		end
    		temp = UI.createLabel(tempStr, General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=280})
    		bg:addChild(temp)
    		
    		if sinfo.damageRange>0 then
    			tempStr = StringManager.getString("typeDamageTypeArea")
    		else
    			tempStr = StringManager.getString("typeDamageTypeSingle")
    		end
    		temp = UI.createLabel(tempStr, General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=251})
    		bg:addChild(temp)
    		
    		if sinfo.attackType==2 then
    			tempStr = StringManager.getString("typeTargets3")
    		else
    			tempStr = StringManager.getString("typeTargets1")
    		end
    		temp = UI.createLabel(tempStr, General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=222})
    		bg:addChild(temp)
    		
    		temp = UI.createLabel(tostring(sinfo.space), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=193})
    		bg:addChild(temp)
    		temp = UI.createLabel(StringManager.getTimeString(sinfo.time), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=164})
    		bg:addChild(temp)
    		temp = UI.createLabel(tostring(sinfo.moveSpeed), General.font1, 15, colorProperty)
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=135})
    		bg:addChild(temp)
    		--
            
    		temp = UI.createButton(CCSizeMake(169, 76), upgradeResearch, {callbackParam={rinfo=rinfo, bg=bg}, image="images/buttonGreen.png"})
    		screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=507, y=67})
    		bg:addChild(temp)
    		local colorSetting = {colorR=255, colorG=255, colorB=255, lineOffset=-12}
    		if ResourceLogic.getResource("food")<rinfo.cost then
    		    colorSetting.colorG=0
    		    colorSetting.colorB=0
    		end
    		local temp1 = UI.createScaleSprite("images/food.png",CCSizeMake(50, 38))
            screen.autoSuitable(temp1, {nodeAnchor=General.anchorCenter, x=143, y=38})
            temp:addChild(temp1)
    		temp1 = UI.createLabel(tostring(rinfo.cost), General.font4, 22, colorSetting)
    		screen.autoSuitable(temp1, {nodeAnchor=General.anchorRight, x=118, y=38})
    		temp:addChild(temp1)
            
            temp = UI.createSpriteWithFile("images/dialogItemUpgradeTimeBg.png",CCSizeMake(112, 50))
            screen.autoSuitable(temp, {x=28, y=31})
            bg:addChild(temp)
            temp = UI.createLabel(StringManager.getTimeString(rinfo.time), General.font4, 18, {colorR = 255, colorG = 255, colorB = 255})
            screen.autoSuitable(temp, {x=84, y=46, nodeAnchor=General.anchorCenter})
            bg:addChild(temp)
            temp = UI.createLabel(StringManager.getString("labelUpgradeTime"), General.font1, 11, {colorR = 77, colorG = 66, colorB = 27})
            screen.autoSuitable(temp, {x=84, y=67, nodeAnchor=General.anchorCenter})
            bg:addChild(temp)
		end
	end
	
	showMainTab = function(bg)
		local temp = nil
		bg:removeAllChildrenWithCleanup(true)
		
		temp = UI.createLabel(StringManager.getString("titleResearch"), General.font3, 28)
		screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		
		local barrackLevel = display.getCurrentScene():getMaxLevel(1001)
		local labLevel = display.getCurrentScene():getMaxLevel(1002)
		
		for i=1, 15 do
			local item
			if i<=10 then
				if i>barrackLevel then
					item = UI.createSpriteWithFile("images/dialogItemUnlock.png", CCSizeMake(117, 114))
				else
					item = UI.createButton(CCSizeMake(117, 114), showSoldierUpgradeTab, {callbackParam={bg=bg, id=i}, image="images/dialogItemTrainButton.png", useExtendNode=true})
					SoldierHelper.addSoldierHead(item, i, 1)
					
					local sinfo = StaticData.getSoldierInfo(i)
					local slevel = UserData.researchLevel[i]
					local rinfo = StaticData.getResearchInfo(i, slevel+1)
					
					temp = CCNode:create()
					temp:addChild(UI.createStar(slevel, 17, 18))
					screen.autoSuitable(temp, {x=8, y=88})
					item:addChild(temp)
					
					temp = UI.createSpriteWithFile("images/dialogItemPriceBg.png",CCSizeMake(101, 27))
					screen.autoSuitable(temp, {x=7, y=7})
					item:addChild(temp)
					if not rinfo then
						temp =  UI.createLabel(StringManager.getString("maxLevel"), General.font1, 11, {size=CCSizeMake(57, 49)})
						screen.autoSuitable(temp, {x=59, y=22, nodeAnchor=General.anchorCenter})
						item:addChild(temp)
					elseif rinfo.requireLevel>labLevel then
						temp:setScaleY(1.5)
						temp =  UI.createLabel(StringManager.getFormatString("needLevel", {level=rinfo.requireLevel, name=StringManager.getString("dataBuildName1002")}), General.font1, 15, {size=CCSizeMake(57, 49)})
						screen.autoSuitable(temp, {x=59, y=27, nodeAnchor=General.anchorCenter})
						item:addChild(temp)
						item:setSatOffset(-100, true)
					else
						local food = rinfo.cost
						temp = UI.createResourceNode("food", food, 23, {fontOffY=-2})
						screen.autoSuitable(temp, {nodeAnchor=General.anchorRight, x=107, y=22})
						item:addChild(temp)
					end
				end
			else
				item = UI.createSpriteWithFile("images/dialogItemUnlock.png", CCSizeMake(117, 114))
			end
			screen.autoSuitable(item, {nodeAnchor=General.anchorCenter, x=104+(i-1)%5*127, y=489-math.ceil(i/5)*128})
			bg:addChild(item)
		end
	end
	
	function ResearchDialog.create()
		local temp, bg = nil
		bg = UI.createButton(CCSizeMake(720, 523), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
		screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
		
		UI.setShowAnimate(bg)
		temp = UI.createButton(CCSizeMake(47, 46), display.closeDialog, {image="images/buttonClose.png"})
		screen.autoSuitable(temp, {x=674, y=484, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		
		local tabView = CCNode:create()
		bg:addChild(tabView)
		
		if UserData.researchItem then
		    showResearchingTab(tabView)
		else
		    showMainTab(tabView)
		end
		return bg
	end

end