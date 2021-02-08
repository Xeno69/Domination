// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ascfc.sqf"
#include "..\x_setup.sqf"

if (remoteExecutedOwner != owner (_this # 0)) exitWith {};

(_this # 0) addScore (d_sc_hash get (_this # 1));