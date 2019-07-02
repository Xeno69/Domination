// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m48.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[2270.01,5253.18,0]]; // index: 48,   Transformer station near Zelenogorsk
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1804";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_741";
};

if (isServer) then {
	d_x_sm_pos spawn d_fnc_sidetrafo;
};