// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m26.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[7743.49,14452.7,0],[7959.68,14514.2], [7774.97,14422.1,0],[7667,14409.6,0]]; // index: 26,   Hangar on Trelobada
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_814";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_815";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_SS_hangar", _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setDir 354;
	_vec setPos _poss;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 1, _poss, 60] spawn d_fnc_CreateInf;
	sleep 2.012;
	["aa", 1, "tracked_apc", 0, "tank", 0, d_x_sm_pos # 1, 1, 0] spawn d_fnc_CreateArmor;
	sleep 2.012;
	["aa", 0, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 1, 1, 0] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 3, 60] spawn d_fnc_CreateInf;
};
