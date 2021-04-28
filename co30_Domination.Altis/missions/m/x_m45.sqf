// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10387.6,2191.64,0]]; // index: 45,   Destroy bank building in Elektrozavodsk,
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_798";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_799";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _objs = nearestObjects [_poss, ["Land_HouseBlock_B5"], 30];
	(_objs # 0) call d_fnc_addkillednormal;
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 350, true] spawn d_fnc_CreateArmor;
};