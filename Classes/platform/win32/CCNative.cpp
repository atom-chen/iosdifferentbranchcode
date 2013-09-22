#include "platform/CCNative.h"
#include "support/user_default/CCUserDefault.h"
#include "support/CCNotificationCenter.h"

NS_CC_EXT_BEGIN

void CCNative::openURL(const char* url)
{
	//"do not support");
}

void CCNative::postNotification(int duration, const char* content)
{
	//"do not support");
}

void CCNative::clearLocalNotification()
{
	//"do not support");
}

void CCNative::buyProductIdentifier(const char* productId)
{
	CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_BUY_SUCCESS");
}

void CCNative::initStore(CCDictionary* dict)
{
	CCArray* keys = dict->allKeys();
	CCObject* key;
	CCUserDefault* userDefault = CCUserDefault::sharedUserDefault();
	CCARRAY_FOREACH(keys, key)
	{
		const char* keyStr = ((CCString*)key)->getCString();
		userDefault->setStringForKey(keyStr, dict->valueForKey(keyStr)->getCString());
	}
}

void CCNative::showAchievements() {
}
void CCNative::reportAchievement(const char *identifer, float percent) {
}

NS_CC_EXT_END