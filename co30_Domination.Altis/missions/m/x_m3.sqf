// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m3.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[9643.88,13506.9,0], [9639.43,13428.7,0], [9572.01,13385.5,0]]; //  steal tank prototype, Pobeda-Damm, array 2 and 3 = infantry and armor positions
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1808";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_769";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_tank, _poss, [], 0, "NONE"];
	_vec setDir 240;
	_vec setPos _poss;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 1, 200, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 2, 1, 400, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	[_vec, 6] call d_fnc_setekmode;
	_vec setDamage 0;
};