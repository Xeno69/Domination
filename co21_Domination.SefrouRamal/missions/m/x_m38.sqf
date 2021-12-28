// by Xeno
// #define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[1236.22,14668.1,0]]; // index: 38,   Biological weapons near Grozovoy Pass
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_782";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_783";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_Farm_WTower", _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setVectorUp [0,0,1];
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 300, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
};