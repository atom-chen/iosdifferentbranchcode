ChatRoom = {messages={}, globalMsgs={}, beginTime=0, globalBeginTime=0, joinTime=0, chatChannel=0, globalChannel=0, lastChatTime=0, lastGlobalTime=0}

local function eventHandler(eventType, params)
	if eventType == EventManager.eventType.EVENT_JOIN_CLAN then
	    UserData.clanBattleBegin = nil
	    ChatRoom.beginTime = 0
	    ChatRoom.messages = {}
	    ChatRoom.lastChatTime = 0
	    if params~=0 then
	        ChatRoom.joinTime = timer.getTime()
	    end
		ChatRoom.reloadLeagueView()
	end
end

EventManager.registerEventMonitor({"EVENT_JOIN_CLAN"}, eventHandler)

local function onSendMessage(input)
    if UserData.clan~=0 then
        local str = input:getString()
        if str=="" then return end
        input:setString("")
        local function send()
            print("message sended")
            network.httpRequest(network.chatUrl .. "send", doNothing, {params={uid=UserData.userId, cid=UserData.clan, name=UserData.userName, text=str}, timeout=30})
        end
        
        network.checkWord(str, send)
    end
    return
end

local function onSendMessageGlobal(input)
    if UserData.totalCrystal>=0 then
    	local text = input:getString()
    	if text~="" then
    	    input:setString("")
            local function send()
                print("global message sended")
                network.httpRequest(network.chatUrl .. "send", doNothing, {params={uid=UserData.userId, cid=0, name=UserData.userName, text=text}, timeout=30})
            end
            network.checkWord(text, send)
    	end
    else
        display.pushNotice(UI.createNotice(StringManager.getString("noticeGlobalChatError")))
	end
end

function ChatRoom.checkChat()
    if UserData.clan>0 then
        if ChatRoom.chatChannel>0 then
            if timer.getTime() - ChatRoom.lastChatTime>=30 then
                ChatRoom.chatChannel=0
            else
                return
            end
        end
        ChatRoom.chatChannel = ChatRoom.chatChannel + 1
        local beginTime = (ChatRoom.beginTime or 0)
    	network.httpRequest(network.chatUrl .. "recv", ChatRoom.receiveChat, {params={uid=UserData.userId, cid=UserData.clan, since=beginTime}, callbackParam=beginTime, timeout=30})
                print("clan chatting")
    end
    if UserData.totalCrystal>=0 then
        if ChatRoom.globalChannel>0 then
            if timer.getTime() - ChatRoom.lastGlobalTime>=30 then
                ChatRoom.globalChannel=0
            else
                return
            end
        end 
        ChatRoom.globalChannel = ChatRoom.globalChannel + 1
        local beginTime = (ChatRoom.globalBeginTime or 0)
    	network.httpRequest(network.chatUrl .. "recv", ChatRoom.receiveGlobalChat, {params={uid=UserData.userId, cid=0, since=beginTime}, callbackParam=beginTime, timeout=30})
                print("global chatting")
    end
end

