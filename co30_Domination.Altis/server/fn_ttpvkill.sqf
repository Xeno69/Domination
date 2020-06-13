// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ttpvkill.sqf"
#include "..\x_setup.sqf"

if ((_this # 0) == 1) then {
	d_points_opfor = d_points_opfor + (d_tt_points # 7);
} else {
	if ((_this # 0) == 2) then {
		d_points_blufor = d_points_blufor + (d_tt_points # 7);
	};
};
	
private _kpar = d_player_store getVariable (getPlayerUID (_this # 0));
if (isNil "_kpar") exitWith {};

if ((_this # 0) < 1 || {(_this # 0) > 2}) exitWith {};

[21, _kpar # 6, _this # 0] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated]
