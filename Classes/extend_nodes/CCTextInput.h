#ifndef __CAESARS_NODE_CCTEXTINPUT_H__
#define __CAESARS_NODE_CCTEXTINPUT_H__

#include "CCExtendNode.h"
#include "CCTouchLayer.h"
#include "sprite_nodes/CCSprite.h"
#include "text_input_node/CCTextFieldTTF.h"

NS_CC_EXT_BEGIN

class CCTextInput: public CCExtendNode, public CCLabelProtocol, public CCIMEDelegate, public CCTouchDelegate
{
private:
	//�����ʼλ��
	CCPoint m_beginPos;

	// ��꾫��   
    CCSprite *m_pCursorSprite;
                   
    // �������   
    CCPoint m_cursorPos;  
      
    // ���������   
    std::string *m_pInputText;

	CCSize m_designSize;

	unsigned int m_limitNum;

	int priority;

	int m_uAlign;

	CCLabelTTF* m_pLabel;

	CCTouchLayer* m_pTouchLayer;
protected:
    std::string * m_pPlaceHolder;
    ccColor3B m_ColorPlaceHolder;
    ccColor3B m_ColorText;
public:
	CCTextInput();
	~CCTextInput();

	static CCTextInput* create(const char* placeHolder, const CCSize& designSize, CCTextAlignment alignment, const char *fontName, float fontSize, unsigned int limit);

	bool initWithPlaceHolder(const char* placeHolder, const CCSize& designSize, CCTextAlignment alignment, const char *fontName, float fontSize, unsigned int limit);

	void onExit();
	
    virtual bool attachWithIME();
    virtual bool detachWithIME();
      
    // CCLayer Touch   
    bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);  
    void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);  
      
    // �ж��Ƿ�����TextField��   
    bool isInTextField(const CCPoint& endPos);
    // �õ�TextField����   
    CCRect getRect();  
      
    // �����뷨   
    void openIME();  
    // �ر����뷨   
    void closeIME(); 

	//�����ַ��������ƣ�һ�����������ַ�
    void setLimitNum(unsigned int limitNum);
    unsigned int getLimitNum();

    CC_SYNTHESIZE_READONLY(int, m_nCharCount, CharCount);

	void setTouchPriority(int pri);

	//CCLabelProtocol
    virtual void setString(const char *text);
    virtual const char* getString(void);

	void clearString();

	//COLOR SUPPORT
	virtual void setColor(const ccColor3B& color);
	virtual const ccColor3B& getColor();
protected:
	
    //////////////////////////////////////////////////////////////////////////
    // CCIMEDelegate interface
    //////////////////////////////////////////////////////////////////////////

    virtual bool canAttachWithIME();
    virtual bool canDetachWithIME();
    virtual void insertText(const char * text, int len);
    virtual void deleteBackward();
    virtual const char * getContentText();

	void resetView();
};

NS_CC_EXT_END

#endif //__CAESARS_NODE_CCTEXTINPUT_H__