function ChatRoom.receiveChat(suc, result, lastTime)
    ChatRoom.chatChannel = 0
                print("clan chated", result, lastTime)
    ChatRoom.lastChatTime = timer.getTime()
    if ChatRoom.beginTime-lastTime>0 then return end
	if suc then
		local msgs = json.decode(result).messages
		local newMsgNum = 0
		for i=1, #msgs do
			local msg = msgs[i]
			if msg[5]=="msg" then
				table.insert(ChatRoom.messages, 1, {uid=msg[1], name=msg[2], text=msg[3], time=timer.getTime(msg[4]), type=msg[5]})
				newMsgNum = newMsgNum+1
			elseif msg[5]=="sys" then
			    local newMsg = {uid=0, name="Caesars", time=timer.getTime(msg[4]), type="sys"}
			    local stype = msg[2]
			    -- league battle begin
			    if newMsg.time>UserData.lastSynTime-30 and newMsg.time>ChatRoom.joinTime then
    			    if stype=="lbb" then
    			        UserData.clanInfo[10] = 2
    			        UserData.clanInfo[11] = tonumber(msg[3])
    			    elseif stype=="lbe" then
    			        local winClan = tonumber(msg[3])
    			        if UserData.clanInfo[10]==2 and UserData.clan==winClan then
    			            UserData.clanInfo[3] = UserData.clanInfo[3]+30
    			        end
    			        UserData.clanInfo[10] = 0
    			        UserData.clanInfo[11] = 0
    			        UserData.clanBattleEnd = winClan
    			    end
    			end
    			if stype=="l" or stype=="j" then
    			    print(msg[3])
    			    local minfo = json.decode(msg[3])
    			    newMsg.uid = minfo.uid
    			    newMsg.name = minfo.name
    			    newMsg.text = StringManager.getFormatString("textChatSys" .. stype, {name=minfo.name})
    			    newMsg.type = "msg"
    			    if stype=="l" then
        			    newMsg.color = {252, 7, 7}
        			    for j=1, #(ChatRoom.messages) do
        			        if ChatRoom.messages[j].type=="request" and ChatRoom.messages[j].uid==minfo.uid then
        			            table.remove(ChatRoom.messages, j)
        			            break
        			        end
        			    end
        			else
        			    newMsg.color = {107, 219, 0}
        		    end
    			    table.insert(ChatRoom.messages, 1, newMsg)
				    newMsgNum = newMsgNum+1
    			end
			elseif msg[5]=="request" then
				local oldMsgs = ChatRoom.messages
				for j=1, #oldMsgs do
					if oldMsgs[j].type=="request" and oldMsgs[j].uid==msg[1] then
						table.remove(oldMsgs, j)
						break
					end
				end
				if msg[1]==UserData.userId then
				    UserData.clanTroops = msg[3][3]
				end
				table.insert(ChatRoom.messages, 1, {uid=msg[1], name=msg[2], property=msg[3], time=timer.getTime(msg[4]), type=msg[5]})
				newMsgNum = newMsgNum+1
			elseif msg[5]=="donate" then
				local oldMsgs = ChatRoom.messages
				if msg[2]~=UserData.userId then
					for j=1, #oldMsgs do
						if oldMsgs[j].type=="request" and oldMsgs[j].uid==msg[1] then
							oldMsgs[j].property = msg[3]
							break
						end
					end
    				if msg[1] == UserData.userId then
    				    UserData.clanTroops = msg[3][3]
    					--display.pushNotice(UI.createNotice(StringManager.getFormatString("noticeRecvDonate", {name=StringManager.getString("dataSoldierName" .. msg[2])})))
    				end
				end
			end
		end
		if #msgs>0 then
			ChatRoom.beginTime = msgs[#msgs][4]
            if ChatRoom.deleted or UserData.clan==0 then return end
		    ChatRoom.reloadLeagueView()
		    if not ChatRoom.visible and newMsgNum>0 then
		        ChatRoom.showNotice()
		    end
		else
			ChatRoom.beginTime = lastTime+10
		end
	end
end

function ChatRoom.receiveGlobalChat(suc, result, lastTime)
    ChatRoom.globalChannel = 0
                print("global chated", result, lastTime)
    ChatRoom.lastGlobalTime = timer.getTime()
    if ChatRoom.globalBeginTime-lastTime>0 then return end
	if suc then
		local msgs = json.decode(result).messages
		for i=1, #msgs do
			local msg = msgs[i]
			if msg[5]=="msg" then
				table.insert(ChatRoom.globalMsgs, 1, {uid=msg[1], name=msg[2], text=msg[3], time=timer.getTime(msg[4]), type=msg[5]})
			end
		end
		if #msgs>0 then
			ChatRoom.globalBeginTime = msgs[#msgs][4]
            if ChatRoom.deleted or UserData.totalCrystal<0 then return end
		    ChatRoom.reloadChatView()
		    if not ChatRoom.visible then
		        ChatRoom.showNotice()
		    end
		else
			ChatRoom.globalBeginTime = lastTime+10
		end
	end
end

function ChatRoom.onDonate(msg)
    local cell = msg.cell
    local bg = ChatRoom.leagueView
    local oy = UI.closeVisitControl(ChatRoom.view)
    local s = cell:getContentSize()
    local p1 = cell:convertToWorldSpace(CCPointMake(s.width, s.height/2))
    local p2 = bg:convertToNodeSpace(p1)
    local y = squeeze(p2.y, 126, bg:getContentSize().height-145)
    
    local property = msg.property
    local leftspace = property[2]-property[1]
    local leftnum = 5
    for _, s in ipairs(property[3]) do
        if s[1]==UserData.userId then
            leftnum = leftnum-1
        end
    end
    
    if oy==y or leftnum==0 or leftspace==0 then
        return
    end
    local visitBg = UI.createSpriteWithFile("images/chatRoomBackDonate.png",CCSizeMake(517, 271))
    visitBg:setAnchorPoint(CCPointMake(0, 126/271))
    visitBg:setPosition(p2.x, y)
    ChatRoom.view:addChild(visitBg, 100, TAG_VISIT)
    
    local buts = {}
    local leftNumLabel = nil
    local function donateSoldier(index)
        local item = buts[index]
        if leftnum>0 and item.num>0 and leftspace>=item.space then
            table.insert(property[3], {UserData.userId, index, UserData.researchLevel[index]})
            property[1] = property[1]+item.space
            leftnum = leftnum-1
            leftNumLabel:setString(leftnum .. "/5")
            leftspace=leftspace-item.space
            item.num = item.num - 1
            item.numLabel:setString("x" .. item.num)
            SoldierLogic.decSoldier(index)
            network.httpRequest(network.chatUrl .. "donate", doNothing, {params={uid=UserData.userId, cid=UserData.clan, toUid=msg.uid, sid=index, slevel=UserData.researchLevel[index], space=item.space}})
        end 
    end
    for i=1, 10 do
        local but = UI.createSpecialButton(CCSizeMake(81, 104), donateSoldier, {callbackParam=i, image="images/battleItemBg.png"})
        screen.autoSuitable(but, {x=80+95*((i-1)%5), y=290-112*math.ceil(i/5), nodeAnchor=General.anchorCenter})
        visitBg:addChild(but)
        
    	SoldierHelper.addSoldierHead(but, i, 0.7)
		local temp = UI.createStar(UserData.researchLevel[i], 17, 14)
		screen.autoSuitable(temp, {x=3, y=6})
		but:addChild(temp)
        
        local num = SoldierLogic.getSoldierNumber(i) or 0
        local space = StaticData.getSoldierInfo(i).space
		temp = UI.createLabel("x" .. num, General.font4, 18, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
		screen.autoSuitable(temp, {x=40, y=90, nodeAnchor=General.anchorCenter})
		but:addChild(temp)
		
		if num==0 or space>leftspace or leftnum==0 then
		    but:setSatOffset(-100, true)
		end
		buts[i] = {view=but, space=space, num=num, numLabel=temp}
    end
    
    local temp = UI.createLabel(StringManager.getString("labelDonateTroops"), General.font1, 20, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=43, y=248, nodeAnchor=General.anchorLeft})
    visitBg:addChild(temp)
    temp = UI.createLabel(leftnum .. "/5", General.font1, 20, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=429, y=249, nodeAnchor=General.anchorLeft})
    visitBg:addChild(temp)
    leftNumLabel = temp
    temp = UI.createButton(CCSizeMake(32, 31), UI.closeVisitControl, {callbackParam=ChatRoom.view, image="images/buttonClose.png"})
    screen.autoSuitable(temp, {x=490, y=249, nodeAnchor=General.anchorCenter})
    visitBg:addChild(temp)
    --[[
    temp = UI.createButton(CCSizeMake(128, 58), EventManager.sendMessageCallback, {callbackParam={event="EVENT_VISIT_USER", eventParam=param.uid}, image="images/buttonGreen.png", text=StringManager.getString("buttonVisit"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=108, y=215, nodeAnchor=General.anchorCenter})
    visitBg:addChild(temp)
    --]]
end

function ChatRoom.reloadLeagueChats()
    if ChatRoom.deleted or not ChatRoom.leagueView then return end
    local bg = ChatRoom.leagueView:getChildByTag(TAG_ACTION)
    local msgs = ChatRoom.messages
    bg:removeAllChildrenWithCleanup(true)
	local temp
	local OFFY = 0
	local scrollView = UI.createScrollView(CCSizeMake(368, 582), false)
	for i=1, #msgs do
		if true then
		    local cell = CCNode:create()
			local msg = msgs[i]
			local Y=0
	    	temp = UI.createSpriteWithFile("images/chatRoomSeperator.png",CCSizeMake(336, 2))
            screen.autoSuitable(temp, {x=17, y=3})
            cell:addChild(temp)
			if timer.getTime()-msg.time<60 then
    			tempStr = StringManager.getString("labelJustNow")
    	    else
			    tempStr = StringManager.getFormatString("timeAgo", {time=StringManager.getTimeString(timer.getTime()-msg.time)})
			end
            temp = UI.createLabel(tempStr, General.font1, 18, {colorR = 149, colorG = 148, colorB = 139})
            screen.autoSuitable(temp, {x=353, y=22, nodeAnchor=General.anchorRight})
            cell:addChild(temp)
            
			if msg.type=="msg" then
			    local color = msg.color or {255, 255, 255}
                temp = UI.createLabel(msg.text or "", General.font5, 20, {colorR = color[1], colorG = color[2], colorB = color[3], size=CCSizeMake(310, 0), align=kCCTextAlignmentLeft})
				local lheight = temp:getContentSize().height * temp:getScale()
                screen.autoSuitable(temp, {x=19, y=39+lheight, nodeAnchor=General.anchorLeftTop})
                cell:addChild(temp)
				Y = Y+lheight-10
		    elseif msg.type=="request" then
                local property = msg.property
                
                local canDonate = true
                if msg.uid==UserData.userId then
                    canDonate = false
                else
                    local leftspace = property[2]-property[1]
                    local leftnum = 5
                    for _, s in ipairs(property[3]) do
                        if s[1]==UserData.userId then
                            leftnum = leftnum-1
                        end
                    end
                    if leftnum<=0 or leftspace<=0 then
                        canDonate = false
                    end
                end
                if canDonate then
    				Y = Y+68
                    temp = scrollView:createButton(CCSizeMake(123, 43), ChatRoom.onDonate, {callbackParam=msg, image="images/buttonGreenB.png", text=StringManager.getString("buttonDonate"), fontSize=22, fontName=General.font3})
                    screen.autoSuitable(temp, {x=217, y=54, nodeAnchor=General.anchorCenter})
                    cell:addChild(temp)
                    msg.cell = cell
    			else
    				Y = Y+25
    			end
                temp = UI.createLabel(property[1] .. "/" .. property[2], General.font1, 20, {colorR = 255, colorG = 255, colorB = 255})
                screen.autoSuitable(temp, {x=96, y=Y+27, nodeAnchor=General.anchorRight})
                cell:addChild(temp)
                local ft = {value=property[1], valueLabel=temp, max=property[2]}
                temp = UI.createSpriteWithFile("images/donateBack.png",CCSizeMake(226, 23))
                screen.autoSuitable(temp, {x=104, y=Y+16})
                cell:addChild(temp)
                temp = UI.createSpriteWithFile("images/donateFiller.png",CCSizeMake(220, 17))
                screen.autoSuitable(temp, {x=107, y=Y+19})
                cell:addChild(temp)
                ft.filler = temp
                UI.registerAsProcess(temp, ft)
                UI.setProcess(temp, ft, property[1]/property[2])
			end
			
			local tempStr = StringManager.getString("labelYou")
			if msg.uid~=UserData.userId then
				tempStr = msg.name
			end
            temp = UI.createLabel(tempStr, General.font5, 22, {colorR = 222, colorG = 215, colorB = 165})
            screen.autoSuitable(temp, {x=20, y=Y+75, nodeAnchor=General.anchorLeft})
            cell:addChild(temp)
            local nameLabel = temp
            local visitY = Y+63
            Y = Y+75+temp:getContentSize().height/2
			cell:setContentSize(CCSizeMake(368, Y))
            if msg.uid~=UserData.userId then
                local w = nameLabel:getContentSize().width * nameLabel:getScaleX()
				temp = UI.createSpriteWithFile("images/chatRoomItemVisit.png",CCSizeMake(22, 23))
				screen.autoSuitable(temp, {x=22+w, y=visitY})
				cell:addChild(temp)
    	        UI.registerVisitIcon(cell, scrollView, ChatRoom.view, msg.uid, temp)
            end
			scrollView:addItem(cell, {offx=1, offy=1+OFFY, disx=0, disy=0, index=1, rowmax=1})
			OFFY = OFFY + Y
			
		end
	end
    scrollView:prepare()
	screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorLeftTop, x=0, y=582})
	bg:addChild(scrollView.view)
