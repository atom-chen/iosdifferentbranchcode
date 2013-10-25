ClanDialog = class()

local TEMP_CLAN_ID, TEMP_MIN_SCORE, IS_CREATING=1, 0, false

local LABEL_SIZE = 15
local LABEL_BASE_Y = 666

local editTabIndex=4

local LeagueWarIntroDialog = class()

function LeagueWarIntroDialog:ctor()
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    self.view = bg
	UI.setShowAnimate(bg)
    
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/featureShadow.png",CCSizeMake(192, 74))
    screen.autoSuitable(temp, {x=53, y=70})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/guideNpc2.png")
    temp:setScale(0.786)
    screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=146, y=253})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(135, 61), display.closeDialog, {image="images/buttonGreen.png", text=StringManager.getString("buttonYes"), fontSize=26, fontName=General.font3})
    screen.autoSuitable(temp, {x=449, y=134, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelLeagueWarRule"), General.font1, 28, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(400, 240), align=kCCTextAlignmentLeft})
    screen.autoSuitable(temp, {x=475, y=276, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
    temp = UI.createLabel(StringManager.getString("titleLeagueWar"), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
	temp = UI.createButton(CCSizeMake(47, 46), display.closeDialog, {image="images/buttonClose.png"})
	screen.autoSuitable(temp, {x=683, y=492, nodeAnchor=General.anchorCenter})
	bg:addChild(temp)
end

local function createTab(setting)
    local tname = setting.tabname
    local dialog = setting.handler
    if tname=="tabJoin" then
        return dialog:createJoinTab()
    elseif tname=="tabSearch" then
        return dialog:createSearchTab()
    elseif tname=="tabMyLeague" then
        return dialog:createMyLeagueTab()
    elseif tname=="tabCreate" then
        return dialog:createCreateTab()
    elseif tname=="tabEdit" then
        return dialog:createCreateTab(true)
    elseif tname=="tabLeagueWar" then
        return dialog:createLeagueWarTab()
    elseif tname=="tabCaesarsCup" then
        return dialog:createCaesarsCupTab()
    end
end

function ClanDialog:ctor(index)
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(1020, 765), doNothing, {image="images/dialogBackA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_CUT_EDGE})
    UI.setShowAnimate(bg)
    self.view = bg
    self.dialogName = "clan"
    local tabview = UI.createTabView(CCSizeMake(1020, 765))
    bg:addChild(tabview.view, 2)
    self.tabview = tabview
    self.curTab = 0
    local tabs={}
    local function changeTab(index)
        local cache = CCTextureCache:sharedTextureCache()
        if self.curTab ~= 0 then
            if self.curTab==editTabIndex then
                tabs[1]:setTexture(cache:addImage("images/leagueTab0.png"))
            else
                tabs[((self.curTab-1)%3)+1]:setTexture(cache:addImage("images/leagueTab0.png"))
            end
        end
        self.curTab = index
        tabs[self.curTab]:setTexture(cache:addImage("images/leagueTab1.png"))
        UI.closeVisitControl(self.view)
        tabview.changeTab(index)
    end
    temp = UI.createSpriteWithFile("images/dialogBackB.png",CCSizeMake(998, 676))
    screen.autoSuitable(temp, {x=11, y=13})
    bg:addChild(temp, 1)
    temp = UI.createButton(CCSizeMake(55, 53), display.closeDialog, {image="images/buttonClose.png"})
    screen.autoSuitable(temp, {x=985, y=727, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    num = self:initTabView(tabs, changeTab)
    if index and index>#tabs then
        index = #tabs
    end
    changeTab(index or 1)
end

function ClanDialog:initTabView(tabs, changeTab)
    local tabTitles = {}
    if UserData.clan==0 then
        tabTitles = {"tabJoin","tabSearch","tabCreate"}
    else
        tabTitles = {"tabMyLeague", "tabLeagueWar"}
        if UserData.leagueWarTime and UserData.nextLeagueWarTime and UserData.leagueWarTime>timer.getTime() and (UserData.leagueWarTime<UserData.nextLeagueWarTime or UserData.nextLeagueWarTime<timer.getTime()) then
            table.insert(tabTitles, 1, "tabCaesarsCup")
        end
    end
    for i=1, #tabTitles do
        temp = UI.createSpriteWithFile("images/leagueTab0.png",CCSizeMake(200, 77))
        screen.autoSuitable(temp, {x=-71+i*209, y=679})
        self.view:addChild(temp)
        tabs[i] = temp
	    simpleRegisterButton(temp, {priority=display.DIALOG_BUTTON_PRI, callback=changeTab, callbackParam=i})

        temp = UI.createLabel(StringManager.getString(tabTitles[i]), General.font3, 24, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=29+209*i, y=722, nodeAnchor=General.anchorCenter})
        self.view:addChild(temp)
        self.tabview.addTab({create=createTab, tabname=tabTitles[i], handler=self})
    end
    self.tabview.addTab({create=createTab, tabname="tabEdit", handler=self})
    editTabIndex = 1+ #tabTitles
end

function ClanDialog:createLeagueOver(suc, result)
    IS_CREATING = false
    if suc then
        local data = json.decode(result)
        UserData.clan = data.clan
        UserData.clanInfo = data.info
        if UserData.clan~=0 then
            UserData.memberType = 2
            display.pushNotice(UI.createNotice(StringManager.getString("noticeCreateLeague"), 255))
            if not self.deleted then
                display.closeDialog()
            end
            EventManager.sendMessage("EVENT_JOIN_CLAN", UserData.clan)
        else
            UserDat.clan = data.info[1]
            display.pushNotice(UI.createNotice(StringManager.getString("noticeCreateLeagueError")))
        end
    end
end

function ClanDialog:popTab()
    self.tabview.changeTab(self.curTab)
    self.memberClan=UserData.clan
end

local function showLeagueView(info)
    info.dialog:showLeagueTab(info)
end

function updateRankClanCell(bg, scrollView, info)
    local imageFile = "images/dialogItemLeagueA.png"
    if info.clan==UserData.clan then
        imageFile = "images/dialogItemLeagueA2.png"
    end
    local temp = UI.createSpriteWithFile(imageFile,CCSizeMake(986, 58))
    screen.autoSuitable(temp)
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemRankScoreBg.png",CCSizeMake(156, 41))
    screen.autoSuitable(temp, {x=823, y=10})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/score.png",CCSizeMake(37, 42))
    screen.autoSuitable(temp, {x=934, y=10})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. info.icon .. ".png",CCSizeMake(39, 44))
    screen.autoSuitable(temp, {x=128, y=7})
    bg:addChild(temp)
    temp = UI.createLabel(info.name, General.font6, 25, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=176, y=27, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.score), General.font4, 23, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
    screen.autoSuitable(temp, {x=888, y=31, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelVisitClan"), General.font1, 15, {colorR = 125, colorG = 123, colorB = 121})
    screen.autoSuitable(temp, {x=470, y=14, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelMembers"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=721, y=43, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(info.members .. "/50", General.font1, 19, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=721, y=22, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemHistorySeperator.png",CCSizeMake(2, 55))
    screen.autoSuitable(temp, {x=115, y=2})
    bg:addChild(temp)
	local rgb = RANK_COLOR[info.rank] or {255, 255, 255}
    temp = UI.createLabel(info.rank .. ".", General.font4, 23, {colorR = rgb[1], colorG = rgb[2], colorB = rgb[3], lineOffset=-12})
    screen.autoSuitable(temp, {x=41, y=29, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    scrollView:addChildTouchNode(bg, showLeagueView, info, {nodeChangeHandler=doNothing})
end

function ClanDialog:getCaesarsCupData(isSuc, result, view)
    if isSuc and not self.deleted then
        local data = json.decode(result)
        if data==None or #data==0 then return end
    	local infos = {}
    	local isNew = true
    	for i=1, #data do
    	    local info = data[i]
    	    --`id`, icon, score, `type`, name, `desc`, members, `min`
    	    local item = {dialog=self, rank=i, clan=info[1], icon=info[2], score=info[3], type=info[4], name=info[5], desc=info[6], members=info[7], min=info[8]}
        	table.insert(infos, item)
    	end
    	
        local scrollView = UI.createScrollViewAuto(CCSizeMake(996, 470), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=infos, cellUpdate=updateRankClanCell})
        screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorLeftBottom, x=12, y=26})
        view:addChild(scrollView.view)
    end
end


function ClanDialog:createCaesarsCupTab()

    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    
    temp = UI.createSpriteWithFile("images/dialogBackLeagueWeek.png",CCSizeMake(986, 204))
    screen.autoSuitable(temp, {x=17, y=503})
    bg:addChild(temp)
    if UserData.leagueWarTime and UserData.leagueWarTime>timer.getTime() and (UserData.leagueWarTime<UserData.nextLeagueWarTime or UserData.nextLeagueWarTime<timer.getTime()) then
        temp = UI.createLabel(StringManager.getTimeString(UserData.leagueWarTime-timer.getTime()), General.font3, 21, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=508, y=545, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("labelTimeCount"), General.font3, 17, {colorR = 255, colorG = 170, colorB = 172})
        screen.autoSuitable(temp, {x=499, y=546, nodeAnchor=General.anchorRight})
        bg:addChild(temp)
    else
        temp = UI.createLabel(StringManager.getTimeString(UserData.nextLeagueWarTime-timer.getTime()), General.font3, 21, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=508, y=545, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("labelNextTimeCount"), General.font3, 17, {colorR = 255, colorG = 170, colorB = 172})
        screen.autoSuitable(temp, {x=499, y=546, nodeAnchor=General.anchorRight})
        bg:addChild(temp)
    end
    temp = UI.createLabel(StringManager.getString("labelCaesarsCupIntro"), General.font1, 17, {colorR = 7, colorG = 7, colorB = 139, size=CCSizeMake(290, 60), align=kCCTextAlignmentLeft})
    screen.autoSuitable(temp, {x=848, y=626, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/leagueWarInfo.png", CCSizeMake(51, 51))
    simpleRegisterButton(temp, {callback=display.showDialog, callbackParam=LeagueWarIntroDialog, nodeChangeHandler=UI.defaultButtonTouchHandler()})
    screen.autoSuitable(temp, {x=685, y=555, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
	network.httpRequest("getCaesarsCupRank", self.getCaesarsCupData, {callbackParam=bg, params={uid=UserData.userId}}, self)
    return bg
end

local function updateLeagueCell(bg, scrollView, info)
    bg:removeAllChildrenWithCleanup(true)
    local imageFile = "images/dialogItemLeagueA.png"
    if info.clan==UserData.clan then
        imageFile = "images/dialogItemLeagueA2.png"
    end
    local temp = UI.createSpriteWithFile(imageFile,CCSizeMake(986, 58))
    screen.autoSuitable(temp)
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. info.icon .. ".png",CCSizeMake(39, 44))
    screen.autoSuitable(temp, {x=12, y=8})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemRankScoreBg.png",CCSizeMake(156, 41))
    screen.autoSuitable(temp, {x=823, y=10})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/score.png",CCSizeMake(37, 42))
    screen.autoSuitable(temp, {x=934, y=10})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.score), General.font3, 23, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=885, y=31, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("typeLeague" .. info.type), General.font1, 15, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=62, y=14, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel(info.name, General.font6, 18, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=64, y=36, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelVisitClan"), General.font1, 15, {colorR = 125, colorG = 123, colorB = 121})
    screen.autoSuitable(temp, {x=470, y=14, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelMembers"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=721, y=43, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(info.members .. "/50", General.font1, 19, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=721, y=22, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    scrollView:addChildTouchNode(bg, showLeagueView, info, {nodeChangeHandler=doNothing})
end

local function beginReplay(suc, result)
    if suc then
        local data = json.decode(result)
        --({seed=, data=ReplayLogic.buildData, cmdList=ReplayLogic.cmdList})
        ReplayLogic.randomSeed = data.seed
        ReplayLogic.buildData = data.data
        ReplayLogic.cmdList = data.cmdList
        ReplayLogic.isZombie = false
    	display.pushScene(ReplayScene.new(), PreBattleScene)
    	--UserStat.stat(UserStatType.HISTORY_VIDEO)
    end
end

local function onVideo(info)
    network.httpRequest("getReplay", beginReplay, {single=true, params={uid=UserData.uid, vid=info.binfo[4]}})
end

local function getBattleMemberDataOver(suc, result, bid)

    local mainScene = display.getCurrentScene(1)
    if suc and display.getCurrentScene()==mainScene and not display.isSceneChange then
        local data = json.decode(result)
        if data.code~=0 then
            display.pushNotice(UI.createNotice(StringManager.getString("noticeLeagueBattleFail" .. data.code)))
        else
	        mainScene:synData()
	        BattleLogic.isLeagueBattle = UserData.clanBattleId
            UserData.enemyId = UserData.clanBattleId
    		BattleLogic.enemyClan = data.clan
    		BattleLogic.leagueBattleId = bid
            local scene = BattleScene.new()
            scene.initInfo = data
            display.pushScene(scene, PreBattleScene)
        end
    end
    UserData.clanBattleId = nil
end

local function onBattleWithMember(info)
    if info.uid>0 then
        local scene = display.getCurrentScene()
        if not network.single and BattleLogic.checkBattleEnable(scene, onBattleWithMember, info) then
            BattleLogic.enemyMtype = info.mtype
            if network.httpRequest("getLeagueMemberData", getBattleMemberDataOver, {single=true,params={uid=UserData.userId, eid=info.uid}, callbackParam=info.binfo[6]}) then
                UserData.clanBattleId = info.uid
            end
    	end
    end
end

local function updateBattleClanMemberCell(bg, scrollView, info)
    local temp
    local imageFile = "images/dialogItemLeagueA.png"
    if info.uid==UserData.userId then
        imageFile = "images/dialogItemLeagueA2.png"
    end
    temp = UI.createSpriteWithFile(imageFile,CCSizeMake(986, 58))
    screen.autoSuitable(temp)
    bg:addChild(temp)
    if info.binfo and info.binfo[4]>0 then
        temp = UI.createLabel(StringManager.getFormatString("labelDefeatBy", {name=info.binfo[3]}), General.font6, 20, {colorR = 251, colorG = 3, colorB = 3})
        screen.autoSuitable(temp, {x=433, y=29, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        
        temp = scrollView:createButton(CCSizeMake(95, 43), onVideo, {callbackParam=info, image="images/buttonGreen.png", text=StringManager.getString("buttonVideo"), fontSize=22, fontName=General.font3})
        screen.autoSuitable(temp, {x=924, y=29, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    else
        temp = UI.createLabel(StringManager.getString("labelExploits"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
        screen.autoSuitable(temp, {x=531, y=40, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(tostring(info.lscore), General.font1, 18, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=531, y=16, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        if info.binfo and info.binfo[2]~=UserData.clan then
            temp = scrollView:createButton(CCSizeMake(95, 43), onBattleWithMember, {callbackParam=info, image="images/buttonEnd.png", text=StringManager.getString("buttonFight"), fontSize=22, fontName=General.font3})
            screen.autoSuitable(temp, {x=924, y=29, nodeAnchor=General.anchorCenter})
            bg:addChild(temp)
        end
    end
    temp = UI.createSpriteWithFile("images/dialogItemRankScoreBg.png",CCSizeMake(156, 41))
    screen.autoSuitable(temp, {x=694, y=10})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/score.png",CCSizeMake(37, 42))
    screen.autoSuitable(temp, {x=805, y=10})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.score),General.font4, 23, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
    screen.autoSuitable(temp, {x=756, y=31, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(info.name, General.font6, 18, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=102, y=37, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    if info.uid~=UserData.userId then
        local w = temp:getContentSize().width * temp:getScaleX()
        temp = UI.createSpriteWithFile("images/chatRoomItemVisit.png",CCSizeMake(26, 26))
        screen.autoSuitable(temp, {x=104+w, y=26})
        bg:addChild(temp)
        UI.registerVisitIcon(bg, scrollView, info.dialog.view, info.uid, temp)
    end
    temp = UI.createLabel(StringManager.getString("mtype" .. info.mtype), General.font1, 15, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=101, y=16, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. info.icon .. ".png",CCSizeMake(39, 45))
    screen.autoSuitable(temp, {x=49, y=8})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.rank), General.font4, 23, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
    screen.autoSuitable(temp, {x=30, y=31, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
end

local function kickoutOver(suc, data, param)
    if suc and json.decode(data).code==0 then
        display.closeDialog()
        display.pushNotice(UI.createNotice(StringManager.getFormatString("noticeSuccessKickout", {name=param[2]}),255))
        network.httpRequest(network.chatUrl .. "sys", doNothing, {params={cid=param[3], type="l", info=json.encode({uid=param[1],name=param[2],k=1})}})
    else
        display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorKickout")))
    end
end

local function kickoutClan(param)
    if param[4] then
        network.httpRequest("leaveClan", kickoutOver, {isPost=true, callbackParam=param, params={uid=param[1], cid=param[3]}})
    else
        local nparam = {param[1],param[2],param[3],true}
        display.showDialog(AlertDialog.new(StringManager.getFormatString("alertTitleKickout", {name=param[2]}), StringManager.getFormatString("alertTextKickout", {name=param[2]}),{callback=kickoutClan, param=nparam}))
    end
end

local function updateClanMemberCell(bg, scrollView, info)
    bg:removeAllChildrenWithCleanup(true)
    local imageFile = "images/dialogItemLeagueB.png"
    if info.uid==UserData.userId then
        imageFile = "images/dialogItemLeagueB2.png"
        UserData.memberType = info.mtype
    end
    local temp = UI.createSpriteWithFile(imageFile,CCSizeMake(986, 58))
    screen.autoSuitable(temp) --{x=18, y=464})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.rank), General.font3, 23, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=23, y=30, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel(info.name, General.font6, 18, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=82, y=35, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    if info.uid~=UserData.userId then
        local w = temp:getContentSize().width * temp:getScaleX()
        temp = UI.createSpriteWithFile("images/chatRoomItemVisit.png",CCSizeMake(26, 26))
        screen.autoSuitable(temp, {x=84+w, y=23})
        bg:addChild(temp)
        local others = nil
        if info.clan and UserData.memberType==2 and UserData.clan==info.clan then
            others = {{text=StringManager.getString("buttonKick"), callbackParam={info.uid, info.name, info.clan}, callback=kickoutClan}}
        end
    	UI.registerVisitIcon(bg, scrollView, info.dialog.view, info.uid, temp, others)
    end
    temp = UI.createLabel(StringManager.getString("mtype" .. info.mtype), General.font1, 15, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=80, y=15, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemRankScoreBg.png",CCSizeMake(156, 41))
    screen.autoSuitable(temp, {x=820, y=9})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/score.png",CCSizeMake(37, 42))
    screen.autoSuitable(temp, {x=931, y=9})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.score), General.font4, 23, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
    screen.autoSuitable(temp, {x=882, y=30, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelExploits"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=714, y=40, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. info.icon .. ".png",CCSizeMake(21, 24))
    screen.autoSuitable(temp, {x=716, y=8})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(info.lscore), General.font1, 19, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=712, y=18, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
end

function ClanDialog:loadMembersOver(suc, result, setting)
    local bg = setting.view
    local clan = setting.clan
    if suc and not self.deleted and (self.memberClan==clan or clan==UserData.clan) then
        local data = json.decode(result)
        if not data then
            return
        end
        for i=1, #data do
            local temp = data[i]
            data[i] = {icon=setting.icon, dialog=self, uid=temp[1], score=temp[2], lscore=temp[3], name=temp[4], mtype=temp[5], clan=clan}
        end
        table.sort(data, getSortFunction("score", true))
        for i=1, #data do
            data[i].rank = i
        end
        local scrollView = UI.createScrollViewAuto(CCSizeMake(996, 500), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=data, cellUpdate=updateClanMemberCell})
        screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorLeftTop, x=12, y=526})
        local function tmpAddChild()
            bg:addChild(scrollView.view)
        end
        xpcall(tmpAddChild, doNothing)
    end
end


function ClanDialog:createLeagueTab(info)
    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    
    temp = UI.createSpriteWithFile("images/dialogBackLeagueInfo.png",CCSizeMake(985, 127))
    screen.autoSuitable(temp, {x=18, y=554})
    bg:addChild(temp)
    temp = UI.createLabel(info.name, General.font6, 20, {colorR = 255, colorG = 255, colorB = 204})
    screen.autoSuitable(temp, {x=129, y=664, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    local labels = {StringManager.getString("labelTotalScore"), StringManager.getString("labelMembers"), StringManager.getString("labelType"), StringManager.getString("labelMinimum")}
    local values = {tostring(info.score), info.members .. "/50", StringManager.getString("typeLeague" .. info.type), tostring(info.min)}
    for i=1, 4 do
        temp = UI.createLabel(labels[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=129, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        temp = UI.createLabel(values[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=400, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorRight})
        bg:addChild(temp)
    end
    temp = UI.createLabel(info.desc, General.font5, 15, {colorR = 0, colorG = 0, colorB = 0, size=CCSizeMake(300, 80), align=kCCTextAlignmentLeft})
    screen.autoSuitable(temp, {x=445, y=670, nodeAnchor=General.anchorLeftTop})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelLeaguePosition"), General.font1, 15, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=447, y=571, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. info.icon .. ".png",CCSizeMake(69, 79))
    screen.autoSuitable(temp, {x=39, y=580})
    bg:addChild(temp)
    if UserData.clan==0 then
        local function joinClanOver(suc, result)
            isJoining = false
            if suc then
                local data = json.decode(result)
                if data.code==0 then
                    UserData.clan = data.clan
                    UserData.clanInfo = data.clanInfo
                    network.httpRequest(network.chatUrl .. "sys", doNothing, {params={cid=data.clan, type="j", info=json.encode({uid=UserData.userId,name=UserData.userName})}})
                    UserData.memberType = 0
                    if not self.deleted then
                        display.closeDialog()
                    end
                    EventManager.sendMessage("EVENT_JOIN_CLAN", UserData.clan)
                    display.pushNotice(UI.createNotice(StringManager.getString("noticeJoinClan"), 255))
                elseif data.code==1 then
                    display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorJoinClan")))
                end
            end
        end
        local isJoining = false
        local function onJoinClan()
            if info.members==50 then
                display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueFull")))
            elseif info.min>UserData.userScore then
                display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueScore")))
            elseif display.getCurrentScene(1):getMaxLevel(2)==0 then
                display.pushNotice(UI.createNotice(StringManager.getString("noticeRebuiltLeague")))
            elseif not isJoining and not network.single then
                isJoining = true
                network.httpRequest("joinClan", joinClanOver, {isPost=true, single=true, params={uid=UserData.userId, cid=info.clan}})
            end
        end
        temp = UI.createButton(CCSizeMake(117, 43), onJoinClan, {image="images/buttonGreen.png", text=StringManager.getString("buttonJoin"), fontSize=20, fontName=General.font3})
        screen.autoSuitable(temp, {x=937, y=584, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    elseif UserData.clan==info.clan then
        local isLeaving = false
        local function leaveClanOver(suc, result)
            if suc then
                local data = json.decode(result)
                if data.code==0 then
                    network.httpRequest(network.chatUrl .. "sys", doNothing, {params={cid=UserData.clan, type="l", info=json.encode({uid=UserData.userId,name=UserData.userName})}})
                    UserData.clan = 0
                    UserData.clanInfo = nil
                    UserData.memberType = 0
                    if not self.deleted then
                        display.closeDialog()
                    end
                    EventManager.sendMessage("EVENT_JOIN_CLAN", 0)
                    --display.pushNotice(UI.createNotice(StringManager.getString("noticeLeaveClan"), 255))
                elseif data.code==1 then
                    display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeaveClan")))
                end
            end
            isLeaving = false
        end
        local function onLeaveClan()
            if not isLeaving and not network.single then
                isLeaving = true
                network.httpRequest("leaveClan", leaveClanOver, {isPost=true, single=true, params={uid=UserData.userId, cid=info.clan}})
            end
        end
        temp = UI.createButton(CCSizeMake(117, 43), onLeaveClan, {image="images/buttonGreen.png", text=StringManager.getString("buttonLeave"), fontSize=20, fontName=General.font3})
        screen.autoSuitable(temp, {x=937, y=584, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    end
    temp = UI.createSpriteWithFile("images/score.png",CCSizeMake(27, 32))
    screen.autoSuitable(temp, {x=407, y=626})
    bg:addChild(temp)
    
    self.memberClan = info.clan
    network.httpRequest("getClanMembers", self.loadMembersOver, {params={uid=UserData.userId, cid=info.clan}, callbackParam={view=bg, clan=info.clan, icon=info.icon}}, self)
    return bg
end

function ClanDialog:showLeagueTab(info)
    local view = self:createLeagueTab(info)
    local temp = UI.createButton(CCSizeMake(107, 49), self.popTab, {image="images/buttonBack.png", callbackParam=self})
    screen.autoSuitable(temp, {x=66, y=726, nodeAnchor=General.anchorCenter})
    view:addChild(temp)
    self.tabview.pushTab(view)
end

function ClanDialog:createSearchTab()
    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    
    local temp = UI.createSpriteWithFile("images/renameInputBg.png",CCSizeMake(336, 43))
    screen.autoSuitable(temp, {x=510, y=639, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    local searchInput = UI.createTextInput("", General.font5, 20, CCSizeMake(320, 37), kCCTextAlignmentLeft, 15, display.DIALOG_BUTTON_PRI)
    screen.autoSuitable(searchInput, {x=510, y=639, nodeAnchor=General.anchorCenter})
    bg:addChild(searchInput)
    
    local searchScroll = nil
    
    local inSearch = false
    local function onSearchOver(suc, result)
        inSearch = false
        if not suc or self.deleted then return end
        local data = json.decode(result)
        if searchScroll then
            searchScroll.view:removeFromParentAndCleanup(true)
            searchScroll = nil
        end
        if data==nil or #data==0 then
            display.pushNotice(UI.createNotice(StringManager.getString("noticeSearchEmpty")))
        else
            for i=1, #data do
                local temp = data[i]
                data[i] = {dialog=self, clan=temp[1], icon=temp[2], score=temp[3], type=temp[4], name=temp[5], desc=temp[6], members=temp[7], min=temp[8]}
            end
            searchScroll = UI.createScrollViewAuto(CCSizeMake(996, 545), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=data, cellUpdate=updateLeagueCell})
            screen.autoSuitable(searchScroll.view, {x=12, y=26})
            bg:addChild(searchScroll.view)
        end
    end
    
    local function onSearch()
        local s = searchInput:getString()
        if not insearch and s and s~="" then
            inSearch = true
            network.httpRequest("searchClans", onSearchOver, {params={uid=UserData.userId, word=s}})
        end
    end
    
    temp = UI.createLabel(StringManager.getString("labelSearch"), General.font1, 22, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=332, y=639, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelSearchNote"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=347, y=595, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(95, 43), onSearch, {image="images/buttonGreen.png", text=StringManager.getString("buttonSearch"), fontSize=20, fontName=General.font3})
    screen.autoSuitable(temp, {x=752, y=639, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
    return bg
end

function ClanDialog:createLeagueWarTab()
    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    
    local temp = UI.createSpriteWithFile("images/dialogBackLeagueIntro.png",CCSizeMake(986, 126))
    screen.autoSuitable(temp, {x=17, y=555})
    bg:addChild(temp)
    
    if UserData.clanInfo[10]~=2 then
        temp = UI.createLabel(UserData.clanInfo[5], General.font6, 20, {colorR = 255, colorG = 255, colorB = 204})
        screen.autoSuitable(temp, {x=129, y=664, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        
        temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(272, 2))
        screen.autoSuitable(temp, {x=128, y=631})
        bg:addChild(temp)
        local labels = {StringManager.getString("labelTotalScore"), StringManager.getString("labelMembers")}
        local values = {tostring(UserData.clanInfo[3]), UserData.clanInfo[7] .. "/50"}
        for i=1, 2 do
            temp = UI.createLabel(labels[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
            screen.autoSuitable(temp, {x=129, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorLeft})
            bg:addChild(temp)
            temp = UI.createLabel(values[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
            screen.autoSuitable(temp, {x=400, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorRight})
            bg:addChild(temp)
        end
        temp = UI.createSpriteWithFile("images/leagueIcon/" .. UserData.clanInfo[2] .. ".png",CCSizeMake(69, 79))
        screen.autoSuitable(temp, {x=39, y=580})
        bg:addChild(temp)
        temp = UI.createSpriteWithFile("images/score.png",CCSizeMake(27, 32))
        screen.autoSuitable(temp, {x=407, y=626})
        bg:addChild(temp)
        
        local view = CCNode:create()
        bg:addChild(view)
        
        self:showPrepareView(view)
    else
            
        temp = UI.createLabel(StringManager.getString("tabLeagueWar"), General.font3, 25, {colorR = 254, colorG = 203, colorB = 55})
        screen.autoSuitable(temp, {x=510, y=622, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getTimeString(timer.getTime(UserData.clanInfo[11])-timer.getTime()), General.font3, 23, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=521, y=588, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("labelTimeCount"), General.font3, 20, {colorR = 255, colorG = 170, colorB = 172})
        screen.autoSuitable(temp, {x=503, y=588, nodeAnchor=General.anchorRight})
        bg:addChild(temp)
        
        local function onGetLeagueInfoOver(suc, result)
            if suc and not self.deleted then
                local info = json.decode(result)
                if info.code==0 then
                    local left1, left2, eid
                    local bid = info.info[1]
                    eid = info.info[2]
                    if eid==UserData.clan then
                        eid = info.info[3]
                        left1 = info.info[4]
                        left2 = info.info[5]
                    else
                        left1 = info.info[5]
                        left2 = info.info[4]
                    end
                    temp = UI.createLabel(UserData.clanInfo[5], General.font6, 20, {colorR = 255, colorG = 255, colorB = 204})
                    screen.autoSuitable(temp, {x=129, y=664, nodeAnchor=General.anchorLeft})
                    bg:addChild(temp)
                    
                    temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(272, 2))
                    screen.autoSuitable(temp, {x=128, y=631})
                    bg:addChild(temp)
                    local labels = {StringManager.getString("labelTotalScore"), StringManager.getString("labelLeftMembers")}
                    local values = {tostring(UserData.clanInfo[3]),  (UserData.clanInfo[7]-left1) .. "/" .. UserData.clanInfo[7]}
                    for i=1, 2 do
                        temp = UI.createLabel(labels[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
                        screen.autoSuitable(temp, {x=129, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorLeft})
                        bg:addChild(temp)
                        temp = UI.createLabel(values[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
                        screen.autoSuitable(temp, {x=400, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorRight})
                        bg:addChild(temp)
                    end
                    temp = UI.createSpriteWithFile("images/leagueIcon/" .. UserData.clanInfo[2] .. ".png",CCSizeMake(69, 79))
                    screen.autoSuitable(temp, {x=39, y=580})
                    bg:addChild(temp)
                    
                    local eclanInfo = info.clan
                    temp = UI.createLabel(eclanInfo[5], General.font6, 20, {colorR = 255, colorG = 255, colorB = 204})
                    screen.autoSuitable(temp, {x=901, y=663, nodeAnchor=General.anchorRight})
                    bg:addChild(temp)
                    local labels = {StringManager.getString("labelTotalScore"), StringManager.getString("labelLeftMembers")}
                    local values = {tostring(eclanInfo[3]), (eclanInfo[7]-left2) .. "/" .. eclanInfo[7]}
                    for i=1, 2 do
                        temp = UI.createLabel(labels[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
                        screen.autoSuitable(temp, {x=630, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorLeft})
                        bg:addChild(temp)
                        temp = UI.createLabel(values[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
                        screen.autoSuitable(temp, {x=901, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorRight})
                        bg:addChild(temp)
                    end
                    temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(272, 2))
                    screen.autoSuitable(temp, {x=629, y=627})
                    bg:addChild(temp)
                    temp = UI.createSpriteWithFile("images/leagueIcon/" .. eclanInfo[2] .. ".png",CCSizeMake(69, 79))
                    screen.autoSuitable(temp, {x=914, y=576})
                    bg:addChild(temp)
                    
                    local function sortBattleMember(m1, m2)
                        local m1b, m2b = false, false
                        if m1.binfo and m1.binfo[4]>0 then
                            m1b = true
                        end
                        if m2.binfo and m2.binfo[4]>0 then
                            m2b = true
                        end
                        if m1b and not m2b then
                            return false
                        elseif not m1b and m2b then
                            return true
                        else
                            return m1.score>m2.score
                        end
                    end
                    
                    --add scroll view
                    local memberMaps = {}
                    for _, item in ipairs(info.info[6]) do
                        memberMaps[item[1]] = item
                        item[6]=bid
                    end
                    local infos = info.smembers
                    for i=1, #infos do
                        local item = infos[i]
                        infos[i] = {icon=UserData.clanInfo[2], uid=item[1], score=item[2], lscore=item[3], name=item[4], mtype=item[5], dialog=self, binfo=memberMaps[item[1]]}
                    end
                    table.sort(infos, sortBattleMember)
                    for i=1, #infos do
                        infos[i].rank = i
                    end
                    local scrollView1 = UI.createScrollViewAuto(CCSizeMake(996, 500), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=infos, cellUpdate=updateBattleClanMemberCell})
                    screen.autoSuitable(scrollView1.view, {nodeAnchor=General.anchorLeftTop, x=12, y=526})
                    bg:addChild(scrollView1.view)
                    scrollView1.view:setVisible(false)
                    infos = info.members
                    for i=1, #infos do
                        local item = infos[i]
                        infos[i] = {icon=eclanInfo[2], uid=item[1], score=item[2], lscore=item[3], name=item[4], mtype=item[5], dialog=self, binfo=memberMaps[item[1]]}
                    end
                    table.sort(infos, sortBattleMember)
                    for i=1, #infos do
                        infos[i].rank = i
                    end
                    local scrollView2 = UI.createScrollViewAuto(CCSizeMake(996, 500), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=infos, cellUpdate=updateBattleClanMemberCell})
                    screen.autoSuitable(scrollView2.view, {nodeAnchor=General.anchorLeftTop, x=12, y=526})
                    bg:addChild(scrollView2.view)
                    
                    local detail1, detai2
                    local function onShowSelfDetail()
                        scrollView2.view:setVisible(false)
                        scrollView1.view:setVisible(true)
                        
                        UI.closeVisitControl(self.view)
                    end
                    local function onShowEnemyDetail()
                        scrollView1.view:setVisible(false)
                        scrollView2.view:setVisible(true)
                        
                        UI.closeVisitControl(self.view)
                    end
                    temp = UI.createButton(CCSizeMake(99, 47), onShowSelfDetail, {image="images/buttonGreen.png", text=StringManager.getString("buttonDetail"), fontSize=22, fontName=General.font3})
                    screen.autoSuitable(temp, {x=176, y=584, nodeAnchor=General.anchorCenter})
                    bg:addChild(temp)
                    detail1 = temp
                    temp = UI.createButton(CCSizeMake(99, 47), onShowEnemyDetail, {image="images/buttonGreen.png", text=StringManager.getString("buttonDetail"), fontSize=22, fontName=General.font3})
                    screen.autoSuitable(temp, {x=844, y=584, nodeAnchor=General.anchorCenter})
                    bg:addChild(temp)
                    detail2 = temp
                else
                    --notice?
                    display.closeDialog()
                end
            end
        end
        
        network.httpRequest("getLeagueBattleInfo", onGetLeagueInfoOver, {params={uid=UserData.userId, cid=UserData.clan}})
    end

    return bg
end

function ClanDialog:showPrepareView(view)
    view:removeAllChildrenWithCleanup(true)
    
    if UserData.clanInfo[10]==0 then
        local function onFindEnemy()
            self:showFindingView(view)
        end
        local temp = UI.createButton(CCSizeMake(99, 47), onFindEnemy, {image="images/buttonGreen.png", text=StringManager.getString("buttonFindEnemy"), fontSize=20, fontName=General.font3, lineOffset=-12})
        screen.autoSuitable(temp, {x=175, y=583, nodeAnchor=General.anchorCenter})
        view:addChild(temp)
        temp = UI.createLabel(StringManager.getString("labelLeagueBattle"), General.font3, 22+NORMAL_SIZE_OFF, {colorR = 205, colorG = 184, colorB = 137, size=CCSizeMake(900, 0)})
        screen.autoSuitable(temp, {x=510, y=373, nodeAnchor=General.anchorCenter})
        view:addChild(temp)
    else
        local function onCancelFindEnemyOver(suc, result)
            if suc then
                local data = json.decode(result)
                if data.code==1 then
                    display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueBattle")))
                elseif data.code==2 then
                    display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueBattleAuth")))
                    UserData.memberType = 0
                elseif data.code==3 then
                    UserData.clanInfo[10] = data.state
                    UserData.clanInfo[11]= data.statetime
                else
                    UserData.clanInfo[10] = 0
                    self:showPrepareView(view)
                end
            end
        end
        local function onCancelFindEnemy()
            network.httpRequest("cancelFindLeagueEnemy", onCancelFindEnemyOver, {isPost=true, single=true, params={uid=UserData.userId, cid=UserData.clan}})
        end
        local temp = UI.createButton(CCSizeMake(99, 47), onCancelFindEnemy, {image="images/buttonOrangeB.png", text=StringManager.getString("buttonCancel"), fontSize=20, fontName=General.font3})
        screen.autoSuitable(temp, {x=175, y=583, nodeAnchor=General.anchorCenter})
        view:addChild(temp)
        temp = UI.createLabel(StringManager.getString("labelLeagueWaitBattle"), General.font3, 22+NORMAL_SIZE_OFF, {colorR = 255, colorG = 255, colorB = 255, size=CCSizeMake(900, 0)})
        screen.autoSuitable(temp, {x=510, y=373, nodeAnchor=General.anchorCenter})
        view:addChild(temp)
    end
end

function ClanDialog:showFindingView(view, lastId)
    local function onFindEnemyOver(suc, result)
        if suc and not self.deleted then
            local info = json.decode(result)
            if info.code>0 then
                if info.code==3 then
                    UserData.clanInfo[10] = info.state
                    UserData.clanInfo[11]= info.statetime
                    if not self.deleted then
                        display.closeDialog()
                    end
                else
                    display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueBattleAuth")))
                    UserData.memberType = 0
                    self:showPrepareView(view)
                end
            else
                info = info.enemy
                if info[1]>0 then
                    self:showFindedView(view, {id=info[1], icon=info[2], score=info[3], type=info[4], name=info[5], desc=info[6], members=info[7], memberInfos=info[8]})
                else
                    UserData.clanInfo[10] = 1
                    self:showPrepareView(view)
                end
            end
        end
    end
    view:removeAllChildrenWithCleanup(true)
    
    network.httpRequest("findLeagueEnemy", onFindEnemyOver, {isPost=true, params={uid=UserData.userId, cid=UserData.clan, score=UserData.clanInfo[3], eid=lastId}})
    
    local temp = UI.createSpriteWithFile("images/findEnemyIcon.png",CCSizeMake(163, 116))
    screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=480, y=327})
    view:addChild(temp)
    	
    local array = CCArray:create()
    array:addObject(CCEaseSineIn:create(CCMoveBy:create(1, CCPointMake(30, 0))))
    array:addObject(CCEaseSineOut:create(CCMoveBy:create(1, CCPointMake(30, 0))))
    array:addObject(CCEaseSineIn:create(CCMoveBy:create(1, CCPointMake(-30, 0))))
    array:addObject(CCEaseSineOut:create(CCMoveBy:create(1, CCPointMake(-30, 0))))
    temp:runAction(CCRepeatForever:create(CCSequence:create(array)))
    
    array = CCArray:create()
    array:addObject(CCEaseSineOut:create(CCMoveBy:create(1, CCPointMake(0, 20))))
    array:addObject(CCEaseSineIn:create(CCMoveBy:create(1, CCPointMake(0, -20))))
    array:addObject(CCEaseSineOut:create(CCMoveBy:create(1, CCPointMake(0, -20))))
    array:addObject(CCEaseSineIn:create(CCMoveBy:create(1, CCPointMake(0, 20))))
    temp:runAction(CCRepeatForever:create(CCSequence:create(array)))

    temp = UI.createLabel(StringManager.getString("labelFindEnemy"), General.font3, 25, {colorR = 255, colorG = 255, colorB = 181})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=510, y=317})
    view:addChild(temp)
end

function ClanDialog:showFindedView(bg, info)
    bg:removeAllChildrenWithCleanup(true)
    
    local temp = UI.createLabel(info.name, General.font6, 20, {colorR = 255, colorG = 255, colorB = 204})
    screen.autoSuitable(temp, {x=775, y=663, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    local labels = {StringManager.getString("labelTotalScore"), StringManager.getString("labelMembers")}
    local values = {tostring(info.score), info.members .. "/50"}
    for i=1, 2 do
        temp = UI.createLabel(labels[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=630, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        temp = UI.createLabel(values[i], General.font3, LABEL_SIZE, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=901, y=LABEL_BASE_Y-i*23, nodeAnchor=General.anchorRight})
        bg:addChild(temp)
    end
    temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(272, 2))
    screen.autoSuitable(temp, {x=629, y=627})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. info.icon .. ".png",CCSizeMake(69, 79))
    screen.autoSuitable(temp, {x=914, y=576})
    bg:addChild(temp)
    local function onNext()
        self:showFindingView(bg, info.id)
    end
    local isFighting = false
    local function onFightOver(suc, result)
        if suc then
            local rdata = json.decode(result)
            if rdata.code==2 then
                display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueBattleAuth")))
                UserData.memberType = 0
            elseif rdata.code==1 then
                display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorLeagueBattle")))
                self:showPrepareView(bg)
            elseif rdata.code==0 then
    			UserData.clanInfo[10] = 2
    			UserData.clanInfo[11] = timer.getServerTime(timer.getTime()+86400)
    			if not self.deleted then
                    display.closeDialog()
                end
            elseif rdata.code==3 then
                UserData.clanInfo[10] = rdata.state
                UserData.clanInfo[11]= rdata.statetime
            end
        end
        isFighting = false
    end
    local function onFight()
        if not isFighting and not network.single then
            network.httpRequest("beginLeagueBattle", onFightOver, {isPost=true, single=true, params={uid=UserData.userId, cid=UserData.clan, eid=info.id}})
            isFighting = true
        end
    end
    temp = UI.createButton(CCSizeMake(100, 49), onFight, {image="images/buttonOrangeB.png", text=StringManager.getString("buttonFight"), fontSize=22, fontName=General.font3})
    screen.autoSuitable(temp, {x=288, y=583, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(99, 47), onNext, {image="images/buttonGreen.png", text=StringManager.getString("buttonNext"), fontSize=22, fontName=General.font3})
    screen.autoSuitable(temp, {x=176, y=584, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
    --add scroll view
    local infos = info.memberInfos
    for i=1, #infos do
        local item = infos[i]
        infos[i] = {icon=info.icon, uid=item[1], score=item[2], lscore=item[3], name=item[4], mtype=item[5], dialog=self}
    end
    table.sort(infos, getSortFunction("score", true))
    for i=1, #infos do
        infos[i].rank = i
    end
    local scrollView = UI.createScrollViewAuto(CCSizeMake(996, 500), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=infos, cellUpdate=updateBattleClanMemberCell})
    screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorLeftTop, x=12, y=526})
    bg:addChild(scrollView.view)
end

function ClanDialog:createMyLeagueTab()
    local temp = UserData.clanInfo
    local info = {dialog=self, clan=temp[1], icon=temp[2], score=temp[3], type=temp[4], name=temp[5], desc=temp[6], members=temp[7], min=temp[8]}
    local bg = self:createLeagueTab(info)
    
    if UserData.memberType==2 then
        local function onEdit()
            self.curTab = editTabIndex
            self.tabview.changeTab(editTabIndex)
        end
        temp = UI.createButton(CCSizeMake(117, 43), onEdit, {image="images/buttonGreen.png", text=StringManager.getString("buttonEdit"), fontSize=20, fontName=General.font3})
        screen.autoSuitable(temp, {x=937, y=638, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    end
    return bg
end

function ClanDialog:loadJoinClanOver(suc, result, bg)
    if not self.deleted and suc then
        local data = json.decode(result)
        if data==nil or #data==0 then
        
        else
            for i=1, #data do
                local temp = data[i]
                data[i] = {dialog=self, clan=temp[1], icon=temp[2], score=temp[3], type=temp[4], name=temp[5], desc=temp[6], members=temp[7], min=temp[8]}
            end
            local scrollView = UI.createScrollViewAuto(CCSizeMake(996, 610), false, {offx=5, offy=4, disy=10, size=CCSizeMake(986, 58), infos=data, cellUpdate=updateLeagueCell})
            screen.autoSuitable(scrollView.view, {x=12, y=72})
            bg:addChild(scrollView.view)
        end
    end
end

function ClanDialog:createJoinTab()
    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    
    network.httpRequest("getRandomClans", self.loadJoinClanOver, {params={uid=UserData.userId, score=UserData.userScore}, callbackParam=bg}, self)
    
    return bg
end

function ClanDialog:showBrowserTab()
    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    local temp = UI.createLabel(StringManager.getString("labelSelectSymbol"), General.font1, 25, {colorR = 0, colorG = 0, colorB = 0})
    screen.autoSuitable(temp, {x=510, y=641, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(107, 49), self.popTab, {image="images/buttonBack.png", callbackParam=self})
    screen.autoSuitable(temp, {x=66, y=726, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    local function selectIcon(index)
        TEMP_CLAN_ID=index
        self:popTab()
    end
    for i=1, 60 do
        temp = UI.createSpriteWithFile("images/leagueIcon/" .. i .. ".png",CCSizeMake(66, 76))
        screen.autoSuitable(temp, {x=72+90*((i-1)%10), y=616-98*math.ceil(i/10)})
        bg:addChild(temp)
        simpleRegisterButton(temp, {priority=display.DIALOG_BUTTON_PRI, callback=selectIcon, callbackParam=i})
    end
    self.tabview.pushTab(bg)
end

function ClanDialog:editLeagueOver(suc, result)
    IS_CREATING = false
    if suc and not self.deleted then
        local data = json.decode(result)
        if UserData.clan>0 and UserData.clanInfo and data.code==0 then
            UserData.clanInfo[2] = data.icon
            UserData.clanInfo[5] = data.name
            UserData.clanInfo[6] = data.desc
            UserData.clanInfo[8] = data.min
        end
        if self.curTab==editTabIndex then
            self.curTab = 1
            self.tabview.changeTab(1)
        end
        display.closeDialog()
    end
end

function ClanDialog:createCreateTab(isEdit)
    local bg = CCTouchLayer:create(display.DIALOG_PRI, true)
    bg:setContentSize(CCSizeMake(1020, 765))
    temp = UI.createLabel(StringManager.getString("labelName"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=300, y=605, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelSymbol"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=300, y=546, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelDescription"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=300, y=450, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelType"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74})
    screen.autoSuitable(temp, {x=300, y=344, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelMinimum"), General.font1, 18, {colorR = 90, colorG = 81, colorB = 74, size=CCSizeMake(145, 0), align=kCCTextAlignmentRight})
    screen.autoSuitable(temp, {x=300, y=274, nodeAnchor=General.anchorRight})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("typeLeague1"), General.font3, 22, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=510, y=346, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(63, 49), doNothing, {image="images/dialogItemLeagueRight.png"})
    screen.autoSuitable(temp, {x=678, y=346, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(63, 49), doNothing, {image="images/dialogItemLeagueLeft.png"})
    screen.autoSuitable(temp, {x=342, y=346, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(tostring(TEMP_MIN_SCORE), General.font3, 22, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=510, y=281, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    local scoreLabel = temp
    local function changeMinScore(add)
        TEMP_MIN_SCORE = squeeze(TEMP_MIN_SCORE+add, 0, math.floor(UserData.userScore/100)*100)
        scoreLabel:setString(tostring(TEMP_MIN_SCORE))
    end
    temp = UI.createButton(CCSizeMake(63, 49), changeMinScore, {callbackParam=100, image="images/dialogItemLeagueRight.png"})
    screen.autoSuitable(temp, {x=678, y=281, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(63, 49), changeMinScore, {callbackParam=-100, image="images/dialogItemLeagueLeft.png"})
    screen.autoSuitable(temp, {x=342, y=281, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(395, 3))
    screen.autoSuitable(temp, {x=510, y=312, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/renameInputBg.png",CCSizeMake(336, 43))
    screen.autoSuitable(temp, {x=510, y=450, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    local descInput = UI.createTextInput("", General.font5, 20, CCSizeMake(320, 37), kCCTextAlignmentLeft, 210, display.DIALOG_BUTTON_PRI)
    screen.autoSuitable(descInput, {x=510, y=450, nodeAnchor=General.anchorCenter})
    bg:addChild(descInput)
    temp = UI.createButton(CCSizeMake(117, 43), self.showBrowserTab, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonBrowser"), fontSize=20, fontName=General.font3})
    screen.autoSuitable(temp, {x=546, y=548, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/renameInputBg.png",CCSizeMake(336, 43))
    screen.autoSuitable(temp, {x=510, y=607, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    local nameInput = UI.createTextInput("", General.font5, 20, CCSizeMake(320, 37), kCCTextAlignmentLeft, 24, display.DIALOG_BUTTON_PRI)
    screen.autoSuitable(nameInput, {x=510, y=607, nodeAnchor=General.anchorCenter})
    bg:addChild(nameInput)
    temp = UI.createSpriteWithFile("images/leagueIcon/" .. TEMP_CLAN_ID .. ".png",CCSizeMake(47, 54))
    screen.autoSuitable(temp, {x=408, y=521})
    bg:addChild(temp)
    local licon = temp
    local function changeLeagueIcon(enter)
        if enter then
            licon:setTexture(CCTextureCache:sharedTextureCache():addImage("images/leagueIcon/" .. TEMP_CLAN_ID .. ".png"))
        end
    end
    simpleRegisterEvent(licon, {enterOrExit={callback=changeLeagueIcon}})
    
    if isEdit then
        if not UserData.clanInfo then
            display.closeDialog()
            return
        end
        TEMP_CLAN_ID = UserData.clanInfo[2]
        licon:setTexture(CCTextureCache:sharedTextureCache():addImage("images/leagueIcon/" .. TEMP_CLAN_ID .. ".png"))
        TEMP_MIN_SCORE = UserData.clanInfo[8]
        scoreLabel:setString(tostring(TEMP_MIN_SCORE))
        nameInput:setString(UserData.clanInfo[5])
        descInput:setString(UserData.clanInfo[6])
        
        local function editLeague()
            local name=nameInput:getString()
            local desc=descInput:getString()
            local clanIconId = TEMP_CLAN_ID
            local leagueType=1
            local minScore = TEMP_MIN_SCORE
            if name=="" or IS_CREATING then return end
            local function send()
                IS_CREATING=true
                network.httpRequest("editClan", self.editLeagueOver, {isPost=true, params={cid=UserData.clan, icon=clanIconId, min=minScore, name=name, desc=desc, type=leagueType, uid=UserData.userId}}, self)
            end
            network.checkWord(name .. " " .. desc, send)
        end
        
        temp = UI.createButton(CCSizeMake(172, 76), editLeague, {image="images/buttonGreen.png", text=StringManager.getString("buttonSave"), fontSize=28, fontName=General.font3})
        screen.autoSuitable(temp, {x=510, y=195, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    else
        local cost = 40000
        local function createLeague()
            local name=nameInput:getString()
            local desc=descInput:getString()
            local clanIconId = TEMP_CLAN_ID
            local leagueType=1
            local minScore = TEMP_MIN_SCORE
            if name=="" or IS_CREATING then return end
            local function send()
                if not network.single and ResourceLogic.checkAndCost({costType="oil", costValue=cost}, createLeague) then
                    IS_CREATING=true
                    network.httpRequest("createClan", self.createLeagueOver, {isPost=true, single=true, params={icon=clanIconId, min=minScore, name=name, desc=desc, type=leagueType, uid=UserData.userId}}, self)
                end
            end
            network.checkWord(name .. " " .. desc, send)
        end
        
        temp = UI.createButton(CCSizeMake(172, 76), createLeague, {image="images/buttonGreen.png"})
        screen.autoSuitable(temp, {x=510, y=195, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        local temp1 = UI.createSpriteWithFile("images/oil.png",CCSizeMake(38, 43))
        screen.autoSuitable(temp1, {x=121, y=14})
        temp:addChild(temp1)
    	local colorSetting = {colorR=255, colorG=255, colorB=255, lineOffset=-12}
    	if ResourceLogic.getResource("oil")<cost then
    		colorSetting.colorG=0
    	    colorSetting.colorB=0
    	end
    	temp1 = UI.createLabel(tostring(cost), General.font4, 28, colorSetting)
    	screen.autoSuitable(temp1, {nodeAnchor=General.anchorCenter, x=68, y=36})
    	temp:addChild(temp1)
	end
	return bg
end

ClanNoticeDialog=class()

function ClanNoticeDialog:ctor(isEnd)
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    UI.setShowAnimate(bg)
    self.view = bg
    
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    --[[
    temp = UI.createButton(CCSizeMake(133, 60), on战斗!, {image="images/buttonGreen.png", text=StringManager.getString("战斗!"), fontSize=25, fontName="General.font3"})
    screen.autoSuitable(temp, {x=379, y=118, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(133, 60), on详情, {image="images/buttonOrange.png", text=StringManager.getString("详情"), fontSize=25, fontName="General.font3"})
    screen.autoSuitable(temp, {x=551, y=118, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    --]]
    if isEnd then
        isWin = 0
        if isEnd~=UserData.clan then
            isWin = 1
        end
        self.shareText = StringManager.getString("labelLeagueBattleEnd" .. isWin)
        temp = UI.createLabel(self.shareText, General.font1, 25, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(400, 120)})
        screen.autoSuitable(temp, {x=465, y=297, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createButton(CCSizeMake(133, 60), self.share, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonShare"), fontSize=25, fontName=General.font3})
        screen.autoSuitable(temp, {x=465, y=118, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("titleLeagueWarEnd" .. isWin), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
        screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    else
        temp = UI.createLabel(StringManager.getString("labelLeagueBattleBegin"), General.font1, 25, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(400, 120)})
        screen.autoSuitable(temp, {x=465, y=297, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createButton(CCSizeMake(133, 60), self.openClanDialog, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonFight"), fontSize=25, fontName=General.font3})
        screen.autoSuitable(temp, {x=465, y=118, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("tabLeagueWar"), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
        screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getTimeString(timer.getTime(UserData.clanInfo[11])-timer.getTime()), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255})
        screen.autoSuitable(temp, {x=465, y=216, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    end
    temp = UI.createButton(CCSizeMake(50, 49), display.closeDialog, {image="images/buttonClose.png"})
    screen.autoSuitable(temp, {x=681, y=488, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/soldierFeature8.png",CCSizeMake(222, 301))
    screen.autoSuitable(temp, {x=48, y=111})
    bg:addChild(temp)
end

function ClanNoticeDialog:openClanDialog()
    display.showDialog(ClanDialog.new(3))
end

function ClanNoticeDialog:share()
	SNS.share(SNS.shareText, nil, self, 1)
	UserStat.stat(UserStatType.SHARE)
end