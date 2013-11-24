SNS = {}

function SNS.shareOver(event)
    if event==EventManager.eventType.EVENT_SHARE_SUCCESS then
        UserStat.stat(UserStatType.SHARE_SUCCESS)
        if SNS.shareReward then
            CrystalLogic.changeCrystal(SNS.shareReward, UserData.rcc-SNS.shareReward)
        end
    end
    SNS.shareReward = nil
    if SNS.shareDialog and not SNS.shareDialog.deleted then
        display.closeDialog()
        SNS.shareDialog = nil
    end
end

EventManager.registerEventMonitor({"EVENT_SHARE_SUCCESS", "EVENT_SHARE_FAIL"}, SNS.shareOver)

function SNS.share(text, image, dialog, crystal)
    if not SNS.shareDialog then
        SNS.shareDialog = dialog
        if text==nil or text=="" then
            SNS.shareText = CCUserDefault:sharedUserDefault():getStringForKey("shareText")
            if SNS.shareText=="" then
                SNS.shareText = "I am playing Nozomi by android Now, this is an exciting SLG with apocalyptic zombie theme! Download from here: http://tinyurl.com/lhb5t5c"
                if network.platform=="android_amazon" then
                    SNS.shareText = "I am playing Nozomi by android Now, this is an exciting SLG with apocalyptic zombie theme! Download from here: http://tinyurl.com/khf5kda"
                end
                CCUserDefault:sharedUserDefault():setStringForKey("shareText", SNS.shareText)
            end
            text = SNS.shareText
        end
        UserStat.stat(UserStatType.SHARE)
        MyPlugins:getInstance():share(text, image)
        SNS.shareReward = crystal
    end
end