end

function ChatRoom.donate(target)
	network.httpRequest(network.chatUrl .. "donate", doNothing, {params={uid=UserData.userId, toUid=target.uid, cid=UserData.clan, sid=1, slevel=1, space=1}})
	local helps = target.property[3]
	local isNew = true
	for i=1, #helps, 2 do
		if helps[i]==UserData.userId then
			helps[i+1] = helps[i+1]+1
			isNew = false
			break
		end
	end
	if isNew then
		table.insert(helps, UserData.userId)
		table.insert(helps, 1)
	end
end

function ChatRoom.createChatView()
	local temp, bg = nil
	bg = CCExtendNode:create(CCSizeMake(368, 768), false)
    
    temp = UI.createSpriteWithFile("images/chatRoomTabBg.png",CCSizeMake(365, 71))
    screen.autoSuitable(temp, {x=2, y=646})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemTextinput.png",CCSizeMake(285, 37))
    screen.autoSuitable(temp, {x=14, y=663})
    bg:addChild(temp)
	local input = UI.createTextInput("", General.font5, 18, CCSizeMake(275, 31), kCCTextAlignmentLeft, 140, display.MENU_BUTTON_PRI-2)
	screen.autoSuitable(input, {x=19, y=666})
	input:setColor(ccc3(0,0,0))
	bg:addChild(input)
	temp = UI.createButton(CCSizeMake(45, 37), onSendMessageGlobal, {callbackParam=input, image="images/chatRoomEnter.png", priority=display.CHAT_BUTTON_PRI})
	screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=333, y=682})
	bg:addChild(temp)
	
    temp = UI.createLabel(StringManager.getString("textGlobalChat"), General.font1, 20, {size=CCSizeMake(320, 0), align=kCCTextAlignmentLeft, colorR = 107, colorG = 219, colorB = 0})
    screen.autoSuitable(temp, {x=17, y=640, nodeAnchor=General.anchorLeftTop})
    bg:addChild(temp)
    ChatRoom.globalOffsetY = temp:getContentSize().height * temp:getScaleY()
	temp = UI.createSpriteWithFile("images/chatRoomSeperator.png",CCSizeMake(336, 2))
    screen.autoSuitable(temp, {x=17, y=638-ChatRoom.globalOffsetY})
    bg:addChild(temp)
	
    --[[
	local chatView = CCNode:create()
	chatView:setContentSize(bg:getContentSize())
	screen.autoSuitable(chatView)
	bg:addChild(chatView)
	--]]

    local chatView = CCNode:create()
    chatView:setContentSize(CCSizeMake(368, 768))
    bg:addChild(chatView)
    ChatRoom.chatView = chatView
	ChatRoom.reloadChatView()
	return bg
