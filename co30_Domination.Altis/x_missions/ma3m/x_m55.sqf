// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m55.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_55" call d_fnc_smmapos; // index: 55,   Capture the flag
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};
