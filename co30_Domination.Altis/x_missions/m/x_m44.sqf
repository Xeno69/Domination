// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m44.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11475.5,11326.4,0], [11492.6,11370.3,0]]; // index: 44,   Steal chopper prototype near mount Klen
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1809";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_796";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _hangar = createVehicle [d_sm_hangar, _poss, [], 0, "NONE"];
	_hangar setDir 90;
	_hangar setPos _poss;
	d_x_sm_vec_rem_ar pushBack _hangar;
	sleep 1.0123;
	private _vec = createVehicle [d_sm_chopper, _poss, [], 0, "NONE"];
	_vec setDir 270;
	_vec setPos _poss;
	sleep 2.123;
	["specops", 1, "allmen", 1, _poss, 250, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 2.543;
	[_vec] spawn d_fnc_sidesteal;
	_vec addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0] call d_fnc_sidempkilled}}];
	_vec setDamage 0;
};