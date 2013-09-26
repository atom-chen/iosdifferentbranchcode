#include "CCTextInput.h"
#include "CCDirector.h"
#include "CCEGLView.h"
#include "actions/CCActionInterval.h"
#include "touch_dispatcher/CCTouchDispatcher.h"

NS_CC_EXT_BEGIN

static int _calcCharCount(const char * pszText)
{
    int n = 0;
    char ch = 0;
    while ((ch = *pszText))
    {
        CC_BREAK_IF(! ch);
        
        if (0x80 != (0xC0 & ch))
        {
            ++n;
        }
        ++pszText;
    }
    return n;
}


CCTextInput::CCTextInput()
: m_pCursorSprite(NULL)
, m_pInputText(NULL)
, m_limitNum(30)
, priority(-128)
{
	m_ColorPlaceHolder = ccc3(127,127,127);
}

CCTextInput::~CCTextInput()
{

}

void CCTextInput::onExit()
{
    this->detachWithIME();
    CCExtendNode::onExit();
}

unsigned int CCTextInput::getLimitNum()
{
    return m_limitNum;
}
//设置字符长度
void CCTextInput::setLimitNum(unsigned int limitNum)
{
    m_limitNum = limitNum;
}

void CCTextInput::setTouchPriority(int pri)
{
	this->priority = pri;
	m_pTouchLayer->setTouchPriority(pri);
}

void CCTextInput::openIME()
{
    m_pCursorSprite->setVisible(true);
    this->attachWithIME();
}

void CCTextInput::closeIME()
{
    m_pCursorSprite->setVisible(false);
    this->detachWithIME();
}

bool CCTextInput::isInTextField(const CCPoint& endPos)
{   
    CCPoint pTouchPos = this->convertToNodeSpace(endPos);
	CCSize size = this->getContentSize(); 
	if (pTouchPos.x>0 && pTouchPos.y>-size.height && pTouchPos.x < size.width && pTouchPos.y < size.height*2)
		return true;
    return false;
}

void CCTextInput::ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent)
{
    CCPoint endPos = pTouch->getLocationInView();
    endPos = CCDirector::sharedDirector()->convertToGL(endPos);
    // 判断是打开输入法还是关闭输入法
    isInTextField(endPos) ? openIME() : closeIME();
}

bool CCTextInput::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{    
    m_beginPos = pTouch->getLocationInView();
    m_beginPos = CCDirector::sharedDirector()->convertToGL(m_beginPos);
    
	if(this->isInTextField(m_beginPos)){
	    return true;
	}
	else{
		closeIME();
		return false;
	}
}

CCRect CCTextInput::getRect()
{
    CCSize& size = m_designSize;
   
    CCRect rect = CCRectMake(0 - size.width * getAnchorPoint().x, 0 - size.height * getAnchorPoint().y, size.width, size.height);
    return  rect;
}

CCTextInput* CCTextInput::create(const char* placeHolder, const CCSize& designSize, CCTextAlignment alignment, const char *fontName, float fontSize, unsigned int limit)
{
	CCTextInput *pRet = new CCTextInput();
    
    if(pRet)
    {
		pRet->setContentSize(designSize);
		pRet->setClip(true);
		if(pRet->initWithPlaceHolder(placeHolder, designSize, alignment, fontName, fontSize, limit)){
			pRet->autorelease();
			return pRet;
		}
    }
    
    CC_SAFE_DELETE(pRet);
    
    return NULL;
}

bool CCTextInput::initWithPlaceHolder(const char* placeHolder, const CCSize& designSize, CCTextAlignment alignment, const char *fontName, float fontSize, unsigned int limit)
{
	m_pTouchLayer = CCTouchLayer::create(this->priority, true);
	m_pTouchLayer->setContentSize(designSize);
	m_pTouchLayer->setAnchorPoint(CCPointZero);
	m_pTouchLayer->setTouchHandler(this);
	addChild(m_pTouchLayer, 0, 0);

    m_uAlign = alignment;
    m_pPlaceHolder = (placeHolder) ? new std::string(placeHolder) : new std::string;
    m_pLabel = CCLabelTTF::create(placeHolder, fontName, fontSize, CCSizeZero, alignment);
    m_pLabel->setColor(m_ColorPlaceHolder);
	this->setLimitNum(limit);

	// add view
	m_pInputText = new std::string;
	addChild(m_pLabel, 1, 1);

	int cursorHeight = (int)(m_pLabel->getContentSize().height);
	int* pixels = new int[2*cursorHeight];
	memset(pixels, 0, 8*cursorHeight);
	CCTexture2D *texture = new CCTexture2D();
	texture->initWithData(pixels, kCCTexture2DPixelFormat_RGB888, 1, 1, CCSizeMake(2, cursorHeight));
	delete[] pixels;
	m_pCursorSprite = CCSprite::createWithTexture(texture);
	m_pCursorSprite->setAnchorPoint(CCPointMake(0, 0.5));
	m_cursorPos = CCPointMake(0, designSize.height / 2);
	addChild(m_pCursorSprite, 2, 2);

    m_pCursorSprite->runAction(CCRepeatForever::create((CCActionInterval *) CCSequence::create(CCFadeOut::create(0.25f), CCFadeIn::create(0.25f), NULL)));
	m_pCursorSprite->setVisible(false);

	setString("");

	return true;
}

