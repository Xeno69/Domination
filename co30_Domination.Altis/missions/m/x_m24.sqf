// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[3616.66,3779.89,0]]; // index: 24,   Fuel station in camp near Bor
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_757";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_758";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_fuel_station, _poss, [], 0, "NONE"];
	_vec setDir 40;
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 300, true] spawn d_fnc_CreateInf;
};