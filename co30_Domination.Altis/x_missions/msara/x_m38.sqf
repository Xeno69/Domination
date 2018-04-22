// by Xeno
// #define __DEBUG__
#define THIS_FILE "x_m37.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[13978.5,15741.7,0]]; // index: 38,   Biological weapons near Passo Epone
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_782";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_783";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	// Does "Land_watertower1" still exist?
	private _vec = createVehicle ["Land_watertower1", _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.132;
	["specops", 1, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.234;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 100, true] spawn d_fnc_CreateArmor;
};