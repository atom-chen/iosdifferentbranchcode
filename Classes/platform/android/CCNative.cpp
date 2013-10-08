#include "CCNative.h"
#include "platform/android/jni/JniHelper.h"
#include "support/CCNotificationCenter.h"
#include "support/user_default/CCUserDefault.h"
#include "CCLuaEngine.h"

void Java_com_caesars_lib_CaesarsActivity_setDeviceId(JNIEnv *env, jobject thiz, jstring url){
    const char* s=env->GetStringUTFChars(url, NULL);
    cocos2d::CCUserDefault::sharedUserDefault()->setStringForKey("username", s);
}

void Java_org_cocos2dx_plugin_MyAds_closeAds(JNIEnv *env, jobject thiz){
    CCLOG("close Ads Now");
	cocos2d::CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_CLOSE_ADS");
}

NS_CC_EXT_BEGIN
void CCNative::openURL(const char* pszUrl)
{
    JniMethodInfo minfo;

    if(JniHelper::getStaticMethodInfo(minfo, "com/caesars/lib/CaesarsActivity", "openURL", "(Ljava/lang/String;)V"))
    {
        jstring StringArg1 = minfo.env->NewStringUTF(pszUrl);
        minfo.env->CallStaticVoidMethod(minfo.classID, minfo.methodID, StringArg1);
        minfo.env->DeleteLocalRef(StringArg1);
        minfo.env->DeleteLocalRef(minfo.classID);
    }
}

void CCNative::postNotification(int duration, const char* content)
{
    JniMethodInfo minfo;

    if(JniHelper::getStaticMethodInfo(minfo, "com/caesars/lib/CaesarsActivity", "postNotification", "(ILjava/lang/String;)V"))
    {
        jstring StringArg1 = minfo.env->NewStringUTF(content);
        minfo.env->CallStaticVoidMethod(minfo.classID, minfo.methodID, duration, StringArg1);
        minfo.env->DeleteLocalRef(StringArg1);
        minfo.env->DeleteLocalRef(minfo.classID);
    }
}

void CCNative::clearLocalNotification()
{
    JniMethodInfo minfo;

    if(JniHelper::getStaticMethodInfo(minfo, "com/caesars/lib/CaesarsActivity", "clearLocalNotification", "()V"))
    {
        minfo.env->CallStaticVoidMethod(minfo.classID, minfo.methodID);
        minfo.env->DeleteLocalRef(minfo.classID);
    }
}

void CCNative::buyProductIdentifier(const char* productId)
{
	if(!CCUserDefault::sharedUserDefault()->getBoolForKey("pay"))
		CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_BUY_SUCCESS");
	else{
	}
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
void CCNative::showAlert(const char* title, const char* content, int button1, const char* button1Text, int button2, const char* button2Text) {
}

NS_CC_EXT_END
