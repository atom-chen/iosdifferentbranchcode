SNS = {}

function SNS.shareOver(event)
    if SNS.shareDialog and not SNS.shareDialog.deleted then
        display.closeDialog()
        SNS.shareDialog = nil
    end
end

EventManager.registerEventMonitor({"EVENT_SHARE_SUCCESS", "EVENT_SHARE_FAIL"}, SNS.shareOver)

function SNS.share(text, image, dialog)
    if not SNS.shareDialog then
        SNS.shareDialog = dialog
        MyPlugins:getInstance():share(text, image)
    end
end