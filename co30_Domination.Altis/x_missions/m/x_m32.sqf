// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m32.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[9653.59,6562.56,0], [9650.71,6579.14,0], [9679.21,6536.92,0], [9623.96,6550.25,0], [9574.8,6549.91,0], [9557.83,6613.66,0]]; // index: 32,   Capture the flag, Shakhovka
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (isServer) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};