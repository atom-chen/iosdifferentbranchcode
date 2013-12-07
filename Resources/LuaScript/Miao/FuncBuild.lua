FuncBuild = class()
function FuncBuild:ctor(b)
    self.baseBuild = b
end
function FuncBuild:initView()
    local bd = Logic.buildings[self.baseBuild.id]
    local sz = self.baseBuild.changeDirNode:getContentSize()
    setPos(setAnchor(self.baseBuild.changeDirNode, {bd.ax/sz.width, (sz.height-bd.ay)/sz.height}), {0, SIZEY})
end
function FuncBuild:handleTouchEnded()
end
function FuncBuild:clearEffect()
end
function FuncBuild:doEffect()
end
function FuncBuild:adjustRoad()
end
function FuncBuild:finishBuild()
end
function FuncBuild:removeSelf()
end
function FuncBuild:finishMove()
end
function FuncBuild:setBuyer(b)
end
function FuncBuild:clearBuyer(b)
end
function FuncBuild:setWorker(b)
end
function FuncBuild:clearWorker(b)
end
function FuncBuild:initWork()
end
function FuncBuild:whenColNow()
end
function FuncBuild:setColor()
end
function FuncBuild:checkFinish()
end
function FuncBuild:canFinish()
    return true
end
function FuncBuild:showInfo()
    local bi
    bi = BuildInfo.new(self)
    global.director:pushView(bi, 1, 0)
    global.director.curScene.menu:setMenu(bi)
end
function FuncBuild:initBottom()
    self.baseBuild.bottom = setSize(setAnchor(setPos(CCSprite:create("white2.png"), {0, (self.baseBuild.sx+self.baseBuild.sy)/2*SIZEY}), {0.5, 0.5}), {(self.baseBuild.sx+self.baseBuild.sy)*SIZEX+20, (self.baseBuild.sx+self.baseBuild.sy)*SIZEY+10})
    self.baseBuild.bg:addChild(self.baseBuild.bottom, 1)
end
function FuncBuild:setBottomColor(c)
    if c == 0 then
        setColor(self.baseBuild.bottom, {255, 0, 0})
    else
        setColor(self.baseBuild.bottom, {0, 255, 0})
    end
end
function FuncBuild:doSwitch()
end
function FuncBuild:checkBuildable()
    return true
end
function FuncBuild:takeTool()
end
function FuncBuild:putTool()
end
function FuncBuild:updateState()
end
function FuncBuild:updateGoods()
end
