// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m9.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[19225.5,13889.3,0], [19231.1,13939,0], [19236.2,13992.5,0],  [19198.6,13912.9,0]]; // index: 9,   Helicopter Prototype at Pita Airfield
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_878";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_821";
};

if (call d_fnc_checkSHC) then {
	private _poss = if ((floor random 2) == 1) then {d_x_sm_pos # 3} else {d_x_sm_pos # 0};
	private _vec = createVehicle [d_sm_chopper, _poss, [], 0, "NONE"];
	_vec setDir 40;
	_vec setPos _poss;
	_vec call d_fnc_addkillednormal;
	_vec lock true;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 1, "allmen", 1, _poss, 90, true] spawn d_fnc_CreateInf;
	sleep 2.111;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 2, 1, 100, true] spawn d_fnc_CreateArmor;
};