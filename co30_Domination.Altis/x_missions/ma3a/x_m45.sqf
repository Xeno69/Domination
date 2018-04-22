// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m45.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_45" call d_fnc_smmapos; // index: 45,   Destroy fuel tanks at power plant near Sofia
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_864";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_865";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _objs = _poss nearObjects [d_sm_land_tankbig, 50];
	//private _objs = nearestObjects [_poss, [d_sm_land_tankbig], 50];
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	[_objs # 0, _objs # 1, objNull] spawn d_fnc_sidefactory;
};
