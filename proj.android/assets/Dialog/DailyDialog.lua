DailyDialog = class()

function DailyDialog:share()
    local text = self.shareText
	SNS.share(text, nil, self)
	UserStat.stat(UserStatType.SHARE)
end

function DailyDialog:ctor(reward)
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    self.view = bg
	UI.setShowAnimate(bg)
	
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/loginFeature.png",CCSizeMake(256, 326))
    screen.autoSuitable(temp, {x=26, y=96})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(135, 61), self.share, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonShare"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=388, y=126, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(135, 61), display.closeDialog, {image="images/buttonOrange.png", text=StringManager.getString("buttonOk"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=575, y=126, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    self.shareText = StringManager.getFormatString("textDaily", {reward=reward})
    temp = UI.createLabel(self.shareText, General.font3, 28, {size=CCSizeMake(385, 100), align=kCCTextAlignmentLeft, colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=482, y=282, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("titleDaily"), General.font3, 28, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
end

VipDialog = class()

function VipDialog:share()

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
    
    temp = UI.createLabel(StringManager.getString("textVip"), General.font1, 23, {size=CCSizeMake(470, 180), align=kCCTextAlignmentLeft, colorR = 60, colorG = 138, colorB = 232})
    screen.autoSuitable(temp, {x=212, y=286, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    temp = UI.createLabel("VIP", General.font3, 28, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
end