void CCTextInput::resetView()
{
	float labelWidth = m_pLabel->getContentSize().width * m_pLabel->getScaleX();
	if(labelWidth>this->getContentSize().width){
		m_pLabel->setAnchorPoint(CCPointMake(1,0.5));
		m_pLabel->setPosition(CCPointMake(this->getContentSize().width-2, this->getContentSize().height/2));

		m_pCursorSprite->setPosition(CCPointMake(this->getContentSize().width-2, this->getContentSize().height/2));
	}
	else{
		CCPoint anchorPoint = CCPointMake(m_uAlign/2.0, 0.5);
		const CCSize& size = this->getContentSize();
		m_pLabel->setAnchorPoint(anchorPoint);
		m_pLabel->setPosition(CCPointMake(size.width * anchorPoint.x, size.height * anchorPoint.y));

		if(m_pInputText->length()==0)
			m_pCursorSprite->setPosition(CCPointMake(size.width * anchorPoint.x, size.height * anchorPoint.y));
		else
			m_pCursorSprite->setPosition(CCPointMake((size.width-labelWidth) * anchorPoint.x + labelWidth, size.height * anchorPoint.y));
	}
}

// input text property
void CCTextInput::setString(const char *text)
{
    CC_SAFE_DELETE(m_pInputText);

    if (text)
    {
        m_pInputText = new std::string(text);
    }
    else
    {
        m_pInputText = new std::string;
    }

    // if there is no input text, display placeholder instead
    if (! m_pInputText->length())
    {
        m_pLabel->setString(m_pPlaceHolder->c_str());
		m_pLabel->setColor(m_ColorPlaceHolder);
    }
    else
    {
        m_pLabel->setString(m_pInputText->c_str());
		m_pLabel->setColor(m_ColorText);
    }
	unsigned int inputCharCount = _calcCharCount(m_pInputText->c_str());
	unsigned int inputByteCount = strlen(m_pInputText->c_str());
	unsigned int inputComputeCount = inputCharCount + (inputByteCount-inputCharCount)/2;
    m_nCharCount = inputComputeCount;
	this->resetView();
}

void CCTextInput::clearString()
{
	this->setString("");
	this->closeIME();
}

const char* CCTextInput::getString(void)
{
    return m_pInputText->c_str();
}

const char* CCTextInput::getContentText()
{
    return m_pInputText->c_str();
}

void CCTextInput::setColor(const ccColor3B& color)
{
	m_ColorText = color;
	m_pCursorSprite->setColor(color);
	if(m_pInputText->length()>0)
	{
		m_pLabel->setColor(m_ColorText);
	}
}

const ccColor3B& CCTextInput::getColor()
{
	return m_ColorText;
}


//////////////////////////////////////////////////////////////////////////
// CCIMEDelegate
//////////////////////////////////////////////////////////////////////////

bool CCTextInput::attachWithIME()
{
    bool bRet = CCIMEDelegate::attachWithIME();
    if (bRet)
    {
        // open keyboard
        CCEGLView * pGlView = CCDirector::sharedDirector()->getOpenGLView();
        if (pGlView)
        {
            pGlView->setIMEKeyboardState(true);
        }
    }
    return bRet;
}

bool CCTextInput::detachWithIME()
{
    bool bRet = CCIMEDelegate::detachWithIME();
    if (bRet)
    {
        // close keyboard
        CCEGLView * pGlView = CCDirector::sharedDirector()->getOpenGLView();
        if (pGlView)
        {
            pGlView->setIMEKeyboardState(false);
        }
    }
    return bRet;
}

bool CCTextInput::canAttachWithIME()
{
    return true;
}

bool CCTextInput::canDetachWithIME()
{
    return true;
}

void CCTextInput::insertText(const char * text, int len)
{
    std::string sInsert(text, len);

    // insert \n means input end
    int nPos = sInsert.find('\n');
    if ((int)sInsert.npos != nPos)
    {
        len = nPos;
        sInsert.erase(nPos);
    }
    
    if (len > 0)
    {
		unsigned int inputByteCount = strlen(sInsert.c_str());
		unsigned int inputCharCount = _calcCharCount(sInsert.c_str());
		unsigned int inputComputeCount = inputCharCount + (inputByteCount-inputCharCount)/2;
		if(m_nCharCount + inputComputeCount>m_limitNum){
			return;
		}
        m_nCharCount = m_nCharCount + inputComputeCount;
        std::string sText(*m_pInputText);
        sText.append(sInsert);
        setString(sText.c_str());
    }

    if ((int)sInsert.npos == nPos) {
        return;
    }
    
    // if delegate hasn't processed, detach from IME by default
    closeIME();
}

void CCTextInput::deleteBackward()
{
    int nStrLen = m_pInputText->length();
    if (! nStrLen)
    {
        // there is no string
        return;
    }

    // get the delete byte number
    int nDeleteLen = 1;    // default, erase 1 byte

    while(0x80 == (0xC0 & m_pInputText->at(nStrLen - nDeleteLen)))
    {
        ++nDeleteLen;
    }

    // if all text deleted, show placeholder string
    if (nStrLen <= nDeleteLen)
    {
        setString("");
        return;
    }

    // set new input text
    std::string sText(m_pInputText->c_str(), nStrLen - nDeleteLen);
    setString(sText.c_str());
}

NS_CC_EXT_END