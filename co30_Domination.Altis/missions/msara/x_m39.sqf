// by Xeno
// #define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[16197.8,10336.2,0]]; // index: 39,   Radio tower on top of Monte Valor
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	// Does "Land_telek1" still exist?
	private _vec = createVehicle ["Land_telek1", _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.132;
	["specops", 1, "allmen", 2, _poss, 120, true] spawn d_fnc_CreateInf;
	sleep 2.234;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 110, true] spawn d_fnc_CreateArmor;
};