// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (remoteExecutedOwner != owner (_this # 0)) exitWith {};

(_this # 0) addScore (d_sc_hash get (_this # 1));