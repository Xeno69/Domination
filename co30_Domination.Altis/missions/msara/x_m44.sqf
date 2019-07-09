// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m44.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[9529.46,3492.03,0], [9570.09,3566.11,0]]; // index: 44,   Steal chopper prototype on San Thomas
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1809";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_750";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_chopper, _poss, [], 0, "NONE"];
	_vec setDir 90;
	_vec setPos _poss;
	sleep 2.123;
	["specops", 1, "allmen", 1, _poss, 100, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 140, true] spawn d_fnc_CreateArmor;
	sleep 2.543;
	[_vec] spawn d_fnc_sidesteal;
	[_vec, "d_sidekill"] call d_fnc_setekmode;
	_vec setDamage 0;
};