/*
** Lua binding: Cocos2dExt
** Generated automatically by tolua++-1.0.92 on 09/06/13 15:02:22.
*/

/****************************************************************************
 Copyright (c) 2013 caesarsgame.com

 http://www.caesarsgame.com

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

extern "C" {
#include "tolua_fix.h"
}

#include "cocos2d.h"
#include "CCLuaEngine.h"
#include "cocos2d_ext.h"
#include "NewWorld.h"

using namespace cocos2d;
using namespace cocos2d::extension;



#include "cocos2d_ext_tolua.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_CCPoint (lua_State* tolua_S)
{
 CCPoint* self = (CCPoint*) tolua_tousertype(tolua_S,1,0);
    Mtolua_delete(self);
    return 0;
}

static int tolua_collect_SearchResult (lua_State* tolua_S)
{
 SearchResult* self = (SearchResult*) tolua_tousertype(tolua_S,1,0);
    Mtolua_delete(self);
    return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"MyPlugins");
 tolua_usertype(tolua_S,"CCImageLoader");
 tolua_usertype(tolua_S,"CCExtendNode");
 tolua_usertype(tolua_S,"CCNumberTo");
 tolua_usertype(tolua_S,"SearchResult");
 tolua_usertype(tolua_S,"CCTextInput");
 tolua_usertype(tolua_S,"CCShake");
 tolua_usertype(tolua_S,"CCNative");
 tolua_usertype(tolua_S,"NewWorld");
 tolua_usertype(tolua_S,"MyVector");
 tolua_usertype(tolua_S,"CCHttpRequest");
 tolua_usertype(tolua_S,"CCTouchLayer");
 tolua_usertype(tolua_S,"CCParticleSystemFrameQuad");
 
 tolua_usertype(tolua_S,"CCAlphaTo");
 tolua_usertype(tolua_S,"CCFrameChange");
 tolua_usertype(tolua_S,"CCExtendSprite");
 tolua_usertype(tolua_S,"VideoCamera");
}

/* method: openURL of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_openURL00
static int tolua_Cocos2dExt_CCNative_openURL00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* url = ((const char*)  tolua_tostring(tolua_S,2,0));
  {
   CCNative::openURL(url);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'openURL'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: postNotification of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_postNotification00
static int tolua_Cocos2dExt_CCNative_postNotification00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int duration = ((int)  tolua_tonumber(tolua_S,2,0));
  const char* content = ((const char*)  tolua_tostring(tolua_S,3,0));
  {
   CCNative::postNotification(duration,content);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'postNotification'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: clearLocalNotification of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_clearLocalNotification00
static int tolua_Cocos2dExt_CCNative_clearLocalNotification00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   CCNative::clearLocalNotification();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'clearLocalNotification'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: buyProductIdentifier of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_buyProductIdentifier00
static int tolua_Cocos2dExt_CCNative_buyProductIdentifier00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* productId = ((const char*)  tolua_tostring(tolua_S,2,0));
  {
   CCNative::buyProductIdentifier(productId);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'buyProductIdentifier'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: showAchievements of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_showAchievements00
static int tolua_Cocos2dExt_CCNative_showAchievements00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   CCNative::showAchievements();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'showAchievements'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: reportAchievement of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_reportAchievement00
static int tolua_Cocos2dExt_CCNative_reportAchievement00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* identifer = ((const char*)  tolua_tostring(tolua_S,2,0));
  float percent = ((float)  tolua_tonumber(tolua_S,3,0));
  {
   CCNative::reportAchievement(identifer,percent);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'reportAchievement'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: showAlert of class  CCNative */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNative_showAlert00
