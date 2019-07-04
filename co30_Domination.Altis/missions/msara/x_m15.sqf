// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m15.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10838.5,12636.7,0], [10886.6,12722.2,0]]; // index: 15,   Transformer station in Tlaloc
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1804";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_741";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_trafostanica_velka", _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 110, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 110, true] spawn d_fnc_CreateInf;
};
