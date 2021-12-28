// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[8975.58,8437.76,0]]; // index: 47,   Destroy factory building in Somato
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1633";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_801";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _building = nearestObject [_poss, "Land_Hangar_2"];
	private _building2 = nearestObject [_poss, "Land_Komin"];
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 150, true] spawn d_fnc_CreateArmor;
	sleep 5.123;
	[_building, _building2, objNull] spawn d_fnc_sidefactory;
};