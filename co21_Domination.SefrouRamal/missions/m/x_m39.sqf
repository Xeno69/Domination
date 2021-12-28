// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[3717.11,5985.61,0]]; // index: 39,   Secret container in huge radio tower on mount Grüner Berg
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_784";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_785";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Box_IND_Wps_F", _poss, [], 0, "NONE"];
	_vec setDir 227;
	_vec setPosASL [3717.11,5985.61,422.656];
	d_x_sm_vec_rem_ar pushBack _vec;
	_vec call d_fnc_addKilledEHSM;
	_vec setVariable ["d_nocheck", true, true];
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 300, false] spawn d_fnc_CreateArmor;
	sleep 2.333;
	["specops", 1, "allmen", 2, _poss, 400, true] spawn d_fnc_CreateInf;
};