
cclog = function(...)
    print(string.format(...))
end

CCTOUCHBEGAN="began"
CCTOUCHMOVED="moved"
CCTOUCHENDED="ended"
CCTOUCHCANCELLED="cancelled"

local lastsynluatime = 0

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    if os.time()-lastsynluatime>10 then
        lastsynluatime = os.time()
        local uid = CCUserDefault:sharedUserDefault():getIntegerForKey("userId")
        local test=tostring(msg) .. "\n" .. debug.traceback()
        network.httpRequest("synLuaError", doNothing, {isPost=true, params={uid=uid, error=test}})
    end
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    --------------- test require
    require "param"
    
    --------------- must require
    require "Util.Util"
    require "General.General"

    local default = CCUserDefault:sharedUserDefault()
    General.useGameCenter = default:getBoolForKey("gamecenter")
    General.supportVideo = default:getBoolForKey("video")
    
    General.purpleUrl = default:getStringForKey("purpleUrl")
    network.baseUrl = default:getStringForKey("baseUrl")
    network.scoreUrl = default:getStringForKey("scoreUrl")
    network.chatUrl = default:getStringForKey("chatUrl")
    network.checkUrl = default:getStringForKey("checkUrl")
    if General.purpleUrl=="" then
        if network.platform=="android" then
            General.purpleUrl = "https://play.google.com/store/apps/details?id=com.caesars.zombie"
        elseif network.platform=="android_mm" then
            General.purpleUrl = "http://mm.10086.cn/android/info/230548.html#hotcom"
            network.checkUrl = "http://www.caesarsgame.com:9090/"
        elseif network.platform=="android_dx" then
            General.purpleUrl = "http://www.baidu.com/s?wd=%E5%B8%8C%E6%9C%9B%E5%8F%B7"
            network.checkUrl = "http://www.caesarsgame.com:9090/"
        elseif network.platform=="android_daqin" then
            General.purpleUrl = "http://www.baidu.com/s?wd=%E5%B8%8C%E6%9C%9B%E5%8F%B7"
            network.checkUrl = "http://www.caesarsgame.com:9090/"
        elseif network.platform=="android_astep" then
            General.purpleUrl = "http://www.baidu.com/s?wd=%E5%B8%8C%E6%9C%9B%E5%8F%B7"
        elseif network.platform=="android_aibei" then
            General.purpleUrl = "http://soft.crossmo.com/softinfo_358203.html"
        else
            General.purpleUrl = "http://tieba.baidu.com/f?ie=utf-8&amp;kw=%E8%BF%9B%E5%87%BB%E7%9A%84%E5%83%B5%E5%B0%B8online"
        end
    end
    if network.checkUrl ~= "" then
        General.inputNeedCheck = true
    end
    CRYSTAL_PREFIX = default:getStringForKey("cprefix")
    ACHIEVE_PREFIX = default:getStringForKey("aprefix")

    require "UI.UI"
    require "UI.Effect"
	
    local language = StringManager.LANGUAGE_EN
    if default:getBoolForKey("chinese") then
        language = StringManager.LANGUAGE_CN
    end
    StringManager.init(language)
    if language==StringManager.LANGUAGE_CN then
        ATTACK_BUTTON_SIZE = 27
        CHILD_MENU_OFF=16
        NEWSPAPER_TITLE_SIZE = 26
        NORMAL_SIZE_OFF=2
        BIGGER_SIZE_OFF=3
    else
        ATTACK_BUTTON_SIZE = 20
        CHILD_MENU_OFF=20
        NEWSPAPER_TITLE_SIZE = 22
        NORMAL_SIZE_OFF=0
        BIGGER_SIZE_OFF=0
        General.font1="fonts/font1.fnt"
        General.font2="fonts/font2.fnt"
        General.font3="fonts/font3.fnt"
    end
	
    --------------- program require
    require "data.StaticData"
    require "data.UserData"
    require "Scene.SceneChangeDelegate"
    require "Scene.CastleScene"
    require "Scene.PreBattleScene"
    require "Scene.LoadingScene"
    
    math.randomseed(os.time())
    display.runScene(OperationScene.new(), LoadingScene)
    EventManager.registerEventsToCpp({"EVENT_COCOS_PAUSE", "EVENT_COCOS_RESUME", "EVENT_BUY_SUCCESS", "EVENT_BUY_CANCEL", "EVENT_BUY_FAIL", "EVENT_SHARE_SUCCESS", "EVENT_SHARE_FAIL"})
end

xpcall(main, __G__TRACKBACK__)

