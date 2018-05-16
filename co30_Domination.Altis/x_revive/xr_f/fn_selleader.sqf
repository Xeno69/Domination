// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_selleader.sqf"
#include "..\..\x_macros.sqf"

__TRACE("selleader")
_this remoteExecCall ["selectLeader", groupOwner (_this select 0)];
