// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m11.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[13699.1,2970.27,0], [13711.9,2914.49,0]]; // index: 11,   Lighthouse on Isle Skalisty
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_732";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_733";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	_vec = createVehicle ["Land_majak2", _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	sleep 2.022;
	["specops", 1, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 0, "tracked_apc", 1, "tank", 1, _poss, 1, 350, true] spawn d_fnc_CreateArmor;
	d_x_sm_vec_rem_ar pushBack _vec;
};