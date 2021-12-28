// by Xeno
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11388.3,9848.09,0]]; // index: 34,   Transformer station near Paraiso
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1804";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_741";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_trafostanica_velka", _poss, [], 0, "NONE"];
	_vec setDir 273.398;
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 100, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 150, true] spawn d_fnc_CreateArmor;

};