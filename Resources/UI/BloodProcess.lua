BloodProcess = class()

function BloodProcess:ctor(max, isEnemy)
    self.isEnemy = isEnemy
    self.max = max
    self.value = max
    if isEnemy then
        self.view = UI.createSpriteWithFile("images/hitpointsEnemyBack.png")
        self:changeTexture("Enemy")
    else
        self.view = UI.createSpriteWithFile("images/hitpointsBack.png")
        self:changeTexture("Normal")
    end
    self.view:setOpacity(0)
    self.process:setOpacity(0)
    self.view:setVisible(false)
end

function BloodProcess:changeTexture(textureName)
    if textureName~=self.textureName then
        self.textureName = textureName
        if self.process then
            self.process:removeFromParentAndCleanup(true)
        end
        if self.isEnemy then
            self.process = UI.createSpriteWithFile("images/hitpointsFiller" .. textureName .. ".png", CCSizeMake(95, 13))
            screen.autoSuitable(self.process, {nodeAnchor=General.anchorLeftBottom, x=3, y=3})
        else
            self.process = UI.createSpriteWithFile("images/hitpointsFiller" .. textureName .. ".png", CCSizeMake(55, 8))
            screen.autoSuitable(self.process, {nodeAnchor=General.anchorLeftBottom, x=2, y=2})
        end
        
        UI.registerAsProcess(self.process, self)
        UI.setProcess(self.process, self, self.value/self.max)
        
        self.view:addChild(self.process)
    end
end

local hideActionTag=135

function BloodProcess:changeValue(value, noAction)
    if value<0 then value=0 end
    if value==self.value then return end
    self.value = value
    if not self.isEnemy then
        if value*2>self.max then
            self:changeTexture("Normal")
        elseif value*5>self.max then
            self:changeTexture("Half")
        else
            self:changeTexture("Little")
        end
    end
    UI.setProcess(self.process, self, self.value/self.max)
    if self.hideAction then
        self.view:stopActionByTag(hideActionTag)
        self.hideAction = nil
        self.view:setVisible(true)
        self.view:setOpacity(255)
        self.process:setOpacity(255)
    end
    if noAction then return end
    if not self.view:isVisible() then
        self.view:setVisible(true)
        self.view:setOpacity(255)
        self.process:setOpacity(255)
    end
    local array = CCArray:create()
    array:addObject(CCDelayTime:create(getParam("bloodVisibleTime", 2000)/1000))
    array:addObject(CCAlphaTo:create(getParam("bloodFadeOutTime", 500)/1000, 255, 0))
    array:addObject(CCHide:create())
    local action = CCSequence:create(array)
    action:setTag(hideActionTag)
    self.view:runAction(action)
    self.hideAction = true
end

function UI.createBloodProcess(max, isEnemy)
    return BloodProcess.new(max, isEnemy)
end