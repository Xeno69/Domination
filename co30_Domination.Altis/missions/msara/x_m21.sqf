// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m21.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[12723,8729.78,0], [6946.93,8226.66,0]]; // index: 21,   Convoy Corazol to Estrella, start and end position
d_x_sm_type = "convoy"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1801";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_753";
};

if (isServer) then {
	[d_x_sm_pos # 0, d_x_sm_pos # 1, 20.4149] spawn d_fnc_sideconvoy;
};