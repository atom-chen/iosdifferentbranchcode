#include "AssetsLoader.h"
#include "CCLuaEngine.h"
#include "platform/CCNative.h"

NS_CC_EXT_BEGIN

AssetsLoader::AssetsLoader()
{
	m_pManager = NULL;
}

AssetsLoader::~AssetsLoader()
{
	CC_SAFE_DELETE(m_pManager);
}

void AssetsLoader::onError(AssetsManager::ErrorCode errorCode)
{
	if(errorCode==AssetsManager::kNetwork){
#if  (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
		if(CCUserDefault::sharedUserDefault()->getBoolForKey("chinese")){
			CCNative::showAlert("无网络连接", "无法检测到网络，请检查后重新启动游戏！", 2, "关闭", 0, "");
		}
		else{
			CCNative::showAlert("Network Error", "Cannot find your network connection. Please check and restart!", 2, "Close", 0, "");
		}
#endif
	}
}

void AssetsLoader::onProgress(int percent)
{
	m_pFiller->setTextureRect(CCRectMake(0, 0, fillerSize.width*percent/100, fillerSize.height));
}

void AssetsLoader::onSuccess()
{
	m_uPackageId++;
	char pname[20];
	sprintf(pname,"package%d", m_uPackageId);
	std::string package = CCUserDefault::sharedUserDefault()->getStringForKey(pname);
	if(package != ""){
		char pUrl[200], pvUrl[200];
		sprintf(pUrl, "%s.zip", package.c_str());
		sprintf(pvUrl, "%s.version", package.c_str());
		m_pManager->setPackageUrl(pUrl);
		m_pManager->setVersionFileUrl(pvUrl);
	}
	else{
		CC_SAFE_DELETE(m_pManager);
	}
	if(checkUpdate()){
		this->onProgress(0);
		m_pManager->update();
	}
	else{
		std::string path = CCFileUtils::sharedFileUtils()->fullPathForFilename("main.lua");
		CCLuaEngine::defaultEngine()->executeScriptFile(path.c_str());
	}
}

bool AssetsLoader::checkUpdate()
{
	while(m_pManager!=NULL){
		if(m_pManager->checkUpdate()){
			return true;
		}
		else{
			m_uPackageId++;
			char pname[20];
			sprintf(pname,"package%d", m_uPackageId);
			std::string package = CCUserDefault::sharedUserDefault()->getStringForKey(pname);
			if(package != ""){
				char pUrl[200], pvUrl[200];
				sprintf(pUrl, "%s.zip", package.c_str());
				sprintf(pvUrl, "%s.version", package.c_str());
				m_pManager->setPackageUrl(pUrl);
				m_pManager->setVersionFileUrl(pvUrl);
			}
			else{
				CC_SAFE_DELETE(m_pManager);
			}
		}
	}
	return false;
}

void AssetsLoader::addChildSuitable(CCNode* node, const CCPoint& anchorPoint, int offx/*=0*/, int offy/*=0*/)
{
	float width=1024.0f, height=768.0f;
	CCSize size = CCDirector::sharedDirector()->getVisibleSize();
	int x = size.width*anchorPoint.x, y = size.height*anchorPoint.y;
	float scale = 1;
	if(size.width/width > size.height/height){
		scale = size.width/width;
	}
	else{
		scale = size.height/height;
	}
	node->setScale(scale);
	node->setAnchorPoint(anchorPoint);
	node->setPosition(x+offx*scale, y+offy*scale);
	addChild(node);
}

bool AssetsLoader::init()
{
	bool ret = CCLayer::init();
	if(ret){
		std::string package = CCUserDefault::sharedUserDefault()->getStringForKey("package1");
		if(package != ""){
			std::string pathToSave = CCFileUtils::sharedFileUtils()->getWritablePath();
			CCLuaEngine::defaultEngine()->addSearchPath(pathToSave.c_str());
			char pUrl[200], pvUrl[200];
			sprintf(pUrl, "%s.zip", package.c_str());
			sprintf(pvUrl, "%s.version", package.c_str());
			m_uPackageId = 1;
			m_pManager = new AssetsManager(pUrl, pvUrl, pathToSave.c_str());
			m_pManager->setConnectionTimeout(3);
			m_pManager->setDelegate(this);
			if(!this->checkUpdate())
				ret = false;
			else{
				CCSprite* sp = CCSprite::create("images/loadingBack.png");
				addChildSuitable(sp, CCPointMake(0.5,0.5));

				sp = CCSprite::create("images/loadingTitle.png");
				//addChildSuitable(sp, CCPointMake(0.5,1), -22, 63);
				addChildSuitable(sp, CCPointMake(0.5,1), -12, 33);

				sp = CCSprite::create("images/tipsBg.png");
				addChildSuitable(sp, CCPointMake(0.5, 0), 0 ,8);

				sp = CCSprite::create("images/loadingProcessBack.png");
				addChildSuitable(sp, CCPointMake(0.5, 0), 0, 62);

				m_pFiller = CCSprite::create("images/loadingProcessFiller.png");
				fillerSize = CCSizeMake(279, 20);
				m_pFiller->setPosition(CCPointMake(2, 3));
				m_pFiller->setAnchorPoint(CCPointMake(0,0));
				sp->addChild(m_pFiller);
    
				CCLabelBMFont* infoLabel = CCLabelBMFont::create("Downloading", "fonts/font3.fnt");
				infoLabel->setScale(4.0f/7);
				infoLabel->setPosition(142, 25);
				infoLabel->setAnchorPoint(CCPointMake(0.5,0.5));
				sp->addChild(infoLabel);
				
				this->onProgress(0);
				m_pManager->update();
			}
		}
		else
			ret = false;
	}
	return ret;
}

NS_CC_EXT_END
