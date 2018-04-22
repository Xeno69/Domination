// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m10.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[6599.02,3409.95,0], [6616.04,3410.23,0]]; // index: 10,   Artillery at top of mount Vysota
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1811";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_731";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_arty, _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec call d_fnc_addkillednormal;
	_vec lock true;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.21;
	["specops", 1, "allmen", 2, _poss, 0] spawn d_fnc_CreateInf;
	sleep 2.045;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 1, 1, 0] spawn d_fnc_CreateArmor;
};