end

function ChatRoom.reloadChatView()
    if ChatRoom.deleted then return end
    local bg = ChatRoom.chatView
    if not bg then return end
    bg:removeAllChildrenWithCleanup(true)
    
	local temp
	local OFFY = 0
	local scrollView = UI.createScrollView(CCSizeMake(368, 635-ChatRoom.globalOffsetY), false)
    local msgs = ChatRoom.globalMsgs
	for i=1, #msgs do
		local cell = CCNode:create()
	    local msg = msgs[i]
		local Y=0
	    temp = UI.createSpriteWithFile("images/chatRoomSeperator.png",CCSizeMake(336, 2))
        screen.autoSuitable(temp, {x=17, y=3})
        cell:addChild(temp)
		if timer.getTime()-msg.time<60 then
    		tempStr = StringManager.getString("labelJustNow")
    	else
		    tempStr = StringManager.getFormatString("timeAgo", {time=StringManager.getTimeString(timer.getTime()-msg.time)})
		end
        temp = UI.createLabel(tempStr, General.font1, 18, {colorR = 149, colorG = 148, colorB = 139})
        screen.autoSuitable(temp, {x=353, y=22, nodeAnchor=General.anchorRight})
        cell:addChild(temp)
            
		if msg.type=="msg" then
		    local color = msg.color or {255, 255, 255}
            temp = UI.createLabel(msg.text or "", General.font5, 20, {colorR = color[1], colorG = color[2], colorB = color[3], size=CCSizeMake(310, 0), align=kCCTextAlignmentLeft})
		    local lheight = temp:getContentSize().height * temp:getScale()
            screen.autoSuitable(temp, {x=19, y=39+lheight, nodeAnchor=General.anchorLeftTop})
            cell:addChild(temp)
			Y = Y+lheight-10
		end
		local tempStr = StringManager.getString("labelYou")
		if msg.uid~=UserData.userId then
			tempStr = msg.name
		end
        temp = UI.createLabel(tempStr, General.font5, 22, {colorR = 222, colorG = 215, colorB = 165})
        screen.autoSuitable(temp, {x=20, y=Y+75, nodeAnchor=General.anchorLeft})
        cell:addChild(temp)
        local nameLabel = temp
        local visitY = Y+63
        Y = Y+75+temp:getContentSize().height/2
		cell:setContentSize(CCSizeMake(368, Y))
        if msg.uid~=UserData.userId then
            local w = nameLabel:getContentSize().width * nameLabel:getScaleX()
		    temp = UI.createSpriteWithFile("images/chatRoomItemVisit.png",CCSizeMake(22, 23))
			screen.autoSuitable(temp, {x=22+w, y=visitY})
			cell:addChild(temp)
    	    UI.registerVisitIcon(cell, scrollView, ChatRoom.view, msg.uid, temp)
        end
		scrollView:addItem(cell, {offx=1, offy=1+OFFY, disx=0, disy=0, index=1, rowmax=1})
		OFFY = OFFY + Y
	end
    scrollView:prepare()
	screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorLeftTop, x=0, y=635-ChatRoom.globalOffsetY})
	bg:addChild(scrollView.view)
