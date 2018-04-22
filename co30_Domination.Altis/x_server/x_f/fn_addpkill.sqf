// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addpkill.sqf"
#include "..\..\x_setup.sqf"

// 1 = radio tower

private _t_ps = d_player_store getVariable ((getPlayerUID (param [0])) + "_rvals");
if (!isNil "_t_ps") then {
	_t_ps set [param [1], (_t_ps select (param [1])) + 1];
};