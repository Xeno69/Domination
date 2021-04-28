// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_killer", "_side"];

if (_side == 1) then {
	d_points_opfor = d_points_opfor + (d_tt_points # 7);
} else {
	if (_side == 2) then {
		d_points_blufor = d_points_blufor + (d_tt_points # 7);
	};
};

if (isNull _killer) exitWith {};

[21, name _killer, _side] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated]
