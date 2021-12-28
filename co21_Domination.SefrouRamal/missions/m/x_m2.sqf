// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[4678.83,2510.28,0], [4823.91,2453.85,0]]; //  steal plane prototype, Balota, second array position armor
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1807";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_750";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _hangar = createVehicle [d_sm_hangar, _poss, [], 0, "NONE"];
	_hangar setDir 300;
	d_x_sm_rem_ar pushBack _hangar;
	sleep 1.0123;
	private _vec = createVehicle [d_sm_plane, _poss, [], 0, "NONE"];
	_vec setDir 120;
	sleep 2.123;
	["specops", 1, "allmen", 1, _poss, 250, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 400, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	[_vec, 6] call d_fnc_setekmode;
	_vec setDamage 0;
};