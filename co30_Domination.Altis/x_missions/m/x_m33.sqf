// by Xeno
#define THIS_FILE "x_m33.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[3319.2,3935.14,0], [3347.69,3931.31,0], [3409.98,3926.71,0], [3393.92,3988.62,0], [3299.4,3962.64,0], [3300.41,3920.48,0]]; // index: 33,   Capture the flag, Bor
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};