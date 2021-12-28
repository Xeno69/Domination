// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[14206.3,12523.6,0]]; // index: 45,   Destroy bank building in Bagango, attention
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1630";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1631";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _building = nearestObject [_poss, "Land_OrlHot"];
	_building call d_fnc_addKilledEHSM;
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 150, true] spawn d_fnc_CreateArmor;
};