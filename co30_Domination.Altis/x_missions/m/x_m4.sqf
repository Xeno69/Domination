// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m4.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[13072.2,7071.04,0], [12980.7,7066.64,0], [12956.8,7196.31,0]]; // index: 4,   Water tower (chemical weapons) factory near Solnichniy
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_786";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_787a";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Misc_Cargo1B_military", _poss, [], 0, "NONE"];
	_vec setDir 255;
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 1, 200, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 2, 1, 300, true] spawn d_fnc_CreateArmor;
};