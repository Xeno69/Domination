// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m24.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[7767.34,7500.25,0]]; // index: 24,   Fuel station in camp near Arcadia
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_757";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_758";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_fuelstation_army", _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 120, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 110, true] spawn d_fnc_CreateInf;
};
