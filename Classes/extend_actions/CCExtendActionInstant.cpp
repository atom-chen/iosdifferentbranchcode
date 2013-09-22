#include "CCExtendActionInstant.h"
#include "sprite_nodes/CCSprite.h"
#include "sprite_nodes/CCSpriteFrameCache.h"
#include "cocoa/CCZone.h"

NS_CC_EXT_BEGIN

CCFrameChange* CCFrameChange::createWithFrameName(const char* frameName) 
{
    CCFrameChange* pRet = new CCFrameChange();

    if (pRet && pRet->initWithFrameName(frameName)) {
        pRet->autorelease();
		return pRet;
    }
	CC_SAFE_RELEASE(pRet);
	return NULL;
}

CCFrameChange* CCFrameChange::create(CCSpriteFrame* frame) 
{
    CCFrameChange* pRet = new CCFrameChange();

    if (pRet && pRet->initWithFrame(frame)) {
        pRet->autorelease();
		return pRet;
    }
	CC_SAFE_RELEASE(pRet);
	return NULL;
}

bool CCFrameChange::initWithFrame(CCSpriteFrame* frame)
{
	m_pTargetFrame = frame;
	return (m_pTargetFrame!=NULL);
}

bool CCFrameChange::initWithFrameName(const char* frameName)
{
	CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(frameName);
	return initWithFrame(frame);
}

void CCFrameChange::update(float time) {
    CC_UNUSED_PARAM(time);
    CCSprite* sprite = dynamic_cast<CCSprite*>(m_pTarget);
	if(sprite!=NULL && m_pTargetFrame!=NULL){
		sprite->setDisplayFrame(m_pTargetFrame);
	}
}

CCObject* CCFrameChange::copyWithZone(CCZone *pZone) {

    CCZone *pNewZone = NULL;
    CCFrameChange *pRet = NULL;
    if (pZone && pZone->m_pCopyObject) {
        pRet = (CCFrameChange*) (pZone->m_pCopyObject);
    } else {
        pRet = new CCFrameChange();
		pRet->initWithFrame(m_pTargetFrame);
        pZone = pNewZone = new CCZone(pRet);
    }

    CCActionInstant::copyWithZone(pZone);
    CC_SAFE_DELETE(pNewZone);
    return pRet;
}

NS_CC_EXT_END