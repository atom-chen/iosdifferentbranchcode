AdsLogic = {}
AdsLogic.hasAds = nil
AdsLogic.buyObj = nil

--购买过广告 不再显示
local function buyAdsOver()
    AdsLogic.hasAds = 1
    EventManager.sendMessage("EVENT_NOADS")
end
function AdsLogic.buyAds()
    print("buyAds")
    AdsLogic.buyObj = 1
	CCNative:buyProductIdentifier("hideAds")
    --network.httpRequest("buyAds", buyAdsOver, {params={uid=UserData.userId}}) 
end
local function checkAdsOver(suc, result)
    AdsLogic.hasAds = json.decode(result)["ads"]
    print("hasAds", AdsLogic.hasAds)
    EventManager.sendMessage("EVENT_INIT_ADS")
end
function AdsLogic.checkAds()
    network.httpRequest("checkAds", checkAdsOver, {params={uid=UserData.userId}})
end
local showAdsYet = false
function AdsLogic.showAds()
    AdsLogic.showMoreGames()
    if showAdsYet then
        return
    end
    --未购买过广告则显示广告
    if AdsLogic.hasAds == 0 then
        showAdsYet = true
        --first show Moregames
        MyPlugins:getInstance():sendCmd("showAds", "") 
    end
end

function AdsLogic.hideUI()
    AdsLogic.hideMoreGames()
    AdsLogic.removeAds()
end

function AdsLogic.removeAds()
    if showAdsYet then
        MyPlugins:getInstance():sendCmd("hideAds", "")
        showAdsYet = false
    end
end

function AdsLogic.buyOver(eventType)
    print("AdsLogic receiveEvent", eventType)
    if eventType==EventManager.eventType.EVENT_BUY_SUCCESS then
        if AdsLogic.buyObj == 1 then
        	network.httpRequest("buyAds", buyAdsOver, {params={uid=UserData.userId}}) 
            AdsLogic.buyObj = nil
        end
    elseif eventType==EventManager.eventType.EVENT_BUY_FAIL then
        if AdsLogic.buyObj == 1 then
            AdsLogic.buyObj = nil
        end
    elseif eventType==EventManager.eventType.EVENT_CLOSE_ADS then
        AdsLogic.buyAds()
    end
end
function AdsLogic.showMoreGames()
    MyPlugins:getInstance():sendCmd("moregames", "")
end
function AdsLogic.hideMoreGames()
    MyPlugins:getInstance():sendCmd("hideMoreGames", "");
end


EventManager.registerEventMonitor({"EVENT_BUY_SUCCESS", "EVENT_BUY_FAIL", "EVENT_CLOSE_ADS"}, AdsLogic.buyOver)
