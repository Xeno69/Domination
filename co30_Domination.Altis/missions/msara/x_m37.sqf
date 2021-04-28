// by Xeno
// #define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11300.6,16870.3,0]]; // index: 37,   Prison, Isla de Victoria
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_780";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_781";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_OrlHot", _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setDir 270;
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.132;
	["specops", 1, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.234;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 110, true] spawn d_fnc_CreateArmor;
};