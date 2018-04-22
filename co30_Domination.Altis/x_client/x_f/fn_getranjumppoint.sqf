// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranjumppoint.sqf"
#include "..\..\x_setup.sqf"

private _retp = (param [0]) getPos [(param [1]) * sqrt random 1, random 360];
_retp set [2, [0, param [2]] select (count _this > 2)];
_retp
