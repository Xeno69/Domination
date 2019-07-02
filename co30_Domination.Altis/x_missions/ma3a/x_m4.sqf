// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m4.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_4" call d_fnc_smmapos; // index: 4,   Cargo truck (chemical weapons) in Nifi
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_858";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_787";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_cargo, _poss, [], 0, "NONE"];
	_vec setDir (markerDir "d_sm_4");
	_vec setPos _poss;
	_vec lock true;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 1, 200, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 2, 1, 400, true] spawn d_fnc_CreateArmor;
};
