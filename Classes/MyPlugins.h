//
//  MyPlugins.h
//  nozomi
//
//  Created by  stc on 13-6-24.
//
//

#ifndef __CAESARS_MY_PLUGINS_H__
#define __CAESARS_MY_PLUGINS_H__

#include "ProtocolSocial.h"
#include "ProtocolIAP.h"
#include "ProtocolAds.h"
#include "cocoa/CCDictionary.h"
#include "cocoa/CCArray.h"

class MyShareResult : public cocos2d::plugin::ShareResultListener
{
public:
	virtual void onShareResult(cocos2d::plugin::ShareResultCode ret, const char* msg);
};

class MyPayResult : public cocos2d::plugin::PayResultListener
{
public:
	virtual void onPayResult(cocos2d::plugin::PayResultCode ret, const char* msg, cocos2d::plugin::TProductInfo info) ;
};

class MyPlugins
{
public:
	static MyPlugins* getInstance();
    static void destroyInstance();
    
	void unloadPlugins();
    void loadPlugins(cocos2d::CCDictionary* dict);
    void share(const char* sharedText, const char* sharedImagePath);
    void pay(const char* productId);
    void sendCmd(const char *cmd, const char *arg);
    
private:
    MyPlugins();
    virtual ~MyPlugins();
    
    static MyPlugins* s_pPlugins;
    
    cocos2d::plugin::ProtocolSocial* m_pSharePlugin;
	cocos2d::plugin::ProtocolIAP* m_pIAPPlugin;
    MyShareResult* m_pRetListener;
	MyPayResult* m_pIAPListener;
	cocos2d::CCArray* m_pPluginNames;

    cocos2d::plugin::ProtocolAds *m_pAds;
};

#endif //__CAESARS_MY_PLUGINS_H__
