// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m24.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_24" call d_fnc_smmapos; // index: 24,   Fuel station in camp near Gospandi
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_757";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_758";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_fuel_station, _poss, [], 0, "NONE"];
	_vec setDir (markerDir "d_sm_24");
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 350, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 250, true] spawn d_fnc_CreateInf;
};