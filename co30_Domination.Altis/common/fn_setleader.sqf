// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setleader.sqf"
#include "..\x_setup.sqf"

params ["_unit", "_islead"];

_unit setVariable ["xr_isleader", _islead];
