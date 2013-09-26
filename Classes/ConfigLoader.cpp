#include "ConfigLoader.h"
#include "support/user_default/CCUserDefault.h"
#include "cocoa/CCDictionary.h"

#include "platform/CCNative.h"
#include "MyPlugins.h"

using namespace cocos2d;

ConfigLoader::ConfigLoader(){
}

ConfigLoader::~ConfigLoader(){
}

/* 一般来说配置有如下几项
* plugins，管理所有plugin-x插件
* store, 商店购买水晶有关属性，包括价格和水晶数量
* default， 一些默认设置，可能因为用户的改变而改变
* config， 其他配置，字符串形式（如果要使用bool类型，直接用true和false即可
*/
void ConfigLoader::loadConfig(const char* configFile)
{
	CCDictionary* dict = CCDictionary::createWithContentsOfFile(configFile);
	CCArray* keyList;
	CCObject* key;
	CCDictionary* childDict = (CCDictionary*)dict->objectForKey("plugins");
	if (childDict!=NULL) {
		MyPlugins::getInstance()->loadPlugins(childDict);
	}

	CCUserDefault *userDefault = CCUserDefault::sharedUserDefault();

	childDict = (CCDictionary*)dict->objectForKey("store");
	if(childDict!=NULL) {
		cocos2d::extension::CCNative::initStore(childDict);
	}

	childDict = (CCDictionary*)dict->objectForKey("default");
	if(childDict!=NULL && !userDefault->getBoolForKey("defaultInited")) {
		userDefault->setBoolForKey("defaultInited", true);
		keyList = childDict->allKeys();
		CCARRAY_FOREACH(keyList, key){
			const char* keyStr = ((CCString*) key)->getCString();
			userDefault->setBoolForKey(keyStr, childDict->valueForKey(keyStr)->boolValue());
		}
	}
	
	childDict = (CCDictionary*)dict->objectForKey("config");
	if(childDict!=NULL) {
		keyList = childDict->allKeys();
		CCARRAY_FOREACH(keyList, key)
		{
			const char* keyStr = ((CCString*)key)->getCString();
			const char* valueStr = childDict->valueForKey(keyStr)->getCString();
			if(strcmp(valueStr, "true")==0){
				userDefault->setBoolForKey(keyStr, true);
			}
			else if(strcmp(valueStr, "false")==0){
				userDefault->setBoolForKey(keyStr, false);
			}
			else
				userDefault->setStringForKey(keyStr, valueStr);
		}
	}

	userDefault->flush();
}