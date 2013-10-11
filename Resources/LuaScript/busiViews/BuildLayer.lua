require "model.MapGridController"
require "views.Building"
BuildLayer = class(MoveMap)
function BuildLayer:ctor(scene)
    self.scene = scene
    self.moveZone = TrainZone
    self.buildZone = FullZone
    --显示所有的obstacle块的位置
    self.staticObstacle = obstacleBlock
    self.bg = CCLayer:create()
    self.mapGridController = MapGridController.new(self)
    self.gridLayer = CCLayer:create()
    self.bg:addChild(self.gridLayer)
end

function BuildLayer:initBuilding()
    local item = global.user.buildings
    for k, v in pairs(item) do
        local bid = k
        local bdata = v
        local data = getData(GOODS_KIND.BUILD, bdata["kind"]) 
        local build = Building.new(self, data, bdata)
        build:setBid(bid)

        self.bg:addChild(build.bg, MAX_BUILD_ZORD)
        build:setPos(normalizePos({bdata["px"], bdata["py"]}, data["sx"], data["sy"]))
        self.mapGridController:addBuilding(build)
    end
    --[[
    local temp = CCSprite:create("images/loadingCircle.png")
    temp:setPosition(ccp(992, 320))
    self.bg:addChild(temp)
    temp:setScale(0.2)
    --]]
end
function BuildLayer:initDataOver()
    self:initBuilding()
end

function BuildLayer:keepPos()
    self.Planing = 1
    self:buildKeepPos()
    self:soldierKeepPos()
end
function BuildLayer:restorePos()
    self:restoreBuildPos()
    self:restoreSoldierPos()
    self:clearPlanState()
end
function BuildLayer:restoreBuildPos()
    for k, v in pairs(self.mapGridController.allBuildings) do
        k:restorePos()
    end
end
function BuildLayer:restoreSoldierPos()
end
function BuildLayer:clearPlanState()
    self.Planing = 0
end

function BuildLayer:buildKeepPos()
    for k, v in pairs(self.mapGridController.allBuildings) do
        k:keepPos()
    end
end
function BuildLayer:soldierKeepPos()
end
function BuildLayer:finishPlan()
    local changedBuilding = {}
    for k, v in pairs(self.mapGridController.allBuildings) do
        if k.dirty == 1 then
            global.user:updateBuilding(k)
            local p = getPos(k.bg)
            table.insert(changedBuilding, {k.bid, p[1], p[2], k.dir})
        end
        k:finishPlan()
    end
    if #changedBuilding > 0 then
        global.httpController:addRequest("finishPlan", dict({{"uid", global.user.uid}, {"builds", simple.encode(changedBuilding)}}), nil, nil)
    end
    self:clearPlanState()
end
