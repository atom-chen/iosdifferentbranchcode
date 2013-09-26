#ifndef __COCOS2D_EXT_TOLUA__
#define __COCOS2D_EXT_TOLUA__

#if defined(_WIN32) && defined(_DEBUG)
#pragma warning (disable:4800)
#endif

#if !defined(COCOS2D_DEBUG) || COCOS2D_DEBUG == 0
#define TOLUA_RELEASE
#endif

#include "tolua++.h"

int tolua_extensions_caesars_open(lua_State* tolua_S);

#endif //__COCOS2D_EXT_TOLUA