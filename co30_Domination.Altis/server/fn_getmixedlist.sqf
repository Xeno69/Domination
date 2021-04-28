// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_side"];

_with_less_armor = if (!isNil "d_enemy_mode_current_maintarget") then {
	d_enemy_mode_current_maintarget;
} else {
	d_WithLessArmor;
};

private _types = if (_with_less_armor == 0) then {
	[switch (floor random 2) do {case 0: {"wheeled_apc"};case 1: {"jeep_mg"};}, "tracked_apc", "tank", "aa"]
} else {
	if (_with_less_armor == 1) then {
		["wheeled_apc", "jeep_mg", "wheeled_apc", "jeep_mg", "wheeled_apc"]
	} else {
		["jeep_mg", "jeep_mg", "jeep_mg", "jeep_mg", "jeep_mg"]
	};
};

private _ret_list = [];
{
	_ret_list pushBack ([_x, _side] call d_fnc_getunitlistv);
} forEach _types;
_ret_list