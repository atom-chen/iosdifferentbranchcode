AdsLogic = {}
AdsLogic.hasAds = nil

--购买过广告 不再显示
local function buyAdsOver()
    AdsLogic.hasAds = 1
    EventManager.sendMessage("EVENT_NOADS")
end
function AdsLogic.buyAds()
    network.httpRequest("buyAds", buyAdsOver, {params={uid=UserData.userId}}) 
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
    if showAdsYet then
        return
    end
    showAdsYet = true
    MyPlugins:getInstance():sendCmd("showAds", "") 
end
function AdsLogic.removeAds()
    if showAdsYet then
        MyPlugins:getInstance():sendCmd("hideAds", "")
        showAdsYet = false
    end
end
