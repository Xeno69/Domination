// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m0.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[3724.62,14491.7,0]]; // radar tower on Nebelspitze
d_x_sm_type = "radiotower";

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_telek1", _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec setVectorUp [0, 0, 1];
	_vec call d_fnc_addKilledEHSM;
	sleep 3.21;
	["specops", 2, "allmen", 3, _poss, 100, true] spawn d_fnc_CreateInf;
	d_x_sm_vec_rem_ar pushBack _vec;
};