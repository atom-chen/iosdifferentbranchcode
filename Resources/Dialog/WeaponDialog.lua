WeaponDialog = {}


do
	local showMainTab
	
	local function showSoldierTab(param)
		local bg, temp = param.bg, nil
		local wid = param.wid
		local build = param.build
		
		local winfo = StaticData.getWeaponInfo(wid)
		local wlevel = UserData.researchLevel[10+wid]
		local wdata = winfo.levels[wlevel]
		local mdata = winfo.levels[winfo.maxLevel]
		bg:removeAllChildrenWithCleanup(true)
		temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
		screen.autoSuitable(temp, {x=36, y=22})
		bg:addChild(temp)
		
		temp = UI.createLabel(StringManager.getString("dataWeaponInfo" .. wid), General.font1, 17, {colorR = 33, colorG = 93, colorB = 165, size=CCSize(644, 0)})
		screen.autoSuitable(temp, {x=360, y=158, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		
		temp = UI.createLabel(StringManager.getFormatString("titleInfo", {name=StringManager.getString("dataWeaponName" .. wid), level=wlevel}), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255})
		screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		
		temp = UI.createButton(CCSizeMake(107, 49), showMainTab, {callbackParam={bg=bg, build=build}, image="images/buttonBack.png"})
		screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=70, y=488})
		bg:addChild(temp)
		
		temp = CCNode:create()
		screen.autoSuitable(temp, {x=70, y=244})
		bg:addChild(temp)
		WeaponHelper.addWeaponHead(temp, wid, 1.5)
		
		UI.addInfoItem(bg, 1, wdata.value, wdata.value, mdata.value, "TotalDamage","images/dialogItemInfoDps.png")
		UI.addInfoItem(bg, 2, wdata.cost, wdata.cost, mdata.cost, "WeaponCost", "images/food.png")
		
		for i=1, 3 do
			temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(300, 2))
			screen.autoSuitable(temp, {x=371, y=307-i*29})
			bg:addChild(temp)
		end
		
		local colorProperty = {colorR = 33, colorG = 93, colorB = 165}
		temp = UI.createLabel(StringManager.getString("propertyDamageType"), General.font1, 15, colorProperty)
		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=280})
		bg:addChild(temp)
		temp = UI.createLabel(StringManager.getString("propertyCreateTime"), General.font1, 15, colorProperty)
		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=251})
		bg:addChild(temp)
		temp = UI.createLabel(StringManager.getString("propertyTargets"), General.font1, 15, colorProperty)
		screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=516, y=222})
		bg:addChild(temp)
		
		colorProperty = {colorR = 0, colorG = 0, colorB = 0}
		
		local tempStr = StringManager.getString("typeDamageTypeArea")
		temp = UI.createLabel(tempStr, General.font1, 15, colorProperty)
		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=280})
		bg:addChild(temp)
		temp = UI.createLabel(StringManager.getTimeString(winfo.time), General.font1, 15, colorProperty)
		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=251})
		bg:addChild(temp)
		tempStr = StringManager.getString("typeTargets1")
		temp = UI.createLabel(tempStr, General.font1, 15, colorProperty)
		screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=526, y=222})
		bg:addChild(temp)
	end
	
	local function addAccButton(build, callTable)
		local bg = callTable.view
		callTable.accNode = {}
		temp = UI.createButton(CCSizeMake(109, 42), build.accCall, {callbackParam=build, useExtendNode=true, image="images/buttonGreen.png"})
		screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=613, y=354})
		bg:addChild(temp)
		callTable.accNode[2] = temp
		
		temp = UI.createSpriteWithFile("images/crystal.png",CCSizeMake(34, 33))
		screen.autoSuitable(temp, {x=70, y=5})
		callTable.accNode[2]:addChild(temp)
		
		local accTime = math.ceil(build:getTotalTime())
		local cost = CrystalLogic.computeCostByTime(accTime)
		temp = UI.createLabel(tostring(cost), General.font4, 25, {colorR = 255, colorG = 255, colorB = 255})
		screen.autoSuitable(temp, {x=44, y=20, nodeAnchor=General.anchorCenter})
		callTable.accNode[2]:addChild(temp)
		callTable.accNode[7] = temp
		--callTable.accCost = cost
		
		temp = UI.createLabel(StringManager.getTimeString(accTime), General.font4, 19, {colorR = 255, colorG = 255, colorB = 255})
		screen.autoSuitable(temp, {x=608, y=413, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		callTable.accNode[3] = temp
		
		temp = UI.createLabel(StringManager.getString("labelTotalTime"), General.font1, 12, {colorR = 0, colorG = 0, colorB = 0})
		screen.autoSuitable(temp, {x=608, y=438, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		callTable.accNode[8] = temp
		temp = UI.createLabel(StringManager.getString("labelFinishTrain"), General.font1, 12, {colorR = 0, colorG = 0, colorB = 0})
		screen.autoSuitable(temp, {x=612, y=387, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		callTable.accNode[9] = temp
		
		temp = UI.createSpriteWithFile("images/dialogItemProcessBack.png",CCSizeMake(67, 16))
		screen.autoSuitable(temp, {x=399, y=363})
		bg:addChild(temp, 1)
		callTable.accNode[4] = temp
		temp = UI.createSpriteWithFile("images/dialogItemProcessFiller.png",CCSizeMake(65, 15))
		screen.autoSuitable(temp, {x=1, y=0})
		callTable.accNode[4]:addChild(temp)
		UI.registerAsProcess(temp, callTable)
		UI.setProcess(temp, callTable, 0)
		callTable.accNode[5] = temp
		temp = UI.createLabel(StringManager.getTimeString(math.ceil(build:getSingleTime())), General.font4, 12, {colorR = 255, colorG = 255, colorB = 255})
		screen.autoSuitable(temp, {x=34, y=7, nodeAnchor=General.anchorCenter})
		callTable.accNode[4]:addChild(temp)
		callTable.accNode[6] = temp
	end
	
	local function callSoldier(param)
		local wid = param.wid
		local build = param.build
		if wid>2 then return false end
		build:callWeapon(wid)
	end
	
	local function cancelCallSoldier(param)
		local build = param.build
		local wid = param.wid
		build:cancelCallWeapon(wid)
	end
	
	showMainTab = function(param)
		local bg, temp = param.bg, nil
		local build = param.build
		bg:removeAllChildrenWithCleanup(true)
		
		local tip = UI.createSpriteWithFile("images/dialogItemTipsBg.png",CCSizeMake(647, 45))
		screen.autoSuitable(tip, {x=33, y=26})
		bg:addChild(tip)
		temp = UI.createLabel(StringManager.getString("tipsWeaponDialog"), General.font1, 16, {colorR = 0, colorG = 0, colorB = 0})
		screen.autoSuitable(temp, {x=335, y=22, nodeAnchor=General.anchorCenter})
		tip:addChild(temp)

		local title = UI.createLabel("", General.font3, 27, {colorR = 255, colorG = 255, colorB = 255})
		screen.autoSuitable(title, {x=360, y=491, nodeAnchor=General.anchorCenter})
		bg:addChild(title)
		temp = UI.createSpriteWithFile("images/dialogItemTrainQueue.png",CCSizeMake(280, 96))
		screen.autoSuitable(temp, {x=251, y=351})
		bg:addChild(temp)
		
		local soldierButtons = {}
		local costItems = {}
		local callTable = {}
		
		local function updateCallList()
			title:setString(StringManager.getFormatString("titleWeapon", {num=build.totalSpace, max=build.buildData.extendValue1}))
			local leftFood = ResourceLogic.getResource("food")
			local leftSpace = build.buildData.extendValue1-build.totalSpace
			for i=1, #costItems do
				local item = costItems[i]
				local foodOk = item.foodValue<=leftFood
				if foodOk~=item.foodOk then
					item.foodOk = foodOk
					if foodOk then
						item.foodNode:setColor(ccc3(255, 255, 255))
					else
						item.foodNode:setColor(ccc3(255, 0, 0))
					end
				end
				local spaceOk = leftSpace>0
				if spaceOk~=item.spaceOk then
					item.spaceOk = spaceOk
					if spaceOk then
						item.spaceNode:setSatOffset(0, true)
					else
						item.spaceNode:setSatOffset(-100, true)
					end
				end
			end
			local callList = build.callList
			if #(build.callList)>0 then
				if not callTable.view then
					callTable.view = CCNode:create()
					bg:addChild(callTable.view)
					callTable.accNode = nil
					callTable.queue={}
					callTable.pause = true
				end
				if not callTable.accNode then
					addAccButton(build, callTable)
				else
					local accTime = math.ceil(build:getTotalTime())
					callTable.accNode[3]:setString(StringManager.getTimeString(accTime))
					callTable.accNode[7]:setString(tostring(CrystalLogic.computeCostByTime(accTime)))
					
					local singleTime = build:getSingleTime()
					local singleTotalTime = callList[1].perTime
					UI.setProcess(callTable.accNode[5], callTable, (singleTotalTime-singleTime)/singleTotalTime)
					callTable.accNode[6]:setString(StringManager.getTimeString(math.ceil(singleTime)))
				end
				local tempDict = {}
				for i=1, #callList do
					tempDict[callList[i].wid] = i
				end
				for i=1, 5 do
					local qIndex = tempDict[i] or 0
					if qIndex>0 and qIndex<=5 then
						local queueItem = callTable.queue[i]
						if not queueItem then
							queueItem = {qIndex=qIndex}
							callTable.queue[i] = queueItem
							temp = CCNode:create()
							temp:setContentSize(CCSizeMake(71, 68))
							screen.autoSuitable(temp, {x=481-qIndex*83, y=368})
							callTable.view:addChild(temp)
							queueItem.view = temp
							WeaponHelper.addWeaponHead(queueItem.view, i, 0.6)
							temp = UI.createSpecialButton(CCSizeMake(27, 30), cancelCallSoldier, {callbackParam={wid=i, build=build}, image="images/dialogItemCancel.png", parentTouch=queueItem.view})
							screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=57, y=61})
							queueItem.view:addChild(temp)
							
							temp = UI.createLabel("",General.font4,18)
							screen.autoSuitable(temp, {x=-1, y=64, nodeAnchor=General.anchorLeft})
							queueItem.view:addChild(temp)
							queueItem.num1 = temp
							temp = UI.createLabel("",General.font4,18)
							screen.autoSuitable(temp, {x=12, y=88})
							soldierButtons[i]:addChild(temp)
							queueItem.num2 = temp
						elseif queueItem.qIndex ~= qIndex then
							queueItem.qIndex = qIndex
							screen.autoSuitable(queueItem.view, {x=478-qIndex*87, y=370})
						end
						
						if queueItem.num ~= callList[qIndex].num then
							queueItem.num = callList[qIndex].num
							queueItem.num1:setString(queueItem.num .. "x")
							queueItem.num2:setString(queueItem.num .. "x")
						end
					elseif callTable.queue[i] then
						callTable.queue[i].view:removeFromParentAndCleanup(true)
						callTable.queue[i].num2:removeFromParentAndCleanup(true)
						callTable.queue[i] = nil
					end
				end
			elseif callTable.view then
				callTable.view:removeFromParentAndCleanup(true)
				callTable.view = nil
				for i=1, 5 do
					if callTable.queue[i] and callTable.queue[i].num2 then
						callTable.queue[i].num2:removeFromParentAndCleanup(true)
						callTable.queue[i] = nil
					end
				end
			end
		end
		
		local updateView = CCNode:create()
		simpleRegisterEvent(updateView, {update={callback=updateCallList, inteval=0.1}})
		bg:addChild(updateView)
		
		for i=1, 5 do
			local img = "images/dialogItemTrainButton.png"
			if i>build.buildLevel then
				img = "images/dialogItemUnlock.png"
			end
			soldierButton = UI.createSpecialButton(CCSizeMake(118, 114), callSoldier, {callbackParam={build=build, wid=i}, image=img})
			screen.autoSuitable(soldierButton, {nodeAnchor=General.anchorCenter, x=99 + (i-1)%5*127, y=397 - math.ceil(i/5)*128})
			bg:addChild(soldierButton)
			soldierButtons[i] = soldierButton
			
			if i>build.buildLevel then
				
				if i<=2 then
    			    local head = WeaponHelper.addWeaponHead(soldierButton, i, 1)
				    head:setOpacity(204)
			
        			temp = UI.createButton(CCSizeMake(30, 30), showSoldierTab, {image="images/dialogItemButtonInfo.png", callbackParam={bg=bg, wid=i,build=build}}) --, useExtendNode=true
        			screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=95, y=94})
        			soldierButton:addChild(temp)
        			
    				temp =  UI.createLabel(StringManager.getFormatString("needLevel", {level=i, name=StringManager.getString("dataBuildName" .. build.buildData.bid)}), General.font2, 15, {size=CCSizeMake(67, 80)})
    				screen.autoSuitable(temp, {x=59, y=42, nodeAnchor=General.anchorCenter})
    				soldierButton:addChild(temp)
				end
				soldierButton:setSatOffset(-100, true)
			else
			
			    local head = WeaponHelper.addWeaponHead(soldierButton, i, 1)
				temp = UI.createSpriteWithFile("images/dialogItemPriceBg.png",CCSizeMake(101, 27))
				screen.autoSuitable(temp, {x=7, y=7})
				soldierButton:addChild(temp)
				
				local slevel = UserData.researchLevel[10+i]
				for i=1, slevel do
					temp = UI.createSpriteWithFile("images/soldierStar.png",CCSizeMake(17, 17))
					screen.autoSuitable(temp, {x=14*i-6, y=33})
					soldierButton:addChild(temp)
				end
				
				local food = StaticData.getWeaponInfo(i).levels[slevel].cost
				
				temp = UI.createSpriteWithFile("images/food.png",CCSizeMake(18, 24))
				screen.autoSuitable(temp, {x=88, y=9})
				soldierButton:addChild(temp)
				temp = UI.createLabel(tostring(food), General.font4, 17, {colorR = 255, colorG = 255, colorB = 255})
				screen.autoSuitable(temp, {x=80, y=21, nodeAnchor=General.anchorRight})
				soldierButton:addChild(temp)
				local item = {foodValue=food, foodOk=true, foodNode=temp, spaceOk=true, spaceNode = soldierButton}
				costItems[i] = item
			
    			temp = UI.createButton(CCSizeMake(30, 30), showSoldierTab, {image="images/dialogItemButtonInfo.png", callbackParam={bg=bg, wid=i,build=build}}) --, useExtendNode=true
    			screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=95, y=94})
    			soldierButton:addChild(temp)
			end
		end
		updateCallList()
		
		local weapons = build.weapons
		local idx=1
		local cell = nil
		for i=1, 5 do
		    if weapons[i] and weapons[i]>0 then
		        cell = CCNode:create()
		        cell:setContentSize(CCSizeMake(81,104))
		        screen.autoSuitable(cell, {nodeAnchor=General.anchorLeftBottom, x=90*idx-53, y=78})
		        bg:addChild(cell)
                temp = UI.createSpriteWithFile("images/battleItemBg.png",CCSizeMake(81,104))
                screen.autoSuitable(temp, {x=0, y=0})
                cell:addChild(temp)
                WeaponHelper.addWeaponHead(cell, i, 0.69)
                temp = UI.createStar(UserData.researchLevel[i+10], 15, 13)
                screen.autoSuitable(temp, {x=3, y=6})
                cell:addChild(temp)
                temp = UI.createLabel("x" .. weapons[i], General.font4, 18, {colorR = 255, colorG = 255, colorB = 255})
                screen.autoSuitable(temp, {x=37, y=81, nodeAnchor=General.anchorCenter})
                cell:addChild(temp)
		        idx = idx+1
		    end
		end
		for i=idx, 7 do
		    temp = UI.createSpriteWithFile("images/battleItemBgB.png", CCSizeMake(85, 106))
		    screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=90*i-55, y=78})
		    bg:addChild(temp)
		end
	end
	
	function WeaponDialog.show(build)
		local temp, bg = nil
		bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
		screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
		
		UI.setShowAnimate(bg)
		
		temp = UI.createButton(CCSizeMake(47, 46), display.closeDialog, {image="images/buttonClose.png"})
		screen.autoSuitable(temp, {x=682, y=489, nodeAnchor=General.anchorCenter})
		bg:addChild(temp)
		
		local tabView = CCNode:create()
		bg:addChild(tabView)
		
		showMainTab({bg=tabView, build=build})
		display.showDialog(bg)
	end
end