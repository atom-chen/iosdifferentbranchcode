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
#include "cocoa/CCDictionary.h"
#include "cocoa/CCArray.h"

class MyShareResult : public cocos2d::plugin::ShareResultListener
{
public:
	virtual void onShareResult(cocos2d::plugin::ShareResultCode ret, const char* msg);
};

class MyPlugins
{
public:
	static MyPlugins* getInstance();
    static void destroyInstance();
    
	void unloadPlugins();
    void loadPlugins(cocos2d::CCDictionary* dict);
    void share(const char* sharedText, const char* sharedImagePath);
    
private:
    MyPlugins();
    virtual ~MyPlugins();
    
    static MyPlugins* s_pPlugins;
    
    cocos2d::plugin::ProtocolSocial* m_pSharePlugin;
    MyShareResult* m_pRetListener;
	cocos2d::CCArray* m_pPluginNames;
};

#endif //__CAESARS_MY_PLUGINS_H__
