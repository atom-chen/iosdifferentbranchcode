//
//  MyPlugins.cpp
//  nozomi
//
//  Created by  stc on 13-6-24.
//
//

#include "MyPlugins.h"
#include "PluginManager.h"
#include "support/CCNotificationCenter.h"
#include <string>
using namespace std;
using namespace cocos2d::plugin;
using namespace cocos2d;

MyPlugins* MyPlugins::s_pPlugins = NULL;

MyPlugins::MyPlugins()
: m_pRetListener(NULL)
, m_pSharePlugin(NULL)
{
    
}

MyPlugins::~MyPlugins()
{
	unloadPlugins();
	CC_SAFE_DELETE(m_pRetListener);
}

MyPlugins* MyPlugins::getInstance()
{
	if (s_pPlugins == NULL) {
		s_pPlugins = new MyPlugins();
	}
	return s_pPlugins;
}

void MyPlugins::destroyInstance()
{
	CC_SAFE_DELETE (s_pPlugins);
	PluginManager::end();
}

void MyPlugins::loadPlugins(CCDictionary* dict)
{
	m_pPluginNames = CCArray::create();
	m_pPluginNames->retain();
	CCDictionary* pluginSetting;
	pluginSetting = (CCDictionary*) dict->objectForKey("social");
	if(pluginSetting!=NULL){
		m_pSharePlugin = dynamic_cast<ProtocolSocial*>(PluginManager::getInstance()->loadPlugin(pluginSetting->valueForKey("name")->getCString()));
		if (NULL != m_pSharePlugin)
		{
			m_pPluginNames->addObject(CCString::create(pluginSetting->valueForKey("name")->getCString()));

			TSocialDeveloperInfo pSocialInfo;
			CCDictionary* configDict = (CCDictionary*) pluginSetting->objectForKey("config");
			CCArray* configKeys = configDict->allKeys();
			CCObject* configKey;
			CCARRAY_FOREACH(configKeys, configKey)
			{
				const char* keyStr = ((CCString*)configKey)->getCString();
				pSocialInfo[keyStr] = configDict->valueForKey(keyStr)->getCString();
			}
			m_pSharePlugin->setDebugMode(false);
			m_pSharePlugin->configDeveloperInfo(pSocialInfo);
			if (m_pRetListener == NULL)
			{
				m_pRetListener = new MyShareResult();
			}
			m_pSharePlugin->setResultListener(m_pRetListener);
		}

	}
    //加载java plugins
    m_ads = dynamic_cast<ProtocolAds*>(PluginManager::getInstance()->loadPlugin("MyAds"));
    m_pPluginNames->addObject(CCString::create("MyAds"));
}

void MyPlugins::unloadPlugins()
{
	m_pSharePlugin = NULL;
    m_ads = NULL; 
	CCObject* pluginName;
	CCARRAY_FOREACH(m_pPluginNames, pluginName)
	{
		PluginManager::getInstance()->unloadPlugin(((CCString*)pluginName)->getCString());
	}
	CC_SAFE_RELEASE_NULL(m_pPluginNames);
}

void MyPlugins::share(const char* sharedText, const char* sharedImagePath)
{
    TShareInfo info;
    info["SharedText"] = sharedText;
    if(sharedImagePath!=NULL)
        info["SharedImagePath"] = sharedImagePath;
    m_pSharePlugin->share(info);
}

void MyShareResult::onShareResult(ShareResultCode ret, const char* msg)
{
    if(ret == kShareSuccess){
        CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_SHARE_SUCCESS");
    }
    else{
        CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_SHARE_FAIL");
    }
}
void MyPlugins::sendCmd(const char *cmd, const char *args) {
    CCLog("sendCmd %s %s", cmd, args);     
    if(m_ads != NULL) {
        string c(cmd); 
        if(c == "showAds") {
            m_ads->showAds((ProtocolAds::AdsType)0, 0, (ProtocolAds::AdsPos)0);
        } else if(c == "hideAds") {
            m_ads->hideAds((ProtocolAds::AdsType)0);
        } else if(c == "moregames") {
            m_ads->spendPoints(0);
        } else if(c == "hideMoreGames") {
            m_ads->spendPoints(1);
        }
    }
}