static int tolua_Cocos2dExt_CCNative_showAlert00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNative",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isstring(tolua_S,5,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,6,0,&tolua_err) ||
     !tolua_isstring(tolua_S,7,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,8,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* title = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* content = ((const char*)  tolua_tostring(tolua_S,3,0));
  int button1 = ((int)  tolua_tonumber(tolua_S,4,0));
  const char* button1Text = ((const char*)  tolua_tostring(tolua_S,5,0));
  int button2 = ((int)  tolua_tonumber(tolua_S,6,0));
  const char* button2Text = ((const char*)  tolua_tostring(tolua_S,7,0));
  {
   CCNative::showAlert(title,content,button1,button1Text,button2,button2Text);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'showAlert'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: startRecord of class  VideoCamera */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_VideoCamera_startRecord00
static int tolua_Cocos2dExt_VideoCamera_startRecord00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"VideoCamera",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCNode",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  VideoCamera* self = (VideoCamera*)  tolua_tousertype(tolua_S,1,0);
  CCNode* tolua_var_1 = ((CCNode*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'startRecord'", NULL);
#endif
  {
   self->startRecord(tolua_var_1);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'startRecord'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: endRecord of class  VideoCamera */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_VideoCamera_endRecord00
static int tolua_Cocos2dExt_VideoCamera_endRecord00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"VideoCamera",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  VideoCamera* self = (VideoCamera*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'endRecord'", NULL);
#endif
  {
   self->endRecord();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'endRecord'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  VideoCamera */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_VideoCamera_create00
static int tolua_Cocos2dExt_VideoCamera_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"VideoCamera",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   VideoCamera* tolua_ret = (VideoCamera*)  VideoCamera::create();
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"VideoCamera");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCAlphaTo */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCAlphaTo_create00
static int tolua_Cocos2dExt_CCAlphaTo_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCAlphaTo",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  float d = ((float)  tolua_tonumber(tolua_S,2,0));
  unsigned char from = (( unsigned char)  tolua_tonumber(tolua_S,3,0));
  unsigned char to = (( unsigned char)  tolua_tonumber(tolua_S,4,0));
  {
   CCAlphaTo* tolua_ret = (CCAlphaTo*)  CCAlphaTo::create(d,from,to);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCAlphaTo");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCNumberTo */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCNumberTo_create00
static int tolua_Cocos2dExt_CCNumberTo_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCNumberTo",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isstring(tolua_S,5,0,&tolua_err) ||
     !tolua_isstring(tolua_S,6,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,7,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  float d = ((float)  tolua_tonumber(tolua_S,2,0));
  int from = ((int)  tolua_tonumber(tolua_S,3,0));
  int to = ((int)  tolua_tonumber(tolua_S,4,0));
  const char* prefix = ((const char*)  tolua_tostring(tolua_S,5,0));
  const char* suffix = ((const char*)  tolua_tostring(tolua_S,6,0));
  {
   CCNumberTo* tolua_ret = (CCNumberTo*)  CCNumberTo::create(d,from,to,prefix,suffix);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCNumberTo");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCShake */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCShake_create00
static int tolua_Cocos2dExt_CCShake_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCShake",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  float d = ((float)  tolua_tonumber(tolua_S,2,0));
  float amplitude = ((float)  tolua_tonumber(tolua_S,3,0));
  {
   CCShake* tolua_ret = (CCShake*)  CCShake::create(d,amplitude);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCShake");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: createWithFrameName of class  CCFrameChange */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCFrameChange_createWithFrameName00
static int tolua_Cocos2dExt_CCFrameChange_createWithFrameName00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCFrameChange",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* frameName = ((const char*)  tolua_tostring(tolua_S,2,0));
  {
   CCFrameChange* tolua_ret = (CCFrameChange*)  CCFrameChange::createWithFrameName(frameName);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCFrameChange");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'createWithFrameName'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCFrameChange */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCFrameChange_create00
static int tolua_Cocos2dExt_CCFrameChange_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCFrameChange",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCSpriteFrame",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCSpriteFrame* frame = ((CCSpriteFrame*)  tolua_tousertype(tolua_S,2,0));
  {
   CCFrameChange* tolua_ret = (CCFrameChange*)  CCFrameChange::create(frame);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCFrameChange");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCExtendNode */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendNode_create00
static int tolua_Cocos2dExt_CCExtendNode_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendNode",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"const CCSize",0,&tolua_err)) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const CCSize contentSize = *((const CCSize*)  tolua_tousertype(tolua_S,2,0));
  bool isClip = ((bool)  tolua_toboolean(tolua_S,3,0));
  {
   CCExtendNode* tolua_ret = (CCExtendNode*)  CCExtendNode::create(contentSize,isClip);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCExtendNode");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setHueOffset of class  CCExtendNode */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendNode_setHueOffset00
static int tolua_Cocos2dExt_CCExtendNode_setHueOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendNode",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendNode* self = (CCExtendNode*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int)  tolua_tonumber(tolua_S,2,0));
  bool recur = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setHueOffset'", NULL);
#endif
  {
   self->setHueOffset(offset,recur);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setHueOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setSatOffset of class  CCExtendNode */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendNode_setSatOffset00
static int tolua_Cocos2dExt_CCExtendNode_setSatOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendNode",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendNode* self = (CCExtendNode*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int)  tolua_tonumber(tolua_S,2,0));
  bool recur = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setSatOffset'", NULL);
#endif
  {
   self->setSatOffset(offset,recur);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setSatOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setValOffset of class  CCExtendNode */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendNode_setValOffset00
static int tolua_Cocos2dExt_CCExtendNode_setValOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendNode",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendNode* self = (CCExtendNode*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int)  tolua_tonumber(tolua_S,2,0));
  bool recur = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setValOffset'", NULL);
#endif
  {
   self->setValOffset(offset,recur);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setValOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setClip of class  CCExtendNode */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendNode_setClip00
static int tolua_Cocos2dExt_CCExtendNode_setClip00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendNode",0,&tolua_err) ||
     !tolua_isboolean(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendNode* self = (CCExtendNode*)  tolua_tousertype(tolua_S,1,0);
  bool value = ((bool)  tolua_toboolean(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setClip'", NULL);
#endif
  {
   self->setClip(value);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setClip'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCTouchLayer */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTouchLayer_create00
static int tolua_Cocos2dExt_CCTouchLayer_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCTouchLayer",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int priority = ((int)  tolua_tonumber(tolua_S,2,0));
  bool hold = ((bool)  tolua_toboolean(tolua_S,3,0));
  {
   CCTouchLayer* tolua_ret = (CCTouchLayer*)  CCTouchLayer::create(priority,hold);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCTouchLayer");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: registerScriptTouchHandler of class  CCTouchLayer */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTouchLayer_registerScriptTouchHandler00
static int tolua_Cocos2dExt_CCTouchLayer_registerScriptTouchHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTouchLayer",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !toluafix_isfunction(tolua_S,2,"LUA_FUNCTION",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTouchLayer* self = (CCTouchLayer*)  tolua_tousertype(tolua_S,1,0);
  LUA_FUNCTION nHandler = (  toluafix_ref_function(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'registerScriptTouchHandler'", NULL);
#endif
  {
   self->registerScriptTouchHandler(nHandler);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'registerScriptTouchHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: unregisterScriptTouchHandler of class  CCTouchLayer */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTouchLayer_unregisterScriptTouchHandler00
static int tolua_Cocos2dExt_CCTouchLayer_unregisterScriptTouchHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTouchLayer",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTouchLayer* self = (CCTouchLayer*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'unregisterScriptTouchHandler'", NULL);
#endif
  {
   self->unregisterScriptTouchHandler();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'unregisterScriptTouchHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setTouchPriority of class  CCTouchLayer */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTouchLayer_setTouchPriority00
static int tolua_Cocos2dExt_CCTouchLayer_setTouchPriority00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTouchLayer",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTouchLayer* self = (CCTouchLayer*)  tolua_tousertype(tolua_S,1,0);
  int priority = ((int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setTouchPriority'", NULL);
#endif
  {
   self->setTouchPriority(priority);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setTouchPriority'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getTouchPriority of class  CCTouchLayer */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTouchLayer_getTouchPriority00
static int tolua_Cocos2dExt_CCTouchLayer_getTouchPriority00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTouchLayer",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTouchLayer* self = (CCTouchLayer*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getTouchPriority'", NULL);
#endif
  {
   int tolua_ret = (int)  self->getTouchPriority();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getTouchPriority'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* function: convertToSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_convertToSprite00
static int tolua_Cocos2dExt_convertToSprite00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCNode",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCNode* node = ((CCNode*)  tolua_tousertype(tolua_S,1,0));
  {
   CCSprite* tolua_ret = (CCSprite*)  convertToSprite(node);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCSprite");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'convertToSprite'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_create00
static int tolua_Cocos2dExt_CCExtendSprite_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* pszFileName = ((const char*)  tolua_tostring(tolua_S,2,0));
  {
   CCExtendSprite* tolua_ret = (CCExtendSprite*)  CCExtendSprite::create(pszFileName);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCExtendSprite");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: createWithSpriteFrameName of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_createWithSpriteFrameName00
static int tolua_Cocos2dExt_CCExtendSprite_createWithSpriteFrameName00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* pszSpriteFrameName = ((const char*)  tolua_tostring(tolua_S,2,0));
  {
   CCExtendSprite* tolua_ret = (CCExtendSprite*)  CCExtendSprite::createWithSpriteFrameName(pszSpriteFrameName);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCExtendSprite");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'createWithSpriteFrameName'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: recurSetColor of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_recurSetColor00
static int tolua_Cocos2dExt_CCExtendSprite_recurSetColor00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCNode",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,3,&tolua_err) || !tolua_isusertype(tolua_S,3,"const ccColor3B",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCNode* baseNode = ((CCNode*)  tolua_tousertype(tolua_S,2,0));
  const ccColor3B* color = ((const ccColor3B*)  tolua_tousertype(tolua_S,3,0));
  {
   CCExtendSprite::recurSetColor(baseNode,*color);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'recurSetColor'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: recurSetGray of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_recurSetGray00
static int tolua_Cocos2dExt_CCExtendSprite_recurSetGray00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCNode",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCNode* baseNode = ((CCNode*)  tolua_tousertype(tolua_S,2,0));
  {
   CCExtendSprite::recurSetGray(baseNode);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'recurSetGray'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setHueOffset of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_setHueOffset00
static int tolua_Cocos2dExt_CCExtendSprite_setHueOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendSprite* self = (CCExtendSprite*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int)  tolua_tonumber(tolua_S,2,0));
  bool recur = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setHueOffset'", NULL);
#endif
  {
   self->setHueOffset(offset,recur);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setHueOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setSatOffset of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_setSatOffset00
static int tolua_Cocos2dExt_CCExtendSprite_setSatOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendSprite* self = (CCExtendSprite*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int)  tolua_tonumber(tolua_S,2,0));
  bool recur = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setSatOffset'", NULL);
#endif
  {
   self->setSatOffset(offset,recur);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setSatOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setValOffset of class  CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCExtendSprite_setValOffset00
static int tolua_Cocos2dExt_CCExtendSprite_setValOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendSprite* self = (CCExtendSprite*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int)  tolua_tonumber(tolua_S,2,0));
  bool recur = ((bool)  tolua_toboolean(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setValOffset'", NULL);
#endif
  {
   self->setValOffset(offset,recur);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setValOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_create00
static int tolua_Cocos2dExt_CCTextInput_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,3,&tolua_err) || !tolua_isusertype(tolua_S,3,"const CCSize",0,&tolua_err)) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isstring(tolua_S,5,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,6,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,7,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,8,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const char* placeHolder = ((const char*)  tolua_tostring(tolua_S,2,0));
  const CCSize* designSize = ((const CCSize*)  tolua_tousertype(tolua_S,3,0));
  CCTextAlignment alignment = ((CCTextAlignment) (int)  tolua_tonumber(tolua_S,4,0));
  const char* fontName = ((const char*)  tolua_tostring(tolua_S,5,0));
  float fontSize = ((float)  tolua_tonumber(tolua_S,6,0));
  unsigned int limit = ((unsigned int)  tolua_tonumber(tolua_S,7,0));
  {
   CCTextInput* tolua_ret = (CCTextInput*)  CCTextInput::create(placeHolder,*designSize,alignment,fontName,fontSize,limit);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCTextInput");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setLimitNum of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_setLimitNum00
static int tolua_Cocos2dExt_CCTextInput_setLimitNum00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
  unsigned int limitNum = ((unsigned int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setLimitNum'", NULL);
#endif
  {
   self->setLimitNum(limitNum);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setLimitNum'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setTouchPriority of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_setTouchPriority00
static int tolua_Cocos2dExt_CCTextInput_setTouchPriority00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
  int pri = ((int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setTouchPriority'", NULL);
#endif
  {
   self->setTouchPriority(pri);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setTouchPriority'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setString of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_setString00
static int tolua_Cocos2dExt_CCTextInput_setString00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
  const char* text = ((const char*)  tolua_tostring(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setString'", NULL);
#endif
  {
   self->setString(text);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setString'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getString of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_getString00
static int tolua_Cocos2dExt_CCTextInput_getString00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getString'", NULL);
#endif
  {
   const char* tolua_ret = (const char*)  self->getString();
   tolua_pushstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getString'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: clearString of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_clearString00
static int tolua_Cocos2dExt_CCTextInput_clearString00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'clearString'", NULL);
#endif
  {
   self->clearString();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'clearString'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setColor of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_setColor00
static int tolua_Cocos2dExt_CCTextInput_setColor00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"const ccColor3B",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
  const ccColor3B* color = ((const ccColor3B*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setColor'", NULL);
#endif
  {
   self->setColor(*color);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setColor'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getColor of class  CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCTextInput_getColor00
static int tolua_Cocos2dExt_CCTextInput_getColor00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCTextInput* self = (CCTextInput*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getColor'", NULL);
#endif
  {
   const ccColor3B& tolua_ret = (const ccColor3B&)  self->getColor();
    tolua_pushusertype(tolua_S,(void*)&tolua_ret,"const ccColor3B");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getColor'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCImageLoader */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCImageLoader_create00
static int tolua_Cocos2dExt_CCImageLoader_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCImageLoader",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   CCImageLoader* tolua_ret = (CCImageLoader*)  CCImageLoader::create();
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCImageLoader");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: addImage of class  CCImageLoader */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCImageLoader_addImage00
static int tolua_Cocos2dExt_CCImageLoader_addImage00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCImageLoader",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCImageLoader* self = (CCImageLoader*)  tolua_tousertype(tolua_S,1,0);
  const char* pszFileName = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* plistFileName = ((const char*)  tolua_tostring(tolua_S,3,0));
  CCTexture2DPixelFormat format = ((CCTexture2DPixelFormat) (int)  tolua_tonumber(tolua_S,4,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'addImage'", NULL);
#endif
  {
   self->addImage(pszFileName,plistFileName,format);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'addImage'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setTextureWithFrames of class  CCParticleSystemFrameQuad */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCParticleSystemFrameQuad_setTextureWithFrames00
static int tolua_Cocos2dExt_CCParticleSystemFrameQuad_setTextureWithFrames00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCParticleSystemFrameQuad",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCTexture2D",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,3,"CCArray",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCParticleSystemFrameQuad* self = (CCParticleSystemFrameQuad*)  tolua_tousertype(tolua_S,1,0);
  CCTexture2D* texture = ((CCTexture2D*)  tolua_tousertype(tolua_S,2,0));
  CCArray* frames = ((CCArray*)  tolua_tousertype(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setTextureWithFrames'", NULL);
#endif
  {
   self->setTextureWithFrames(texture,frames);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setTextureWithFrames'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  CCParticleSystemFrameQuad */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCParticleSystemFrameQuad_create00
static int tolua_Cocos2dExt_CCParticleSystemFrameQuad_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCParticleSystemFrameQuad",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   CCParticleSystemFrameQuad* tolua_ret = (CCParticleSystemFrameQuad*)  CCParticleSystemFrameQuad::create();
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCParticleSystemFrameQuad");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: createWithUrlLua of class  CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCHttpRequest_createWithUrlLua00
static int tolua_Cocos2dExt_CCHttpRequest_createWithUrlLua00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !toluafix_isfunction(tolua_S,2,"LUA_FUNCTION",0,&tolua_err)) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isboolean(tolua_S,4,1,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  LUA_FUNCTION nHandler = (  toluafix_ref_function(tolua_S,2,0));
  const char* url = ((const char*)  tolua_tostring(tolua_S,3,0));
  bool isGet = ((bool)  tolua_toboolean(tolua_S,4,true));
  {
   CCHttpRequest* tolua_ret = (CCHttpRequest*)  CCHttpRequest::createWithUrlLua(nHandler,url,isGet);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCHttpRequest");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'createWithUrlLua'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: addPostValue of class  CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCHttpRequest_addPostValue00
static int tolua_Cocos2dExt_CCHttpRequest_addPostValue00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCHttpRequest* self = (CCHttpRequest*)  tolua_tousertype(tolua_S,1,0);
  const char* key = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* value = ((const char*)  tolua_tostring(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'addPostValue'", NULL);
#endif
  {
   self->addPostValue(key,value);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'addPostValue'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setTimeout of class  CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCHttpRequest_setTimeout00
static int tolua_Cocos2dExt_CCHttpRequest_setTimeout00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCHttpRequest* self = (CCHttpRequest*)  tolua_tousertype(tolua_S,1,0);
  float timeout = ((float)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setTimeout'", NULL);
#endif
  {
   self->setTimeout(timeout);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setTimeout'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: start of class  CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCHttpRequest_start00
static int tolua_Cocos2dExt_CCHttpRequest_start00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
     !tolua_isboolean(tolua_S,2,1,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCHttpRequest* self = (CCHttpRequest*)  tolua_tousertype(tolua_S,1,0);
  bool isCached = ((bool)  tolua_toboolean(tolua_S,2,false));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'start'", NULL);
#endif
  {
   self->start(isCached);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'start'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getResponseStatusCode of class  CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCHttpRequest_getResponseStatusCode00
static int tolua_Cocos2dExt_CCHttpRequest_getResponseStatusCode00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCHttpRequest* self = (CCHttpRequest*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getResponseStatusCode'", NULL);
#endif
  {
   int tolua_ret = (int)  self->getResponseStatusCode();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getResponseStatusCode'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getResponseString of class  CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_CCHttpRequest_getResponseString00
static int tolua_Cocos2dExt_CCHttpRequest_getResponseString00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCHttpRequest* self = (CCHttpRequest*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getResponseString'", NULL);
#endif
  {
   const char* tolua_ret = (const char*)  self->getResponseString();
   tolua_pushstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getResponseString'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: objectAt of class  MyVector */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_MyVector_objectAt00
static int tolua_Cocos2dExt_MyVector_objectAt00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"MyVector",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  MyVector* self = (MyVector*)  tolua_tousertype(tolua_S,1,0);
  int i = ((int)  tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'objectAt'", NULL);
#endif
  {
   CCPoint tolua_ret = (CCPoint)  self->objectAt(i);
   {
#ifdef __cplusplus
    void* tolua_obj = Mtolua_new((CCPoint)(tolua_ret));
     tolua_pushusertype(tolua_S,tolua_obj,"CCPoint");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#else
    void* tolua_obj = tolua_copy(tolua_S,(void*)&tolua_ret,sizeof(CCPoint));
     tolua_pushusertype(tolua_S,tolua_obj,"CCPoint");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#endif
   }
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'objectAt'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getLength of class  MyVector */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_MyVector_getLength00
static int tolua_Cocos2dExt_MyVector_getLength00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"MyVector",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  MyVector* self = (MyVector*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getLength'", NULL);
#endif
  {
   int tolua_ret = (int)  self->getLength();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getLength'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* get function: path of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_get_SearchResult_path_ptr
static int tolua_get_SearchResult_path_ptr(lua_State* tolua_S)
{
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'path'",NULL);
#endif
   tolua_pushusertype(tolua_S,(void*)self->path,"MyVector");
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: path of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_set_SearchResult_path_ptr
static int tolua_set_SearchResult_path_ptr(lua_State* tolua_S)
{
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'path'",NULL);
  if (!tolua_isusertype(tolua_S,2,"MyVector",0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->path = ((MyVector*)  tolua_tousertype(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: bid of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_get_SearchResult_bid
static int tolua_get_SearchResult_bid(lua_State* tolua_S)
{
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'bid'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->bid);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: bid of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_set_SearchResult_bid
static int tolua_set_SearchResult_bid(lua_State* tolua_S)
{
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'bid'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->bid = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: realTarget of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_get_SearchResult_realTarget
static int tolua_get_SearchResult_realTarget(lua_State* tolua_S)
{
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'realTarget'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->realTarget);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: realTarget of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_set_SearchResult_realTarget
static int tolua_set_SearchResult_realTarget(lua_State* tolua_S)
{
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'realTarget'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->realTarget = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: delete of class  SearchResult */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_SearchResult_delete00
static int tolua_Cocos2dExt_SearchResult_delete00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"SearchResult",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  SearchResult* self = (SearchResult*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'delete'", NULL);
#endif
  Mtolua_delete(self);
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'delete'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_create00
static int tolua_Cocos2dExt_NewWorld_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  int n = ((int)  tolua_tonumber(tolua_S,2,0));
  {
   NewWorld* tolua_ret = (NewWorld*)  NewWorld::create(n);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"NewWorld");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setBuild of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_setBuild00
static int tolua_Cocos2dExt_NewWorld_setBuild00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,6,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,7,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
  int size = ((int)  tolua_tonumber(tolua_S,4,0));
  int btype = ((int)  tolua_tonumber(tolua_S,5,0));
  int bid = ((int)  tolua_tonumber(tolua_S,6,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setBuild'", NULL);
#endif
  {
   self->setBuild(x,y,size,btype,bid);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setBuild'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: clearBuild of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_clearBuild00
static int tolua_Cocos2dExt_NewWorld_clearBuild00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,6,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,7,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
  int size = ((int)  tolua_tonumber(tolua_S,4,0));
  int btype = ((int)  tolua_tonumber(tolua_S,5,0));
  int bid = ((int)  tolua_tonumber(tolua_S,6,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'clearBuild'", NULL);
#endif
  {
   self->clearBuild(x,y,size,btype,bid);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'clearBuild'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setGrids of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_setGrids00
static int tolua_Cocos2dExt_NewWorld_setGrids00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
  int size = ((int)  tolua_tonumber(tolua_S,4,0));
  int bid = ((int)  tolua_tonumber(tolua_S,5,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setGrids'", NULL);
#endif
  {
   self->setGrids(x,y,size,bid);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setGrids'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: clearGrids of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_clearGrids00
static int tolua_Cocos2dExt_NewWorld_clearGrids00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
  int size = ((int)  tolua_tonumber(tolua_S,4,0));
  int bid = ((int)  tolua_tonumber(tolua_S,5,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'clearGrids'", NULL);
#endif
  {
   self->clearGrids(x,y,size,bid);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'clearGrids'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setObstacle of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_setObstacle00
static int tolua_Cocos2dExt_NewWorld_setObstacle00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,5,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,6,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
  int size = ((int)  tolua_tonumber(tolua_S,4,0));
  int bid = ((int)  tolua_tonumber(tolua_S,5,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setObstacle'", NULL);
#endif
  {
   self->setObstacle(x,y,size,bid);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setObstacle'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: clearObstacle of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_clearObstacle00
static int tolua_Cocos2dExt_NewWorld_clearObstacle00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
  int size = ((int)  tolua_tonumber(tolua_S,4,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'clearObstacle'", NULL);
#endif
  {
   self->clearObstacle(x,y,size);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'clearObstacle'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: searchAttack of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_searchAttack00
static int tolua_Cocos2dExt_NewWorld_searchAttack00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'searchAttack'", NULL);
#endif
  {
   SearchResult* tolua_ret = (SearchResult*)  self->searchAttack();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"SearchResult");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'searchAttack'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: searchBusiness of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_searchBusiness00
static int tolua_Cocos2dExt_NewWorld_searchBusiness00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'searchBusiness'", NULL);
#endif
  {
   SearchResult* tolua_ret = (SearchResult*)  self->searchBusiness();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"SearchResult");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'searchBusiness'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: searchWall of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_searchWall00
static int tolua_Cocos2dExt_NewWorld_searchWall00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'searchWall'", NULL);
#endif
  {
   SearchResult* tolua_ret = (SearchResult*)  self->searchWall();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"SearchResult");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'searchWall'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: initPath of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_initPath00
static int tolua_Cocos2dExt_NewWorld_initPath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'initPath'", NULL);
#endif
  {
   self->initPath();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'initPath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: addPathCount of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_addPathCount00
static int tolua_Cocos2dExt_NewWorld_addPathCount00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'addPathCount'", NULL);
#endif
  {
   self->addPathCount(x,y);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'addPathCount'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: minusPathCount of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_minusPathCount00
static int tolua_Cocos2dExt_NewWorld_minusPathCount00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'minusPathCount'", NULL);
#endif
  {
   self->minusPathCount(x,y);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'minusPathCount'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* get function: startPoint of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_startPoint
static int tolua_get_NewWorld_startPoint(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'startPoint'",NULL);
#endif
   tolua_pushusertype(tolua_S,(void*)&self->startPoint,"CCPoint");
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: startPoint of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_startPoint
static int tolua_set_NewWorld_startPoint(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'startPoint'",NULL);
  if ((tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"CCPoint",0,&tolua_err)))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->startPoint = *((CCPoint*)  tolua_tousertype(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: endPoint of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_endPoint
static int tolua_get_NewWorld_endPoint(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'endPoint'",NULL);
#endif
   tolua_pushusertype(tolua_S,(void*)&self->endPoint,"CCPoint");
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: endPoint of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_endPoint
static int tolua_set_NewWorld_endPoint(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'endPoint'",NULL);
  if ((tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"CCPoint",0,&tolua_err)))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->endPoint = *((CCPoint*)  tolua_tousertype(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: tempBuildId of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_tempBuildId
static int tolua_get_NewWorld_tempBuildId(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'tempBuildId'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->tempBuildId);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: tempBuildId of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_tempBuildId
static int tolua_set_NewWorld_tempBuildId(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'tempBuildId'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->tempBuildId = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: attackRange of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_attackRange
static int tolua_get_NewWorld_attackRange(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'attackRange'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->attackRange);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: attackRange of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_attackRange
static int tolua_set_NewWorld_attackRange(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'attackRange'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->attackRange = ((float)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: favorite of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_favorite
static int tolua_get_NewWorld_favorite(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'favorite'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->favorite);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: favorite of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_favorite
static int tolua_set_NewWorld_favorite(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'favorite'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->favorite = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: unitType of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_unitType
static int tolua_get_NewWorld_unitType(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'unitType'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->unitType);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: unitType of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_unitType
static int tolua_set_NewWorld_unitType(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'unitType'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->unitType = ((int)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* get function: searchYet of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_searchYet
static int tolua_get_NewWorld_searchYet(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'searchYet'",NULL);
#endif
  tolua_pushboolean(tolua_S,(bool)self->searchYet);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: searchYet of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_searchYet
static int tolua_set_NewWorld_searchYet(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'searchYet'",NULL);
  if (!tolua_isboolean(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->searchYet = ((bool)  tolua_toboolean(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: clearSearchYet of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_clearSearchYet00
static int tolua_Cocos2dExt_NewWorld_clearSearchYet00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'clearSearchYet'", NULL);
#endif
  {
   self->clearSearchYet();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'clearSearchYet'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* get function: cellSize of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_get_NewWorld_cellSize
static int tolua_get_NewWorld_cellSize(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'cellSize'",NULL);
#endif
  tolua_pushnumber(tolua_S,(lua_Number)self->cellSize);
 return 1;
}
#endif //#ifndef TOLUA_DISABLE

/* set function: cellSize of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_set_NewWorld_cellSize
static int tolua_set_NewWorld_cellSize(lua_State* tolua_S)
{
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  tolua_Error tolua_err;
  if (!self) tolua_error(tolua_S,"invalid 'self' in accessing variable 'cellSize'",NULL);
  if (!tolua_isnumber(tolua_S,2,0,&tolua_err))
   tolua_error(tolua_S,"#vinvalid type in variable assignment.",&tolua_err);
#endif
  self->cellSize = ((float)  tolua_tonumber(tolua_S,2,0))
;
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: checkBlock of class  NewWorld */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_NewWorld_checkBlock00
static int tolua_Cocos2dExt_NewWorld_checkBlock00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"NewWorld",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  NewWorld* self = (NewWorld*)  tolua_tousertype(tolua_S,1,0);
  int x = ((int)  tolua_tonumber(tolua_S,2,0));
  int y = ((int)  tolua_tonumber(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'checkBlock'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->checkBlock(x,y);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'checkBlock'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getInstance of class  MyPlugins */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_MyPlugins_getInstance00
static int tolua_Cocos2dExt_MyPlugins_getInstance00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"MyPlugins",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   MyPlugins* tolua_ret = (MyPlugins*)  MyPlugins::getInstance();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"MyPlugins");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getInstance'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: sendCmd of class  MyPlugins */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_MyPlugins_sendCmd00
static int tolua_Cocos2dExt_MyPlugins_sendCmd00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"MyPlugins",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  MyPlugins* self = (MyPlugins*)  tolua_tousertype(tolua_S,1,0);
  const char* cmd = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* arg = ((const char*)  tolua_tostring(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'sendCmd'", NULL);
#endif
  {
   self->sendCmd(cmd, arg);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'sendCmd'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE



/* method: share of class  MyPlugins */
#ifndef TOLUA_DISABLE_tolua_Cocos2dExt_MyPlugins_share00
static int tolua_Cocos2dExt_MyPlugins_share00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"MyPlugins",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,4,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  MyPlugins* self = (MyPlugins*)  tolua_tousertype(tolua_S,1,0);
  const char* sharedText = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* sharedImagePath = ((const char*)  tolua_tostring(tolua_S,3,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'share'", NULL);
#endif
  {
   self->share(sharedText,sharedImagePath);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'share'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_extensions_caesars_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_constant(tolua_S,"GL_ZERO",GL_ZERO);
  tolua_constant(tolua_S,"GL_ONE",GL_ONE);
  tolua_constant(tolua_S,"GL_SRC_COLOR",GL_SRC_COLOR);
  tolua_constant(tolua_S,"GL_ONE_MINUS_SRC_COLOR",GL_ONE_MINUS_SRC_COLOR);
  tolua_constant(tolua_S,"GL_SRC_ALPHA",GL_SRC_ALPHA);
  tolua_constant(tolua_S,"GL_ONE_MINUS_SRC_ALPHA",GL_ONE_MINUS_SRC_ALPHA);
  tolua_constant(tolua_S,"GL_DST_ALPHA",GL_DST_ALPHA);
  tolua_constant(tolua_S,"GL_ONE_MINUS_DST_ALPHA",GL_ONE_MINUS_DST_ALPHA);
  tolua_constant(tolua_S,"GL_DST_COLOR",GL_DST_COLOR);
  tolua_constant(tolua_S,"GL_ONE_MINUS_DST_COLOR",GL_ONE_MINUS_DST_COLOR);
  tolua_cclass(tolua_S,"CCNative","CCNative","",NULL);
  tolua_beginmodule(tolua_S,"CCNative");
   tolua_function(tolua_S,"openURL",tolua_Cocos2dExt_CCNative_openURL00);
   tolua_function(tolua_S,"postNotification",tolua_Cocos2dExt_CCNative_postNotification00);
   tolua_function(tolua_S,"clearLocalNotification",tolua_Cocos2dExt_CCNative_clearLocalNotification00);
   tolua_function(tolua_S,"buyProductIdentifier",tolua_Cocos2dExt_CCNative_buyProductIdentifier00);
   tolua_function(tolua_S,"showAchievements",tolua_Cocos2dExt_CCNative_showAchievements00);
   tolua_function(tolua_S,"reportAchievement",tolua_Cocos2dExt_CCNative_reportAchievement00);
   tolua_function(tolua_S,"showAlert",tolua_Cocos2dExt_CCNative_showAlert00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"VideoCamera","VideoCamera","CCNode",NULL);
  tolua_beginmodule(tolua_S,"VideoCamera");
   tolua_function(tolua_S,"startRecord",tolua_Cocos2dExt_VideoCamera_startRecord00);
   tolua_function(tolua_S,"endRecord",tolua_Cocos2dExt_VideoCamera_endRecord00);
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_VideoCamera_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCAlphaTo","CCAlphaTo","CCActionInterval",NULL);
  tolua_beginmodule(tolua_S,"CCAlphaTo");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCAlphaTo_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCNumberTo","CCNumberTo","CCActionInterval",NULL);
  tolua_beginmodule(tolua_S,"CCNumberTo");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCNumberTo_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCShake","CCShake","CCActionInterval",NULL);
  tolua_beginmodule(tolua_S,"CCShake");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCShake_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCFrameChange","CCFrameChange","CCActionInstant",NULL);
  tolua_beginmodule(tolua_S,"CCFrameChange");
   tolua_function(tolua_S,"createWithFrameName",tolua_Cocos2dExt_CCFrameChange_createWithFrameName00);
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCFrameChange_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCExtendNode","CCExtendNode","CCNode",NULL);
  tolua_beginmodule(tolua_S,"CCExtendNode");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCExtendNode_create00);
   tolua_function(tolua_S,"setHueOffset",tolua_Cocos2dExt_CCExtendNode_setHueOffset00);
   tolua_function(tolua_S,"setSatOffset",tolua_Cocos2dExt_CCExtendNode_setSatOffset00);
   tolua_function(tolua_S,"setValOffset",tolua_Cocos2dExt_CCExtendNode_setValOffset00);
   tolua_function(tolua_S,"setClip",tolua_Cocos2dExt_CCExtendNode_setClip00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCTouchLayer","CCTouchLayer","CCNode",NULL);
  tolua_beginmodule(tolua_S,"CCTouchLayer");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCTouchLayer_create00);
   tolua_function(tolua_S,"registerScriptTouchHandler",tolua_Cocos2dExt_CCTouchLayer_registerScriptTouchHandler00);
   tolua_function(tolua_S,"unregisterScriptTouchHandler",tolua_Cocos2dExt_CCTouchLayer_unregisterScriptTouchHandler00);
   tolua_function(tolua_S,"setTouchPriority",tolua_Cocos2dExt_CCTouchLayer_setTouchPriority00);
   tolua_function(tolua_S,"getTouchPriority",tolua_Cocos2dExt_CCTouchLayer_getTouchPriority00);
  tolua_endmodule(tolua_S);
  tolua_function(tolua_S,"convertToSprite",tolua_Cocos2dExt_convertToSprite00);
  tolua_cclass(tolua_S,"CCExtendSprite","CCExtendSprite","CCSprite",NULL);
  tolua_beginmodule(tolua_S,"CCExtendSprite");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCExtendSprite_create00);
   tolua_function(tolua_S,"createWithSpriteFrameName",tolua_Cocos2dExt_CCExtendSprite_createWithSpriteFrameName00);
   tolua_function(tolua_S,"recurSetColor",tolua_Cocos2dExt_CCExtendSprite_recurSetColor00);
   tolua_function(tolua_S,"recurSetGray",tolua_Cocos2dExt_CCExtendSprite_recurSetGray00);
   tolua_function(tolua_S,"setHueOffset",tolua_Cocos2dExt_CCExtendSprite_setHueOffset00);
   tolua_function(tolua_S,"setSatOffset",tolua_Cocos2dExt_CCExtendSprite_setSatOffset00);
   tolua_function(tolua_S,"setValOffset",tolua_Cocos2dExt_CCExtendSprite_setValOffset00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCTextInput","CCTextInput","CCExtendNode",NULL);
  tolua_beginmodule(tolua_S,"CCTextInput");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCTextInput_create00);
   tolua_function(tolua_S,"setLimitNum",tolua_Cocos2dExt_CCTextInput_setLimitNum00);
   tolua_function(tolua_S,"setTouchPriority",tolua_Cocos2dExt_CCTextInput_setTouchPriority00);
   tolua_function(tolua_S,"setString",tolua_Cocos2dExt_CCTextInput_setString00);
   tolua_function(tolua_S,"getString",tolua_Cocos2dExt_CCTextInput_getString00);
   tolua_function(tolua_S,"clearString",tolua_Cocos2dExt_CCTextInput_clearString00);
   tolua_function(tolua_S,"setColor",tolua_Cocos2dExt_CCTextInput_setColor00);
   tolua_function(tolua_S,"getColor",tolua_Cocos2dExt_CCTextInput_getColor00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCImageLoader","CCImageLoader","CCNode",NULL);
  tolua_beginmodule(tolua_S,"CCImageLoader");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCImageLoader_create00);
   tolua_function(tolua_S,"addImage",tolua_Cocos2dExt_CCImageLoader_addImage00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCParticleSystemFrameQuad","CCParticleSystemFrameQuad","CCParticleSystemQuad",NULL);
  tolua_beginmodule(tolua_S,"CCParticleSystemFrameQuad");
   tolua_function(tolua_S,"setTextureWithFrames",tolua_Cocos2dExt_CCParticleSystemFrameQuad_setTextureWithFrames00);
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_CCParticleSystemFrameQuad_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCHttpRequest","CCHttpRequest","CCObject",NULL);
  tolua_beginmodule(tolua_S,"CCHttpRequest");
   tolua_function(tolua_S,"createWithUrlLua",tolua_Cocos2dExt_CCHttpRequest_createWithUrlLua00);
   tolua_function(tolua_S,"addPostValue",tolua_Cocos2dExt_CCHttpRequest_addPostValue00);
   tolua_function(tolua_S,"setTimeout",tolua_Cocos2dExt_CCHttpRequest_setTimeout00);
   tolua_function(tolua_S,"start",tolua_Cocos2dExt_CCHttpRequest_start00);
   tolua_function(tolua_S,"getResponseStatusCode",tolua_Cocos2dExt_CCHttpRequest_getResponseStatusCode00);
   tolua_function(tolua_S,"getResponseString",tolua_Cocos2dExt_CCHttpRequest_getResponseString00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"MyVector","MyVector","",NULL);
  tolua_beginmodule(tolua_S,"MyVector");
   tolua_function(tolua_S,"objectAt",tolua_Cocos2dExt_MyVector_objectAt00);
   tolua_function(tolua_S,"getLength",tolua_Cocos2dExt_MyVector_getLength00);
  tolua_endmodule(tolua_S);
  #ifdef __cplusplus
  tolua_cclass(tolua_S,"SearchResult","SearchResult","",tolua_collect_SearchResult);
  #else
  tolua_cclass(tolua_S,"SearchResult","SearchResult","",NULL);
  #endif
  tolua_beginmodule(tolua_S,"SearchResult");
   tolua_variable(tolua_S,"path",tolua_get_SearchResult_path_ptr,tolua_set_SearchResult_path_ptr);
   tolua_variable(tolua_S,"bid",tolua_get_SearchResult_bid,tolua_set_SearchResult_bid);
   tolua_variable(tolua_S,"realTarget",tolua_get_SearchResult_realTarget,tolua_set_SearchResult_realTarget);
   tolua_function(tolua_S,"delete",tolua_Cocos2dExt_SearchResult_delete00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"NewWorld","NewWorld","CCNode",NULL);
  tolua_beginmodule(tolua_S,"NewWorld");
   tolua_function(tolua_S,"create",tolua_Cocos2dExt_NewWorld_create00);
   tolua_function(tolua_S,"setBuild",tolua_Cocos2dExt_NewWorld_setBuild00);
   tolua_function(tolua_S,"clearBuild",tolua_Cocos2dExt_NewWorld_clearBuild00);
   tolua_function(tolua_S,"setGrids",tolua_Cocos2dExt_NewWorld_setGrids00);
   tolua_function(tolua_S,"clearGrids",tolua_Cocos2dExt_NewWorld_clearGrids00);
   tolua_function(tolua_S,"setObstacle",tolua_Cocos2dExt_NewWorld_setObstacle00);
   tolua_function(tolua_S,"clearObstacle",tolua_Cocos2dExt_NewWorld_clearObstacle00);
   tolua_function(tolua_S,"searchAttack",tolua_Cocos2dExt_NewWorld_searchAttack00);
   tolua_function(tolua_S,"searchBusiness",tolua_Cocos2dExt_NewWorld_searchBusiness00);
   tolua_function(tolua_S,"searchWall",tolua_Cocos2dExt_NewWorld_searchWall00);
   tolua_function(tolua_S,"initPath",tolua_Cocos2dExt_NewWorld_initPath00);
   tolua_function(tolua_S,"addPathCount",tolua_Cocos2dExt_NewWorld_addPathCount00);
   tolua_function(tolua_S,"minusPathCount",tolua_Cocos2dExt_NewWorld_minusPathCount00);
   tolua_variable(tolua_S,"startPoint",tolua_get_NewWorld_startPoint,tolua_set_NewWorld_startPoint);
   tolua_variable(tolua_S,"endPoint",tolua_get_NewWorld_endPoint,tolua_set_NewWorld_endPoint);
   tolua_variable(tolua_S,"tempBuildId",tolua_get_NewWorld_tempBuildId,tolua_set_NewWorld_tempBuildId);
   tolua_variable(tolua_S,"attackRange",tolua_get_NewWorld_attackRange,tolua_set_NewWorld_attackRange);
   tolua_variable(tolua_S,"favorite",tolua_get_NewWorld_favorite,tolua_set_NewWorld_favorite);
   tolua_variable(tolua_S,"unitType",tolua_get_NewWorld_unitType,tolua_set_NewWorld_unitType);
   tolua_variable(tolua_S,"searchYet",tolua_get_NewWorld_searchYet,tolua_set_NewWorld_searchYet);
   tolua_function(tolua_S,"clearSearchYet",tolua_Cocos2dExt_NewWorld_clearSearchYet00);
   tolua_variable(tolua_S,"cellSize",tolua_get_NewWorld_cellSize,tolua_set_NewWorld_cellSize);
   tolua_function(tolua_S,"checkBlock",tolua_Cocos2dExt_NewWorld_checkBlock00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"MyPlugins","MyPlugins","",NULL);
  tolua_beginmodule(tolua_S,"MyPlugins");
   tolua_function(tolua_S,"getInstance",tolua_Cocos2dExt_MyPlugins_getInstance00);
   tolua_function(tolua_S,"share",tolua_Cocos2dExt_MyPlugins_share00);
   tolua_function(tolua_S,"sendCmd",tolua_Cocos2dExt_MyPlugins_sendCmd00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}



