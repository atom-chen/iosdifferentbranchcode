DailyDialog = class()

function DailyDialog:share()
    SNS.share(SNS.shareText, nil, self)
    UserStat.stat(UserStatType.SHARE)
end

function DailyDialog:ctor(reward, days)
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    self.view = bg
    UI.setShowAnimate(bg)
    if days~=7 and days~=14 and days~=30 then
        temp = UI.createButton(CCSizeMake(47, 46), display.closeDialog, {image="images/buttonClose.png"})
        screen.autoSuitable(temp, {x=684, y=491, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    end
    
    local spDays = {7,14,30}
    local spRate = {2,3,5}
    local function getReward(which)
        if spDays[which]~=days then return end
        local gain = reward * spRate[which]
        display.closeDialog()
        CrystalLogic.changeCrystal(gain)
        CrystalLogic.rewardDay = days
        display.pushNotice(UI.createNotice(StringManager.getFormatString("noticeRemoveObstacle", {num=gain}), 255))
    end
    
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/loginFeature.png",CCSizeMake(256, 326))
    screen.autoSuitable(temp, {x=26, y=96})
    bg:addChild(temp)
    for i=1, 3 do
        local sday = spDays[i]
        temp = UI.createLabel(StringManager.getFormatString("textDay", {day=sday}), General.font1, 22, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=163+155*i, y=168, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createButton(CCSizeMake(135, 61), getReward, {useExtendNode=true, callbackParam=i, image="images/buttonGreen.png", text=StringManager.getFormatString("textReward",{rate=spRate[i]}), fontSize=25, fontName=General.font3})
        screen.autoSuitable(temp, {x=163+155*i, y=116, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        if sday~=days then
            temp:setSatOffset(-100, true)
        end
    end
    
    temp = UI.createLabel(StringManager.getString("dialogTipsDaily"), General.font1, 28, {colorR = 109, colorG = 121, colorB = 239, align=kCCTextAlignmentLeft, size=CCSizeMake(360, 50)})
    screen.autoSuitable(temp, {x=294, y=250, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getFormatString("textDaily", {reward=reward}), General.font3, 28, {colorR = 255, colorG = 255, colorB = 255, align=kCCTextAlignmentLeft, size=CCSizeMake(360, 100)})
    screen.autoSuitable(temp, {x=293, y=343, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getFormatString("titleDaily", {day=days}), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
end

VipDialog = class()

function VipDialog:share()
    SNS.share(SNS.shareText, nil, self)
    UserStat.stat(UserStatType.SHARE)
end

function VipDialog:ctor()

    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    self.view = bg
    UI.setShowAnimate(bg)
    
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/soldierFeature8.png",CCSizeMake(294, 398))
    screen.autoSuitable(temp, {x=-11, y=63})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(135, 61), self.share, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonShare"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=388, y=126, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(135, 61), display.closeDialog, {image="images/buttonOrange.png", text=StringManager.getString("buttonOk"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=575, y=126, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
    temp = UI.createLabel(StringManager.getString("textVip"), General.font1, 23, {size=CCSizeMake(470, 220), align=kCCTextAlignmentLeft, colorR = 60, colorG = 138, colorB = 232})
    screen.autoSuitable(temp, {x=212, y=286, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel("VIP", General.font3, 28, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
end

RewardDialog = class()

function RewardDialog:ctor(reward, remark)
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    UI.setShowAnimate(bg)
    self.view = bg
    
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    self.shareText = remark
    temp = UI.createLabel(self.shareText, General.font1, 25, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(400, 120)})
    screen.autoSuitable(temp, {x=465, y=297, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(133, 60), self.share, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonShare"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=465, y=118, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("titleReward"), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(50, 49), display.closeDialog, {image="images/buttonClose.png"})
    screen.autoSuitable(temp, {x=681, y=488, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/soldierFeature8.png",CCSizeMake(222, 301))
    screen.autoSuitable(temp, {x=48, y=111})
    bg:addChild(temp)
end

function RewardDialog:share()
    SNS.share(SNS.shareText, nil, self)
    UserStat.stat(UserStatType.SHARE)
end