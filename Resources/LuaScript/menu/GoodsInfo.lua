GoodsInfo = class()
function GoodsInfo:ctor()
    local vs = getVS()
    self.bg = CCNode:create()
    local temp = display.newScale9Sprite("tabback.jpg")
    temp:setContentSize(CCSizeMake(407, 280))
    setPos(temp, {vs.width/2, vs.height/2})
    addChild(self.bg, temp)
    self.temp = temp
    local sz = self.temp:getContentSize()
    local sp = setPos(addSprite(self.temp, "title.png"), {213, fixY(sz.height, 19)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="商品一览", size=18, color={0, 0, 0}})), {0.5, 0.5}), {170, fixY(sz.height, 8)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="材料", size=18, color={0, 0, 0}})), {0.5, 0.5}), {257, fixY(sz.height, 46)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="价格", size=18, color={0, 0, 0}})), {0.5, 0.5}), {350, fixY(sz.height, 45)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="材料 ", size=18, color={0, 0, 0}})), {0.5, 0.5}), {43, fixY(sz.height, 225)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="食材 1个", size=18, color={0, 0, 0}})), {0.5, 0.5}), {199, fixY(sz.height, 228)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="浊酒", size=18, color={0, 0, 0}})), {0.5, 0.5}), {60, fixY(sz.height, 80)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="白酒", size=18, color={0, 0, 0}})), {0.5, 0.5}), {58, fixY(sz.height, 118)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="素酒", size=18, color={0, 0, 0}})), {0.5, 0.5}), {58, fixY(sz.height, 160)})
    local sp = setPos(addSprite(self.temp, "herb7.png"), {264, fixY(sz.height, 83)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="6贯", size=18, color={0, 0, 0}})), {0.5, 0.5}), {350, fixY(sz.height, 75)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="13贯", size=18, color={0, 0, 0}})), {0.5, 0.5}), {345, fixY(sz.height, 118)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="37贯", size=18, color={0, 0, 0}})), {0.5, 0.5}), {344, fixY(sz.height, 159)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="1", size=18, color={0, 0, 0}})), {0.5, 0.5}), {267, fixY(sz.height, 86)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="1 ", size=18, color={0, 0, 0}})), {0.5, 0.5}), {262, fixY(sz.height, 120)})
    local sp = setPos(addSprite(self.temp, "herb7.png"), {258, fixY(sz.height, 122)})
    local sp = setPos(addSprite(self.temp, "herb7.png"), {258, fixY(sz.height, 166)})
    local w = setPos(setAnchor(addChild(self.temp, ui.newTTFLabel({text="1 ", size=18, color={0, 0, 0}})), {0.5, 0.5}), {261, fixY(sz.height, 170)})
end