end

function ChatRoom.openLeague()
    if display.getCurrentScene(1):getMaxLevel(2)==0 then
        display.pushNotice(UI.createNotice(StringManager.getString("noticeRebuiltLeague")))
    else
        display.showDialog(ClanDialog)
    end
end

function ChatRoom.createLeagueView()
	local temp, bg = nil
	bg = CCExtendNode:create(CCSizeMake(368, 768), false)
    
    temp = UI.createSpriteWithFile("images/chatRoomTabBg.png",CCSizeMake(365, 118))
    screen.autoSuitable(temp, {x=2, y=599})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(36,36), ChatRoom.openLeague, {image="images/dialogItemButtonInfo.png", priority=display.MENU_BUTTON_PRI-2})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=334, y=681})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemTextinput.png",CCSizeMake(285, 37))
    screen.autoSuitable(temp, {x=14, y=616})
    bg:addChild(temp)
	local input = UI.createTextInput("", General.font5, 18, CCSizeMake(275, 31), kCCTextAlignmentLeft, 140, display.MENU_BUTTON_PRI-2)
	screen.autoSuitable(input, {x=19, y=619})
	input:setColor(ccc3(0,0,0))
	bg:addChild(input)
	temp = UI.createButton(CCSizeMake(45, 37), onSendMessage, {callbackParam=input, image="images/chatRoomEnter.png", priority=display.CHAT_BUTTON_PRI})
	screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=333, y=635})
	bg:addChild(temp)
    local leagueView = CCNode:create()
    leagueView:setContentSize(CCSizeMake(368, 768))
    bg:addChild(leagueView)
    ChatRoom.leagueView = leagueView
    ChatRoom.reloadLeagueView()
	return bg
