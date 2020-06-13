// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m0.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_0" call d_fnc_smmapos; // radar tower
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	[_poss, d_illum_tower] spawn d_fnc_sideobject;
	sleep 3.21;
	["specops", 2, "allmen", 3, _poss, 200, true] spawn d_fnc_CreateInf;
};
