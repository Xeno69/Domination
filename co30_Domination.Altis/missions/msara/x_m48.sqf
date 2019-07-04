// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m48.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[12956.3,8638.32,0]]; // index: 48,   Transformer station Corazol
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1804";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_741";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 100, true] spawn d_fnc_CreateArmor;
	sleep 5.123;
	private _objs = _poss nearObjects ["Land_Trafostanica_mala", 80];
	if (count _objs < 3) then {_objs pushBack objNull};
	_objs spawn d_fnc_sidefactory;
};