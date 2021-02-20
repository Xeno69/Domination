// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m46.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[6482.19,2484.12,0]]; // index: 46,   Destroy factory building in Chernogorsk
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_800";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_801";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _objs = nearestObjects [_poss, ["Land_Ind_Pec_03a", "Land_Ind_MalyKomin", "Land_Smokestack_03_F", "Land_CementWorks_01_brick_F"], 30];
	__TRACE_1("","_objs")
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	[_objs # 0, _objs # 1, _objs # 2] spawn d_fnc_sidefactory;
};
