#include "cocos2d.h"
#include "CCEGLView.h"
#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "Lua_extensions_CCB.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include "Lua_web_socket.h"
#endif
#include "cocos2d_ext_tolua.h"
#include "ConfigLoader.h"
#include "AssetsLoader.h"

using namespace CocosDenshion;

USING_NS_CC;

AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    CCDirector *pDirector = CCDirector::sharedDirector();
    pDirector->setOpenGLView(CCEGLView::sharedOpenGLView());

    // turn on display FPS
    //pDirector->setDisplayStats(true);
    pDirector->setProjection(kCCDirectorProjection2D);

    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / 60);

    // register lua engine
    CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();
    CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);

    CCLuaStack *pStack = pEngine->getLuaStack();
    lua_State *tolua_s = pStack->getLuaState();
    tolua_extensions_ccb_open(tolua_s);
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
    pStack = pEngine->getLuaStack();
    tolua_s = pStack->getLuaState();
    tolua_web_socket_open(tolua_s);
#endif
	pStack = pEngine->getLuaStack();
    tolua_s = pStack->getLuaState();
    tolua_extensions_caesars_open(tolua_s);

	ConfigLoader* loader = new ConfigLoader();
	loader->loadConfig("data/config.plist");
	delete loader;
    
    std::string path = CCFileUtils::sharedFileUtils()->fullPathForFilename("main.lua");
    pEngine->executeScriptFile(path.c_str());
    
    /*
	extension::AssetsLoader* layer = new extension::AssetsLoader();
	if(layer->init()){
		CCScene* scene = CCScene::create();
		scene->addChild(layer);
		CCDirector::sharedDirector()->runWithScene(scene);
	}
	else{
		CC_SAFE_RELEASE_NULL(layer);
		
	}
     */

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    CCDirector::sharedDirector()->stopAnimation();

    SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
    
	CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_COCOS_PAUSE");
	
#if(CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    CCSpriteFrameCache::sharedSpriteFrameCache()->removeSpriteFrames();
    CCTextureCache::sharedTextureCache()->removeAllTextures();
    //CCShaderCache::purgeSharedShaderCache();
#endif
}

void AppDelegate::applicationWillEnterForeground()
{
	CCNotificationCenter::sharedNotificationCenter()->postNotification("EVENT_COCOS_RESUME");
    CCDirector::sharedDirector()->startAnimation();
    if(CCUserDefault::sharedUserDefault()->getBoolForKey("musicOn", true))
        SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}
