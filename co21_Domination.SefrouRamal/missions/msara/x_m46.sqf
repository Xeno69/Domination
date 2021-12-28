// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10673.1,8980.08,0]]; // index: 46,   Destroy factory building in Paraiso, attention
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1632";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_801";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _objs = nearestObjects [_poss, ["Land_Tovarna2"], 50];
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 5.123;
	[_objs # 0, _objs # 1, objNull] spawn d_fnc_sidefactory;
};