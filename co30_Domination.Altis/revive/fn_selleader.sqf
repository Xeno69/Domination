// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

//__TRACE("selleader")
_this remoteExecCall ["selectLeader", groupOwner (_this # 0)];
