Defense = class(BuildMould)

function Defense:ctor(bid, setting)
    self.coldTime = 0
    self.noOperationUpdate = true
    self.defenseData = StaticData.getDefenseData(bid)
end

function Defense:setRotateEnable(boolValue)
    self.rotateEnable = boolValue
    self.noOperationUpdate = not boolValue
end

function Defense:addDefenseData(bg)
    local defenseData = self.defenseData

    temp = UI.createLabel(StringManager.getString("propertyRange"), General.font1, 15, {colorR = 33, colorG = 93, colorB = 165})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=140, y=226})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("propertyDamageType"), General.font1, 15, {colorR = 33, colorG = 93, colorB = 165})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=140, y=197})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("propertyTargets"), General.font1, 15, {colorR = 33, colorG = 93, colorB = 165})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=140, y=168})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("propertyFavorite"), General.font1, 15, {colorR = 33, colorG = 93, colorB = 165})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorLeftBottom, x=140, y=139})
    bg:addChild(temp)
    
    local tempStr = defenseData.range .. StringManager.getString("unitRange")
    if defenseData.bid==3002 then
        tempStr = defenseData.extendRange .. " - " .. tempStr
    end
    temp = UI.createLabel(tempStr, General.font1, 15, {colorR=0, colorG=0, colorB=0})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=580, y=226})
    bg:addChild(temp)
    if defenseData.damageRange>0 then
        tempStr = StringManager.getString("typeDamageTypeArea")
    else
        tempStr = StringManager.getString("typeDamageTypeSingle")
    end
    temp = UI.createLabel(tempStr, General.font1, 15, {colorR=0, colorG=0, colorB=0})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=580, y=197})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getString("typeTargets" .. defenseData.attackUnitType), General.font1, 15, {colorR=0, colorG=0, colorB=0})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=580, y=168})
    bg:addChild(temp)
    tempStr = StringManager.getString("dataSoldierName" .. defenseData.favorite)
    if defenseData.favoriteRate > 1 then
        tempStr = tempStr .. StringManager.getFormatString("favoriteRate", {rate=defenseData.favoriteRate})
    end
    temp = UI.createLabel(tempStr, General.font1, 15, {colorR=0, colorG=0, colorB=0})
    screen.autoSuitable(temp, {nodeAnchor=General.anchorRightBottom, x=580, y=139})
    bg:addChild(temp)
    
    for i=1, 4 do
        temp = UI.createSpriteWithFile("images/dialogItemInfoSeperator.png",CCSizeMake(450, 2))
        screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=360, y=106+29*i})
        bg:addChild(temp)
    end
end

function Defense:addBuildInfo(bg, addInfoItem)
    local maxData = StaticData.getMaxLevelData(self.buildData.bid)
    addInfoItem(bg, 1, self.buildData.extendValue1, nil, maxData.extendValue1, "Dps")
    local temp
    
    self:addDefenseData(bg)
    return 1, 115
end

function Defense:addBuildUpgrade(bg, addUpgradeItem)
    local bdata = self.buildData
    local maxData = StaticData.getMaxLevelData(bdata.bid)
    local nextLevel = StaticData.getBuildData(bdata.bid, bdata.level+1)
    
    addUpgradeItem(bg, 1, bdata.extendValue1, nextLevel.extendValue1, maxData.extendValue1, "Dps")
    self:addDefenseData(bg)
    return 1
end

function Defense:canAttack(dis)
    if dis<= self.defenseData.range then
        return true
    end
end

function Defense:getRangeCircle(mapGrid)
    local tr = self.defenseData.range * 1.414
    local size = CCSizeMake(tr * mapGrid.sizeX, tr * mapGrid.sizeY)
    local circle = CCNode:create()
    circle:setContentSize(size)
    local temp = UI.createSpriteWithFile("images/circleBig.png", size)
    screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=size.width/2, y=size.height/2})
    circle:addChild(temp)
    
    return circle
end

