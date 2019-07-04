// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m47.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[13116.6,10437.4,0]]; // index: 47,   Destroy factory building in Berezino
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_802";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_801";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _objs = nearestObjects [_poss, ["Land_Ind_Expedice_2","Land_Ind_Expedice_1","Land_Ind_Expedice_3"], 50];
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 150, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 300, true] spawn d_fnc_CreateArmor;
	sleep 5.123;
	[_objs # 0, _objs # 1, _objs # 2] spawn d_fnc_sidefactory;
};