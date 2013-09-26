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

/* һ����˵���������¼���
* plugins����������plugin-x���
* store, �̵깺��ˮ���й����ԣ������۸��ˮ������
* default�� һЩĬ�����ã�������Ϊ�û��ĸı���ı�
* config�� �������ã��ַ�����ʽ�����Ҫʹ��bool���ͣ�ֱ����true��false����
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