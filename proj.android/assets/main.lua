
--[[
local oldPrint = print
function print(...)
    local printResult = ""
    for i=1,#{...} do
        printResult = printResult .. tostring(select(i, ...)) .. "\t"
    end
    oldPrint(printResult)
    local logFile = io.open(CCFileUtils:sharedFileUtils():getWritablePath() .. "error.log", "a")
	logFile:write(printResult .. "\n")
    logFile:close()
end
function print(...)
end
--]]

-- cclog
cclog = function(...)
    print(string.format(...))
end

CCTOUCHBEGAN="began"
CCTOUCHMOVED="moved"
CCTOUCHENDED="ended"
CCTOUCHCANCELLED="cancelled"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
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
	
	network.baseUrl = default:getStringForKey("baseUrl")
	network.scoreUrl = default:getStringForKey("scoreUrl")
	network.chatUrl = default:getStringForKey("chatUrl")
	CRYSTAL_PREFIX = default:getStringForKey("cprefix")

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
    
    --CCUserDefault:sharedUserDefault():setStringForKey("username", "TEST100")
    
    display.runScene(OperationScene.new(), LoadingScene)
    EventManager.registerEventsToCpp({"EVENT_COCOS_PAUSE", "EVENT_COCOS_RESUME", "EVENT_BUY_SUCCESS", "EVENT_BUY_FAIL", "EVENT_SHARE_SUCCESS", "EVENT_SHARE_FAIL"})
end

xpcall(main, __G__TRACKBACK__)
