// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[4984.69,12586.8,0], [5005.95,12559.2,0]]; // index: 15,   Transformer station in Petrovka
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1804";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_741";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_land_transformer, _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 2, _poss, 300, true] spawn d_fnc_CreateInf;
};