// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranjumppoint.sqf"
#include "..\x_setup.sqf"

private _retp = (_this # 0) getPos [(_this # 1) * sqrt random 1, random 360];
_retp set [2, [0, _this # 2] select (count _this > 2)];
_retp
