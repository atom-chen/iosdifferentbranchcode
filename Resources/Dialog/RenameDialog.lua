
RenameDialog = class()

function RenameDialog:onRename()
    local name = self.input:getString()
    if name=="" then return end
    display.closeDialog()
    local function rename()
        UserData.userName = name
    end
    network.checkWord(name, rename)
end

function RenameDialog:ctor()
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(444, 279), doNothing, {image="images/dialogBgC.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    temp = UI.createLabel(StringManager.getString("titleRename"), General.font3, 25, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=222, y=229, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(169, 76), self.onRename, {callbackParam=self, image="images/buttonGreen.png", text=StringManager.getString("buttonYes"), fontSize=25, fontName=General.font3})
    screen.autoSuitable(temp, {x=222, y=60, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("labelRenameTips"), General.font1, 18, {colorR = 124, colorG = 124, colorB = 124})
    screen.autoSuitable(temp, {x=222, y=122, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createSpriteWithFile("images/renameInputBg.png",CCSizeMake(336, 43))
    screen.autoSuitable(temp, {x=222, y=166, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    self.view = bg
	local input = UI.createTextInput("", General.font1, 22, CCSizeMake(324, 36), kCCTextAlignmentCenter, 24, display.DIALOG_BUTTON_PRI)
	screen.autoSuitable(input, {x=222, y=166, nodeAnchor=General.anchorCenter})
	input:setColor(ccc3(0,0,0))
	bg:addChild(input)
	self.input = input
end