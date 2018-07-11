//#define __DEBUG__
#define THIS_FILE "x_m62.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_62" call d_fnc_smmapos; // clear naval mines
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1666";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1667";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos # 0, "naval"] spawn d_fnc_sidemines;
	sleep 2.123;
	["specops", 2, "allmen", 4, d_x_sm_pos # 1, 150, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	private _random_point = [d_x_sm_pos # 1, 100] call d_fnc_GetRanPointCircle;
	["stat_mg", 1, "stat_gl", 1, "", 0, _random_point, 1, 100, false] spawn d_fnc_CreateArmor;
	sleep 2.123;
	_random_point = [d_x_sm_pos # 1, 150] call d_fnc_getranpointcircleouter;
    private _wheeled = selectRandom ["wheeled_apc", "jeep_gl", "jeep_mg"];
	[_wheeled, 1, selectRandom ["tank", "tracked_apc", "aa"], 1, _wheeled, 1, _random_point, 1, 300, true] spawn d_fnc_CreateArmor;
};