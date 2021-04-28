// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[14258.5,15169.1,0]]; // radar tower on Pico de Perez
d_x_sm_type = "normal"; // "convoy"

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
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 3.21;
	["specops", 1, "allmen", 1, _poss, 0, true] spawn d_fnc_CreateInf;
};