function Defense:updateBattle(diff)
    local build = self.buildView
    if self.buildState == BuildStates.STATE_FREE then
        self.coldTime = self.coldTime - diff
        if self.coldTime <= 0 then
            local targetNeedReset = false
            local cx, cy = build.view:getPositionX(), build.view:getPositionY() + self.buildData.gridSize * build.scene.mapGrid.sizeY / 2

            if not self.target or (self.target.stateInfo.action == "dead") then
                targetNeedReset = true
            else
                local tx, ty = self.target.view:getPosition()
                local dis = build.scene.mapGrid:getGridDistance(tx-cx, ty-cy)
                if dis>self.defenseData.range or (self.defenseData.bid==3002 and dis<self.defenseData.extendRange) then
                    targetNeedReset = true
                end
            end
            if targetNeedReset then
                local minTarget = {isFav = false, dis=0}
                for i, soldier in pairs(build.scene.soldiers) do
                    local isFav = false
                    if self.defenseData.favorite >0 and self.defenseData.favorite==soldier.info.sid then
                        isFav = true
                    end
                    if soldier.stateInfo.action ~= "dead" and (isFav or not minTarget.isFav) and (self.defenseData.attackUnitType==3 or self.defenseData.attackUnitType==soldier.info.unitType) then
                        local tx, ty = soldier.view:getPosition()
                        local dis = build.scene.mapGrid:getGridDistance(tx-cx, ty-cy)
                        if self:canAttack(dis) then
                            if not minTarget.target or dis<minTarget.dis then
                                minTarget.dis = dis
                                minTarget.target = soldier
                                minTarget.isFav = isFav
                            end
                        end
                    end
                end
                self.target = minTarget.target
            end
            if self.target then
                while self.coldTime<=0 do
                    if self.rotateEnable then
                        local ox, oy = self.target.view:getPositionX()-build.view:getPositionX(), self.target.view:getPositionY()-build.view:getPositionY()-build.view:getContentSize().height/2
                        local nc = self:changeDirection(ox, oy)
                        if nc then
                            self:updateDirection()
                            self.coldTime = self.coldTime + 0.05
                        else
                            self:attack(self.target)
                        end
                    else
                        self:attack(self.target)
                    end
                end
            else
                self.coldTime = self.coldTime + diff
            end
        end
    end
end

local tsTriangle = {[0]={0, -83}, [1]={-38, -77}, [2]={-70, -61}, [3]={-90, -39}, [4]={-96, -17}, 
                    [5]={-92, 9}, [6]={-78, 28}, [7]={-55, 42}, [8]={-28, 51}, [9]={0, 56}}

function Defense:getAttackPosition(offx, offy, r, dir)
    local xk = 1
    if dir>9 then
        dir=18-dir
        xk=-1
    end
    local x, y = self.buildView.view:getPosition()
    local triangle = tsTriangle[dir]
    x = x+offx+r*triangle[1]*xk
    y = y+offy+self.buildView.view:getContentSize().height/2+r*triangle[2]
    local z = self.buildView.scene.SIZEY - y + offy
    return {x, y, z, math.deg(math.atan2(triangle[2], xk*triangle[1]))}
end

function Defense:attack(target)
    local build = self.buildView
    local p = self:getAttackPosition(0, 30, 0.2, self.direction or 6)
    local shot = SingleShot.new(self.buildData.extendValue1*self.defenseData.attackSpeed, 60, p[1], p[2], p[3], target)
    shot:addToScene(build.scene)
    self.coldTime = self.coldTime + self.defenseData.attackSpeed
end

function Defense:updateDirection()
    if self.stateInfo and self.stateInfo.targetDir then
        local dir = self.direction or 3
        local tdir = self.stateInfo.targetDir
        if dir==tdir then
            self.stateInfo = nil
            return false
        end
        local aoff = math.abs(tdir-dir)
        if aoff>9 then
            dir = dir-(tdir-dir)/aoff
        else
            dir = dir+(tdir-dir)/aoff
        end
        dir = (dir+18)%18
        self.direction = dir
        self:changeDirectionView(dir)
        return true
    end
end

function Defense:enterOperation()
    if self.rotateEnable then
        self.rotatePrefix = self:getRotatePrefix()
    end
end

function Defense:changeDirectionView(dir)
    if not self.rotatePrefix then
        self.rotatePrefix = self:getRotatePrefix()
    end
    if self.buildView then
        local actionNode = convertToSprite(self.buildView.build:getChildByTag(TAG_ACTION))
        actionNode:setFlipX(dir>9)
        if dir>9 then
            dir=18-dir
        end
        actionNode:setDisplayFrame(CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(self.rotatePrefix .. dir .. ".png"))
    end
end

function Defense:changeDirection(offx, offy)
    local temp = (360+math.deg(math.atan2(-offx, -offy)))%360
    local dir = math.floor(temp/20+0.5)%18
    if dir==(self.direction or 3) then
        return false
    end
    self.stateInfo = {targetDir = dir}
    return true
end

function Defense:updateOperationLogic(diff)
    if self.rotateEnable then
        if not self.stateInfo then
            if self.stateTime and self.stateTime>0 then
                self.stateTime = self.stateTime - diff
            else
                self.stateTime = 3
                if self.buildView and self.buildView.build then
                    self.stateInfo = {targetDir = math.random(18)-1}
                    local function rotateMySelf()
                        self:updateDirection()
                        if not self.stateInfo then
                            self.buildView.build:stopAllActions()
                        end
                    end
                    self.buildView.build:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCCallFunc:create(rotateMySelf), CCDelayTime:create(0.1))))
                end
            end
            
        end
    end
end

-- VIEW逻辑， 获取建筑的Y高度
function Defense:getSpecialY(build)
    if self.rotateEnable then
        local b = build:getChildByTag(TAG_ACTION)
        return build:getPositionY() + b:getPositionY() + b:getContentSize().height/2 * b:getScaleY() * build:getScaleY()
    end
    return build:getContentSize().height*build:getScaleY() + build:getPositionY()
end