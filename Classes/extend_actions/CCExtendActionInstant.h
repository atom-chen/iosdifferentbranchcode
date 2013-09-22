
#ifndef __ACTION_CCEXTEND_INSTANT_ACTION_H__
#define __ACTION_CCEXTEND_INSTANT_ACTION_H__

#include "ExtensionMacros.h"
#include "sprite_nodes/CCSpriteFrame.h"
#include "actions/CCActionInstant.h"

NS_CC_EXT_BEGIN

class CCFrameChange : public CCActionInstant
{
public:
    CCFrameChange(){}
    virtual ~CCFrameChange(){}
    //super methods
    virtual void update(float time);
    virtual CCObject* copyWithZone(CCZone *pZone);
public:
    /** Allocates and initializes the action */
    static CCFrameChange * createWithFrameName(const char* frameName);
    static CCFrameChange * create(CCSpriteFrame* frame);

	bool initWithFrame(CCSpriteFrame* frame);
	bool initWithFrameName(const char* frameName);
private:
	CCSpriteFrame* m_pTargetFrame;
};

NS_CC_EXT_END
#endif //__ACTION_CCEXTEND_INTERVAL_ACTION_H__