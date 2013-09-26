network = {baseUrl="http://uhz000738.chinaw3.com:9000/", scoreUrl="http://uhz000738.chinaw3.com:9002/", 
    chatUrl = "http://uhz000738.chinaw3.com:8004/"}
--network = {baseUrl="http://192.168.3.100:5000/", scoreUrl="http://192.168.3.100:5001/"}
-- 默认参数只支持字符串和数字

network.platform = CCUserDefault:sharedUserDefault():getStringForKey("platform")
if network.platform=="" then
    network.platform="ios"
end

function network.checkWordOver(isSuc, result, callback)
    if isSuc then
        print("check word result:" .. result)
        local data = json.decode(result)
        if data.res==false then
            callback()
            return
        end
    end
    display.pushNotice(UI.createNotice(StringManager.getString("noticeErrorCheckWord")))
end

function network.checkWord(word, checkCallback)
    if General.inputNeedCheck then
        network.httpRequest(network.checkUrl .. "checkKeyWord", network.checkWordOver, {params={word=word}, callbackParam=checkCallback})
    else
        checkCallback()
    end
end

network.httpRequest = function (url, callback, setting, delegate)
	local paramStr = ""
	setting = setting or {}
	if setting.single then
	    if network.single then return false end
	    network.single = true
	end
	local request = nil
	local function httpOver(isSuc)
		if not isSuc then
		    local retry = setting.retry or 0
		    if retry>2 then
    			print("HTTP Canceled")
    			EventManager.sendMessage("EVENT_NETWORK_OFF")
				if delegate then
					callback(delegate, false, nil, setting.callbackParam)
				else
					callback(false, nil, setting.callbackParam)
				end
    	    else
    	        setting.retry = retry + 1
    	        network.httpRequest(url, callback, setting, delegate)
    	    end
		else
			local hcode = request:getResponseStatusCode()
			if hcode==200 then
				local responseStr = request:getResponseString()
				if delegate then
					callback(delegate, true, responseStr, setting.callbackParam)
				else
					callback(true, responseStr, setting.callbackParam)
				end
			else
				print("HTTP Failed " .. hcode)
				if delegate then
					callback(delegate, false, nil, setting.callbackParam)
				else
					callback(false, nil, setting.callbackParam)
				end
    			EventManager.sendMessage("EVENT_NETWORK_OFF")
			end
		end
		request:release()
    	if setting.single then
    	    network.single = false
    	end
	end
	local pos = string.find(url, "http")
	local rurl = url
	if pos ~= 1 then
		rurl = network.baseUrl .. rurl
	end
	if not setting.isPost then
	    paramStr = "platform=" .. network.platform
		if setting.params then
			for key, value in pairs(setting.params) do
				paramStr = paramStr .. "&" .. key .. "=" .. network.urlencode(value)
			end
		end
		rurl = rurl .. "?" .. paramStr
		request = CCHttpRequest:createWithUrlLua(httpOver, rurl)
	else
		request = CCHttpRequest:createWithUrlLua(httpOver, rurl, false)
		request:addPostValue("platform", network.platform)
		if setting.params then
			for key, value in pairs(setting.params) do
				request:addPostValue(key, value)
			end
		end
	end
	if setting.timeout then
		request:setTimeout(setting.timeout)
	end
	local isCache = setting.isCache or false
	request:start(isCache)
	return request
end

local SAVESTR="$-_.+!*'(),abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local SAVECODE = {}
local SAVELEN = SAVESTR:len()
for i=1, SAVELEN do
    SAVECODE[SAVESTR:byte(i)] = 1
end

function network.urlencode(str)
    if type(str)=="number" then
        return tostring(str)
    elseif type(str)=="string" then
        local retstr = ""
        local slen = str:len()
        for i=1, slen do
            local b=str:byte(i)
            if b==32 then
                retstr = retstr .. "+"
            elseif SAVECODE[b] then
                retstr = retstr .. string.char(b) 
            else
                retstr = retstr .. "%" .. string.format("%02X", b)
            end
        end
        return retstr
    else
        return network.urlencode(json.encode(str))
    end
end
