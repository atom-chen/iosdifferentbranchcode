AlertDialog = class()

function AlertDialog:executeFunction()
    if self.deleted then return end
    local callback = self.alertSetting.callback
    local param = self.alertSetting.param
    display.closeDialog()
    if self.delegate then
        callback(self.delegate, param)
    else
        callback(param)
    end
end

function AlertDialog:ctor(title, text, setting, delegate)
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(443, 279), doNothing, {image="images/dialogBgC.png", priority=display.DIALOG_PRI-2, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    UI.setShowAnimate(bg)
    
    self.isAlert = true
    self.alertSetting = setting
    self.delegate = delegate
    
    local btext = setting.cancelText or StringManager.getString("buttonCancel")
    temp = UI.createButton(CCSizeMake(169, 76), display.closeDialog, {priority=display.DIALOG_BUTTON_PRI-2, callbackParam=true, image="images/buttonOrange.png", text=btext, fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=121, y=65, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    if setting.crystal then
        temp = UI.createButton(CCSizeMake(169, 76), self.executeFunction, {priority=display.DIALOG_BUTTON_PRI-2, callbackParam=self, image="images/buttonGreen.png"})
        screen.autoSuitable(temp, {x=319, y=66, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        
        local colorSetting = {colorR=255, colorG=255, colorB=255, lineOffset=-12}
        if setting.crystal>UserData.crystal then
            colorSetting.colorG=0
            colorSetting.colorB=0
        end
        local temp1 = UI.createLabel(tostring(setting.crystal), General.font4, 25, colorSetting)
        screen.autoSuitable(temp1, {nodeAnchor=General.anchorCenter, x=85, y=38})
        temp:addChild(temp1)
        local w = temp1:getContentSize().width/2 * temp1:getScaleX()
        temp1 = UI.createSpriteWithFile("images/crystal.png",CCSizeMake(49, 48))
        screen.autoSuitable(temp1, {x=88+w, y=12})
        temp:addChild(temp1)
        
        if not GuideLogic.complete then
            temp = UI.createGuidePointer(90)
            temp:setPosition(407, 65)
            bg:addChild(temp)
        end
    else
        btext = setting.okText or StringManager.getString("buttonYes")
        temp = UI.createButton(CCSizeMake(169, 76), self.executeFunction, {priority=display.DIALOG_BUTTON_PRI-2, callbackParam=self, image="images/buttonGreen.png", text=btext, fontSize=25, fontName=General.font3, lineOffset=setting.lineOffset})
        screen.autoSuitable(temp, {x=319, y=66, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    end
    if setting.forceTTF then
        temp = UI.createLabel(title, General.font6, 25, {colorR = 255, colorG = 255, colorB = 255})
    else
        temp = UI.createLabel(title, General.font3, 25, {colorR = 255, colorG = 255, colorB = 255})
    end
    screen.autoSuitable(temp, {x=222, y=233, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
    if setting.img then
        temp = UI.createScaleSprite(setting.img,CCSizeMake(77, 90))
        screen.autoSuitable(temp, {x=102, y=158, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        if setting.forceTTF then
            temp = UI.createLabel(text, General.font5, 18, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(340, 60)})
        else
            temp = UI.createLabel(text, General.font1, 18, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(340, 60)})
        end
        screen.autoSuitable(temp, {x=268, y=167, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    else
        if setting.forceTTF then
            temp = UI.createLabel(text, General.font5, 18, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(386, 60)})
        else
            temp = UI.createLabel(text, General.font1, 18, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(386, 60)})
        end
        screen.autoSuitable(temp, {x=222, y=167, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    end
    
    self.view = bg
end