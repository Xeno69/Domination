// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m3.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[14750.5,13925.6,0], [14750.4,13935.4,0], [14712.9,13992.4,0]]; //  steal tank prototype, Alcazar, array 2 and 3 = infantry and armor positions
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1808";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_769";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_tank, _poss, [], 0, "NONE"];
	_vec setPos _poss;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 1, 100, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 2, 1, 200, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	_vec addMPEventHandler ["MPKilled", {if (isServer) then {[param [0]] call d_fnc_sidempkilled}}];
	_vec setDamage 0;
};
