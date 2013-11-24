RewardNewDialog = class()

function UserData.loadRewards(rewards)
    if not rewards then return end
    for i=1, #rewards do
        if rewards[i][2]==1 and UserData.leftDay and UserData.leftDay>0 then
            table.insert(UserData.allRewards, rewards[i])
        end
    end
end

local function getReward(reward)
    if reward[3]==0 then
        CrystalLogic.changeCrystal(reward[4], UserData.rcc-reward[4])
    elseif reward[3]==1 then
        ResourceLogic.changeResource("food", reward[4])
        ResourceLogic.changeResource("oil", reward[4])
    end
    table.insert(UserData.getRewardList, reward[1])
end

local onGetReward

local function updateRewardCell(bg, scrollView, data)
    local temp
    local content
    local type = data[2]
    local jdata = json.decode(data[5])
    if jdata.day==data[6] then
        temp = UI.createSpriteWithFile("images/dialogItemLeagueA2.png",CCSizeMake(680, 58))
    else
        temp = UI.createSpriteWithFile("images/dialogItemLeagueA.png",CCSizeMake(680, 58))
    end
    screen.autoSuitable(temp, {x=0, y=0})
    bg:addChild(temp)
    content = StringManager.getFormatString("cellTitleNew",{day=jdata.day})
    temp = UI.createLabel(content, General.font3, 27, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=21, y=29, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
    local offx = 470
    if data[3]==0 then
        temp = UI.createSpriteWithFile("images/crystal.png",CCSizeMake(44, 43))
        screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=offx, y=29})
        bg:addChild(temp)
        temp = UI.createLabel(tostring(data[4]), General.font1, 25, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=offx+27, y=29, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
    else
        temp = UI.createSpriteWithFile("images/oil.png",CCSizeMake(37, 41))
        screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=offx, y=29})
        bg:addChild(temp)
        temp = UI.createLabel(tostring(data[4]), General.font1, 25, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=offx+27, y=29, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
        offx = offx - 135
        
        temp = UI.createSpriteWithFile("images/food.png",CCSizeMake(37, 50))
        screen.autoSuitable(temp, {nodeAnchor=General.anchorCenter, x=offx, y=29})
        bg:addChild(temp)
        temp = UI.createLabel(tostring(data[4]), General.font1, 25, {colorR = 0, colorG = 0, colorB = 0})
        screen.autoSuitable(temp, {x=offx+27, y=29, nodeAnchor=General.anchorLeft})
        bg:addChild(temp)
    end
    if data[1]~=0 then
        temp = scrollView:createButton(CCSizeMake(94, 42), onGetReward, {callbackParam={cell=bg, scrollView=scrollView, data=data}, image="images/buttonGreen.png", text=StringManager.getString("buttonGet"), fontSize=18, fontName=General.font3, lineOffset=-12})
        screen.autoSuitable(temp, {x=620, y=29, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    elseif jdata.day>data[6] then
        temp = scrollView:createButton(CCSizeMake(94, 42), doNothing, {image="images/buttonGreen.png", text=StringManager.getString("buttonGet"), fontSize=18, fontName=General.font3, lineOffset=-12})
        screen.autoSuitable(temp, {x=620, y=29, nodeAnchor=General.anchorCenter})
        temp:setSatOffset(-100,true)
        bg:addChild(temp)
    end
    jdata = nil
end

onGetReward = function(reward)
    local rid = reward.data[1]
    if rid == 0 then return end
    for i=1, #(UserData.allRewards) do
        if UserData.allRewards[i][1]==rid then
            getReward(table.remove(UserData.allRewards, i))
            break
        end
     end
    reward.data[1] = 0
    updateRewardCell(reward.cell, reward.scrollView, reward.data)
end

function RewardNewDialog:ctor()
    local leftDay, rewards = UserData.leftDay, UserData.allRewards
    local temp, bg = nil
    bg = UI.createButton(CCSizeMake(720, 526), doNothing, {image="images/dialogBgA.png", priority=display.DIALOG_PRI, nodeChangeHandler = doNothing})
    screen.autoSuitable(bg, {screenAnchor=General.anchorCenter, scaleType = screen.SCALE_DIALOG_CLEVER})
    UI.setShowAnimate(bg)
    self.view = bg
    
    temp = UI.createSpriteWithFile("images/dialogItemBlood.png",CCSizeMake(292, 222))
    screen.autoSuitable(temp, {x=400, y=50})
    bg:addChild(temp)
    temp = UI.createLabel(StringManager.getFormatString("titleNewGift", {day=leftDay}), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255, lineOffset=-12})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(50, 49), display.closeDialog, {image="images/buttonClose.png"})
    screen.autoSuitable(temp, {x=681, y=488, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    
    local newRewards = {{0,1,1,800,""},{0,1,1,1500,""},{0,1,0,50,""},{0,1,1,3000,""},{0,1,1,5000,""},{0,1,0,100,""}}
    local maxDay = 1
    for i=1, #rewards do
        local reward = rewards[i]
        local tdata = json.decode(reward[5])
        local newReward = newRewards[tdata.day]
        if tdata.day>maxDay then maxDay = tdata.day end
        for j=1,5 do
            newReward[j] = reward[j]
        end
    end 
    for i=1, 6 do
        newRewards[i][6] = maxDay
        if newRewards[i][1]==0 then
            newRewards[i][5] = json.encode({day=i})
        end
    end
    
    local scrollView = UI.createScrollViewAuto(CCSizeMake(690, 400), false, {offx=5,offy=1,disx=0,disy=10,beginIndex=0, rowmax=1, infos=newRewards, cellUpdate=updateRewardCell, size=CCSizeMake(680,58)})
    screen.autoSuitable(scrollView.view, {nodeAnchor=General.anchorLeftTop, x=15, y=448})
    bg:addChild(scrollView.view)
    temp = UI.createLabel(StringManager.getString("labelRewardNew"), General.font1, 20, {colorR = 109, colorG = 121, colorB = 239, lineOffset=-12})
    screen.autoSuitable(temp, {x=25, y=39, nodeAnchor=General.anchorLeft})
    bg:addChild(temp)
end

FirstRewardDialog = class()

function FirstRewardDialog:ctor(crystal)
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
    if not crystal then
        temp = UI.createButton(CCSizeMake(150, 60), StoreDialog.show, {callbackParam="treasure",image="images/buttonGreen.png", text=StringManager.getString("buttonRecharge"), fontSize=26, fontName=General.font3})
        screen.autoSuitable(temp, {x=449, y=134, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getString("textFirstReward"), General.font1, 25, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(400, 120), align=kCCTextAlignmentLeft})
        screen.autoSuitable(temp, {x=475, y=289, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
    else
        temp = UI.createButton(CCSizeMake(150, 60), display.closeDialog, {image="images/buttonGreen.png", text=StringManager.getString("buttonYes"), fontSize=26, fontName=General.font3})
        screen.autoSuitable(temp, {x=449, y=134, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        temp = UI.createLabel(StringManager.getFormatString("textFirstReward2",{crystal=crystal}), General.font1, 25, {colorR = 75, colorG = 66, colorB = 46, size=CCSizeMake(400, 120), align=kCCTextAlignmentLeft})
        screen.autoSuitable(temp, {x=475, y=289, nodeAnchor=General.anchorCenter})
        bg:addChild(temp)
        CrystalLogic.changeCrystal(crystal, UserData.rcc-crystal)
    end
    temp = UI.createLabel(StringManager.getString("titleFirstReward"), General.font3, 30, {colorR = 255, colorG = 255, colorB = 255})
    screen.autoSuitable(temp, {x=360, y=489, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
    temp = UI.createButton(CCSizeMake(47, 46), display.closeDialog, {image="images/buttonClose.png"})
    screen.autoSuitable(temp, {x=683, y=492, nodeAnchor=General.anchorCenter})
    bg:addChild(temp)
end