#ifndef __CAESARS_ASSETSLOADER_H__
#define __CAESARS_ASSETSLOADER_H__

#include "ExtensionMacros.h"
#include "AssetsManager/AssetsManager.h"

NS_CC_EXT_BEGIN

class AssetsLoader: public CCLayer, public AssetsManagerDelegateProtocol
{
public:
    AssetsLoader();
    ~AssetsLoader();
    virtual bool init();

    virtual void onError(AssetsManager::ErrorCode errorCode);
    virtual void onProgress(int percent);
    virtual void onSuccess();
    
private:
    AssetsManager* m_pManager;
	int m_uPackageId;

	bool checkUpdate();
	void addChildSuitable(CCNode* node, const CCPoint& anchorPoint, int offx=0, int offy=0);

	CCSprite* m_pFiller;
	CCSize fillerSize;
};

NS_CC_EXT_END

#endif //__CAESARS_ASSETSLOADER_H__