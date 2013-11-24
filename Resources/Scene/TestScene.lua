TestScene = {}

function TestScene.create()
    CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGB565)
    local bg = CCLayerColor:create(ccc4(0, 0, 255, 255), General.winSize.width, General.winSize.height)
    for i = 0, 11 do
        local land = UI.createSpriteWithFile("images/background/background" .. i .. ".pvr.ccz")
        land:setScale(2)
        screen.autoSuitable(land, {nodeAnchor=General.anchorLeftBottom, x=(i%4)*1024-1536, y=3072-1024-1024*(1+math.floor(i/4))})
        bg:addChild(land, 0)
    end
    CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
    local texture = CCTextureCache:sharedTextureCache():addImage("test.pvr.ccz")
    texture:generateMipmap()
    local params = ccTexParams:new_local()
    params.minFilter = 0x2703
    params.magFilter = 0x2601
    params.wrapS = 0x812F
    params.wrapT = 0x812F
    texture:setTexParameters(params)
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    cache:addSpriteFramesWithFile("test.plist")
    
    for i=-1, 5 do
        local sprite = UI.createAnimateWithSpritesheet(1, "test_", 14, {plist="test.plist"})
        sprite:setScale((i+3)/4)
        screen.autoSuitable(sprite, {nodeAnchor=General.anchorCenter, x=156+i*100, y=400})
        bg:addChild(sprite)
        
    end
    CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
        local sprite = UI.createSpriteWithFile("111.png", CCSizeMake(360, 360))
        screen.autoSuitable(sprite, {nodeAnchor=General.anchorCenter, x=200, y=180})
        bg:addChild(sprite)
        sprite = UI.createSpriteWithFile("225x225.png", CCSizeMake(360, 360))
        screen.autoSuitable(sprite, {nodeAnchor=General.anchorCenter, x=600, y=180})
        bg:addChild(sprite)
       
    cache:addSpriteFramesWithFile("clip.plist")
    local testView = CCNode:create()
    screen.autoSuitable(testView,{screenAnchor=General.anchorCenter})
    bg:addChild(testView)
    
    local function addClip()
        testView:removeAllChildrenWithCleanup(true)
        local tex = CCTextureCache:sharedTextureCache():addImage("clip.png") 
        local total = 50
        local p = CCParticleSystemFrameQuad:create()
        p:setTotalParticles(total)
        p:setPositionType(kCCPositionTypeGrouped)
        p:setEmitterMode(kCCParticleModeGravity)
        p:setEmissionRate(total/0.1)
        p:setDuration(0.5)
    
        p:setLife(0.7) --越小运动越快
        p:setLifeVar(0.15)
        p:setStartSize(32) --根据具体图片
        p:setStartSizeVar(0)
        p:setEndSize(32)
        p:setEndSizeVar(0)
    
        p:setAngle(0) --根据炮口位置设定
        p:setAngleVar(360) --调整吸收空间能量的幅度
    
        p:setSpeed(142)
        p:setSpeedVar(147)
        p:setGravity(CCPointMake(0,-500))
        p:setTangentialAccel(0)
        p:setTangentialAccelVar(0)
        p:setRadialAccel(-50)
        p:setRadialAccelVar(0)
        
        p:setStartSpin(0)
        p:setStartSpinVar(0)
        p:setEndSpin(0)
        p:setEndSpinVar(0)
    
        p:setStartColor(ccc4f(1,1,1,1))
        p:setStartColorVar(ccc4f(0, 0, 0, 0.0))
    
        p:setEndColor(ccc4f(1, 1, 1, 1))
        p:setEndColorVar(ccc4f(0, 0, 0, 0.0))
    
        local array = CCArray:create()
        for i=1, 2 do
            array:addObject(cache:spriteFrameByName((8+(i%2)) .. ".png"))
        end
        p:setTextureWithFrames(tex, array)
        --p:setTexture(tex)
        testView:addChild(p, 1)
        
        total = 15
        p = CCParticleSystemFrameQuad:create()
        p:setTotalParticles(total)
        p:setPositionType(kCCPositionTypeGrouped)
        p:setEmitterMode(kCCParticleModeGravity)
        p:setEmissionRate(total/0.3)
        p:setDuration(0.5)
    
        p:setLife(1) --越小运动越快
        p:setLifeVar(0)
        p:setStartSize(32) --根据具体图片
        p:setStartSizeVar(0)
        p:setEndSize(32)
        p:setEndSizeVar(0)
    
        p:setAngle(0) --根据炮口位置设定
        p:setAngleVar(360) --调整吸收空间能量的幅度
    
        p:setSpeed(100)
        p:setSpeedVar(50)
        p:setGravity(CCPointMake(0,-500))
        p:setTangentialAccel(0)
        p:setTangentialAccelVar(0)
        p:setRadialAccel(-50)
        p:setRadialAccelVar(0)
        
        p:setStartSpin(0)
        p:setStartSpinVar(0)
        p:setEndSpin(0)
        p:setEndSpinVar(0)
    
        p:setStartColor(ccc4f(1,1,1,1))
        p:setStartColorVar(ccc4f(0, 0, 0, 0.0))
    
        p:setEndColor(ccc4f(1, 1, 1, 1))
        p:setEndColorVar(ccc4f(0, 0, 0, 0.0))
        array = CCArray:create()
        for i=1, 7 do
            array:addObject(cache:spriteFrameByName(i .. ".png"))
        end
        p:setTextureWithFrames(tex, array)
        testView:addChild(p)
    end
    
    testView:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCCallFunc:create(addClip), CCDelayTime:create(2))))
        
    return {view=bg}
end