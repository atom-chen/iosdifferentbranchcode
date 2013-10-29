AdsLogic = {}
local beginTime = 0
local checkTapYet = false
local req = nil
local function receiveTapjoy(suc, result, lastTime, request)
    print("tapjoy response", suc, result, lastTime, request)
    local cp = request==req
    print("same req?", cp)
    if result ~= nil and suc and req == request then
        print("receiveTapjoy", suc, result, lastTime)
        local ret = json.decode(result).messages
        for k, v in ipairs(ret) do
            if v[2] == 'tapjoy' then
                local cry = math.floor(tonumber(v[3]))
                ResourceLogic.changeResource("crystal", cry)
            end
        end
        if #ret > 0 then
            beginTime = ret[#ret][4]
        end
    end
    req = network.httpRequest(network.tapjoy.."recv", receiveTapjoy, {params={uid=UserData.userId, cid=UserData.userId, since=beginTime, callbackParam=beginTime, timeout=60}, noRetry=true})
end
function AdsLogic.showOffers()
    if checkTapYet == false then
        print("start receive tapjoy")
        checkTapYet = true
        req = network.httpRequest(network.tapjoy.."recv", receiveTapjoy, {params={uid=UserData.userId, cid=UserData.userId, since=beginTime, callbackParam=beginTime, timeout=60}, noRetry=true})
    end
    print("AdsLogic showOffers")
    MyPlugins:getInstance():sendCmd("setUid", ""..UserData.userId)
    MyPlugins:getInstance():sendCmd("showOffers", "")
end
