// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m3.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_3" call d_fnc_smmapos; //  steal tank prototype, array 2 and 3 = infantry and armor positions
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1808";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_769";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_tank, _poss, [], 0, "NONE"];
	_vec setDir  markerDir "d_sm_3";
	_vec setPos _poss;
	sleep 2.123;
	["specops", 1, "allmen", 1, d_x_sm_pos # 1, 250, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 2, 1, 400, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	_vec addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0] call d_fnc_sidempkilled}}];
	_vec setDamage 0;
};