end

function ChatRoom.reloadLeagueView()
    if ChatRoom.deleted then return end
    local bg = ChatRoom.leagueView
    if not bg then return end
    if not pcall(bg.removeAllChildrenWithCleanup, bg, true) then
        ChatRoom.leagueView = nil
        return
    end
    if UserData.clan==0 then
        local str = StringManager.getString("labelChatRoomLeagueInfo")
        if not CCUserDefault:sharedUserDefault():getBoolForKey("chinese") then
            str = str:gsub("\n\n","\n")
        end
        temp = UI.createLabel(str, General.font3, 18+NORMAL_SIZE_OFF, {colorR = 255, colorG = 255, colorB = 255, size=CCSizeMake(310, 500)})
        screen.autoSuitable(temp, {x=186, y=456, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createSpriteWithFile("images/leagueBattleIcon.png",CCSizeMake(134, 150))
        screen.autoSuitable(temp, {x=186, y=209, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    else
        temp = UI.createSpriteWithFile("images/leagueIcon/" .. UserData.clanInfo[2] .. ".png",CCSizeMake(30, 34))
        screen.autoSuitable(temp, {x=20, y=664})
        bg:addChild(temp)
        temp = UI.createLabel(UserData.clanInfo[5], General.font6, 17, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=55, y=679, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        
        temp = CCNode:create()
        bg:addChild(temp, 0, TAG_ACTION)
        
        ChatRoom.reloadLeagueChats()
    end
end

function ChatRoom.create()
	ChatRoom.leagueView = nil
	local temp, bg = nil
	bg = CCNode:create()
	bg:setContentSize(CCSizeMake(372, 768))
	simpleRegisterEvent(bg, {update={inteval=5, callback=ChatRoom.checkChat}})
	ChatRoom.view = bg
	ChatRoom.notice = nil
	--simpleRegisterButton(bg, {priority=display.MENU_BUTTON_PRI-1})
	screen.autoSuitable(bg,{screenAnchor=General.anchorLeftBottom, scaleType=screen.SCALE_HEIGHT_FIRST,x=-372})
	ChatRoom.xoff = bg:getPositionX()
    temp = UI.createSpriteWithFile("images/chatRoomBg.png",CCSizeMake(372, 773))
    screen.autoSuitable(temp, {x=0, y=-3})
    bg:addChild(temp)
	
	local layer = CCTouchLayer:create(display.MENU_BUTTON_PRI-1, true)
	layer:setContentSize(CCSizeMake(372, 768))
	bg:addChild(layer)
    local tabs = {}
	temp = UI.createSpriteWithFile("images/chatRoomTab0.png",CCSizeMake(175, 44))
    screen.autoSuitable(temp, {x=10, y=716})
    layer:addChild(temp,1)
    tabs[1] = temp
    temp = UI.createSpriteWithFile("images/chatRoomTab1.png",CCSizeMake(174, 49))
    screen.autoSuitable(temp, {x=193, y=712})
    layer:addChild(temp,1)
    tabs[2] = temp
    temp = UI.createLabel(StringManager.getString("chatRoomTabGlobal"), General.font3, 18, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=97, y=736, nodeAnchor=General.anchorCenter})
    bg:addChild(temp,2)
    temp = UI.createLabel(StringManager.getString("chatRoomTabLeague"), General.font3, 18, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=280, y=736, nodeAnchor=General.anchorCenter})
    bg:addChild(temp,2)
    
    temp = UI.createSpriteWithFile("images/chatRoomButton.png",CCSizeMake(52, 139))
    screen.autoSuitable(temp, {x=365, y=325})
    bg:addChild(temp)
	local cbutton = temp
    temp = UI.createSpriteWithFile("images/chatRoomTriangle.png",CCSizeMake(18, 32))
    screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=31, y=67})
    cbutton:addChild(temp, 1, 1)
	ChatRoom.registerChatRoomButton(cbutton)
	
	ChatRoom.chatView = nil
	local tabView = UI.createTabView(CCSizeMake(372, 768))
	tabView.addTab({create=ChatRoom.createChatView})
	tabView.addTab({create=ChatRoom.createLeagueView})
	layer:addChild(tabView.view)
	
	local function changeTab(index)
	    local cache = CCTextureCache:sharedTextureCache()
	    tabs[index]:setTexture(cache:addImage("images/chatRoomTab1.png"))
	    tabs[index]:setTextureRect(CCRectMake(0,0,174,49))
	    tabs[index]:setPositionY(712)
	    tabs[3-index]:setTexture(cache:addImage("images/chatRoomTab0.png"))
	    tabs[3-index]:setTextureRect(CCRectMake(0,0,175,44))
	    tabs[3-index]:setPositionY(717)
	    tabView.changeTab(index)
	    ChatRoom.isChat = (index==1)
		UI.closeVisitControl(ChatRoom.view)
	end
	simpleRegisterButton(tabs[1], {priority=display.MENU_BUTTON_PRI-2, callback=changeTab, callbackParam=1})
	simpleRegisterButton(tabs[2], {priority=display.MENU_BUTTON_PRI-2, callback=changeTab, callbackParam=2})
	changeTab(2)
	ChatRoom.setVisible(false)
	return bg
end

function ChatRoom.registerChatRoomButton(but)
	ChatRoom.roomButton = but
	ChatRoom.touchlist = queue.create(2)
	local layer = CCTouchLayer:create(display.MENU_BUTTON_PRI-1, true)
	layer:setContentSize(but:getContentSize())
	but:addChild(layer)
	layer:registerScriptTouchHandler(ChatRoom.onTouch)
end

function ChatRoom.onTouch(eventType, id, x, y)
	if eventType == CCTOUCHBEGAN then
		return ChatRoom.onTouchBegan(x, y)
	elseif eventType == CCTOUCHMOVED then
		return ChatRoom.onTouchMoved(x, y)
	else
		return ChatRoom.onTouchEnded(x, y)
	end
end

function ChatRoom.onTouchBegan(x, y)
	if ChatRoom.roomButton and isTouchInNode(ChatRoom.roomButton, x, y) then
		--ChatRoom.roomButton:setValOffset(20)
		ChatRoom.touchPoint = {x, y}
		ChatRoom.touchlist.push({time=timer.getTime(), point = ChatRoom.touchPoint})
		return true
	end
end

function ChatRoom.onTouchMoved(x, y)
	local point = {x, y}
	local xoff = x-ChatRoom.touchPoint[1]
	ChatRoom.touchPoint = point
	local bg = ChatRoom.view
	bg:setPositionX(squeeze(bg:getPositionX()+xoff, ChatRoom.xoff, 0))
	ChatRoom.touchlist.push({time=timer.getTime(), point = {x,y}})
end

function ChatRoom.onTouchEnded(x, y)
	if ChatRoom.touchPoint then
		local touchlist = ChatRoom.touchlist
		local isOver = false
		if touchlist.size()==2 then
			local t1, t2 = touchlist.get(1), touchlist.get(2)
			local stime = t1.time - t2.time
			local xoff = t1.point[1] - t2.point[1]
			if stime < 0.3 and math.abs(xoff)>10 then
				ChatRoom.setVisible(xoff>0)
				isOver = true
			end
		end
		if not isOver and isTouchInNode(ChatRoom.roomButton, x, y) then
			ChatRoom.setVisible(not ChatRoom.visible)
		else
			ChatRoom.setVisible(ChatRoom.visible)
		end
		ChatRoom.touchPoint = nil
	end
end

function ChatRoom.showNotice()
    if not ChatRoom.visible and not ChatRoom.deleted and ChatRoom.view then
        local temp = UI.createSpriteWithFile("images/numIcon.png",CCSizeMake(29, 29))
        screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=411, y=439})
        if not pcall(ChatRoom.view.addChild, ChatRoom.view, temp, 0, TAG_ACTION) then
            ChatRoom.view = nil
            return
        end
        local t = getParam("actionTimeButtonNotice", 400)/1000
        local s = getParam("actionScaleButtonNotice", 120)/100
        local n = getParam("actionNumButtonNotice", 1)
        local array = CCArray:create()
        array:addObject(CCEaseSineOut:create(CCScaleTo:create(t/2, s, s)))
        array:addObject(CCEaseSineIn:create(CCScaleTo:create(t/2, 1, 1)))
        temp:runAction(CCRepeat:create(CCSequence:create(array), n))
    end
end

function ChatRoom.setVisible(boolValue)
	ChatRoom.visible = boolValue
	local bg = ChatRoom.view
	bg:stopAllActions()
	local tri = ChatRoom.roomButton:getChildByTag(1)
	if boolValue then
	    tri:setScaleX(-1)
		bg:runAction(CCMoveTo:create(0.1, CCPointMake(0, 0)))
		local temp = ChatRoom.view:getChildByTag(TAG_ACTION)
		if temp then
		    temp:removeFromParentAndCleanup(true)
		end
	else
	    tri:setScaleX(1)
		bg:runAction(CCMoveTo:create(0.1, CCPointMake(ChatRoom.xoff, 0)))
		UI.closeVisitControl(ChatRoom.view)
	end
end