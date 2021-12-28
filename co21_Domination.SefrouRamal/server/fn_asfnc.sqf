// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if !((_this # 0) isKindOf "HeadlessClient_F") exitWith {};

(_this # 0 ) addScore (_this # 1);
