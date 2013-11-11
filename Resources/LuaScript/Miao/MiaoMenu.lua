MiaoMenu = class()
function MiaoMenu:ctor(s)
    self.scene = s
    self.bg = CCNode:create()
    setPos(self.bg, {0, 0})
    local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onBuild, delegate=self, text="道路", size=20})
    setPos(but.bg, {50, 50})
    but:setAnchor(0.5, 0.5)
    self.bg:addChild(but.bg)

    local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onOk, delegate=self, text="确定", size=20})
    setPos(but.bg, {150, 50})
    but:setAnchor(0.5, 0.5)
    self.bg:addChild(but.bg)

    local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onPeople, delegate=self, text="人物", size=20, param=1})
    setPos(but.bg, {250, 50})
    but:setAnchor(0.5, 0.5)
    self.bg:addChild(but.bg)
    
    local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onPeople, delegate=self, text="商人", size=20, param=2})
    setPos(but.bg, {350, 50})
    but:setAnchor(0.5, 0.5)
    self.bg:addChild(but.bg)


    --拆除道路和 建筑物
    local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onRemove, delegate=self, text="拆除", size=20, param=2})
    setPos(but.bg, {450, 50})
    but:setAnchor(0.5, 0.5)
    self.bg:addChild(but.bg)

    local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onMove, delegate=self, text="移动", size=20, param=2})
    setPos(but.bg, {550, 50})
    but:setAnchor(0.5, 0.5)
    self.bg:addChild(but.bg)
end
function MiaoMenu:initDataOver()
    local initX = 50
    local initY = 100
    local offX = 100
    local offY = 70
    local col = 5
    local n = 0
    for k, v in ipairs(Logic.buildList) do
        local r = math.floor(n/col)
        local c = n%col

        local but = ui.newButton({image="roleNameBut0.png", conSize={100, 50}, callback=self.onHouse, delegate=self, text=v.name, size=20, param=v.id})
        setPos(but.bg, {initX+offX*c, initY+offY*r})
        but:setAnchor(0.5, 0.5)
        self.bg:addChild(but.bg)
        n = n+1
    end
    
end
function MiaoMenu:onBuild()
    self.scene.page:beginBuild('t', 0)
end
function MiaoMenu:onOk()
    self.scene.page:finishBuild()
end
function MiaoMenu:onHouse(param)
    self.scene.page:beginBuild('build', param)
end
function MiaoMenu:onPeople(param)
    self.scene.page:addPeople(param)
end
function MiaoMenu:onRemove()
    self.scene.page:onRemove()
end
function MiaoMenu:onMove()
    self.scene.page:onMove()
end