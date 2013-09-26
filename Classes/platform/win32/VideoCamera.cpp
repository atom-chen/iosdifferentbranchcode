#include "platform/VideoCamera.h"
#include "cocos2d.h"
#include "CameraFile.h"
#include <stdlib.h>
using namespace cocos2d;

NS_CC_EXT_BEGIN

VideoCamera::~VideoCamera()
{
}

VideoCamera* VideoCamera::create()
{
    VideoCamera* pRet = new VideoCamera();
    pRet->init();
    pRet->autorelease();
    return pRet;
}

bool VideoCamera::init()
{
    m_bPaused = true;
    m_fMaxTime = 1000.0f;
    m_fFrameRate = 1.0f/25;
    camera = new CameraFile();
	//camera = NULL;
    
    scheduleUpdate();
    return true;
}

void VideoCamera::startRecord(CCNode *showScene)
{
    CCDirector *director = CCDirector::sharedDirector();
    CCRenderTexture *render = CCRenderTexture::create(director->getWinSizeInPixels().width, director->getWinSizeInPixels().height, kTexture2DPixelFormat_RGBA8888);
    render->beginWithClear(0, 0, 0, 0, 0);
    this->getParent()->visit();
    render->end();

    CCSprite *ns = CCSprite::createWithTexture(render->getSprite()->getTexture());
    ns->setFlipY(true);
    ns->setAnchorPoint(CCPointMake(0, 0));
    showScene->addChild(ns, -1);

    director->setRenderLayer(this->getParent());
    director->setShowLayer(showScene);
    
    m_bPaused = false;
    m_fTotalTime = 0.0f;
    m_fPassTime = 0.0f;

    CCSize size = cocos2d::CCDirector::sharedDirector()->getVisibleSize();
    ((CameraFile*)camera)->startWork((int)size.width, (int)size.height);
    system("python ~/audio.py");
}

void VideoCamera::endRecord()
{
    m_bPaused = true;
    ((CameraFile*)camera)->stopWork();
    system("python ~/kill.py");
    exit(0);
}

void VideoCamera::update(float dt)
{
    if(!m_bPaused){
        if(m_fTotalTime < m_fMaxTime){
            m_fTotalTime += dt;
            m_fPassTime += dt;
            if(m_fPassTime > m_fFrameRate){
                m_fPassTime -= m_fFrameRate;
                ((CameraFile*)camera)->compressFrame();
            }
        }
    }
}
NS_CC_EXT_END
