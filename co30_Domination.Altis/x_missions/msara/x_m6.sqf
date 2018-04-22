// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m6.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[13938.3,16718.8,0], [13904.7,16694.1,0], [13836.9,16705.1,0]]; // index: 6,   Hangar at Roca del Dror
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_814";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_815";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_SS_hangar", _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setDir 41.8;
	_vec setPos _poss;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 1, 90, true] spawn d_fnc_CreateInf;
	sleep 2.012;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 2, 1, 80, true] spawn d_fnc_CreateArmor;
};