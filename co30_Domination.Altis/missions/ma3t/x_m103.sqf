//#define __DEBUG__
#define THIS_FILE "x_m103.sqf"
#include "..\..\x_setup.sqf"

// clear naval mines
// first marker (d_sm_103) near coast of a bay, where mines will spawn
// second marker (d_sm_103_1) somewhere on a coast, where enemy units will spawn

d_x_sm_pos = "d_sm_103" call d_fnc_smmapos; 
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1666";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1667";
};

if (isServer) then {
	[d_x_sm_pos # 0, "naval"] spawn d_fnc_sidemines;
	sleep 2.123;
	private _pos_other = d_x_sm_pos # 1;
	["specops", 2, "allmen", 4, _pos_other, 150, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	private _random_point = [_pos_other, 100] call d_fnc_GetRanPointCircle;
	["stat_mg", 1, "stat_gl", 1, "", 0, _random_point, 1, 100, false] spawn d_fnc_CreateArmor;
	sleep 2.123;
	_random_point = [_pos_other, 150] call d_fnc_getranpointcircleouter;
    private _wheeled = selectRandom ["wheeled_apc", "jeep_gl", "jeep_mg"];
	[_wheeled, 1, selectRandom ["tank", "tracked_apc", "aa"], 1, _wheeled, 1, _random_point, 1, 300, true] spawn d_fnc_CreateArmor;
};