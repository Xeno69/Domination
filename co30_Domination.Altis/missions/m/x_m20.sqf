// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m20.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11855.2,7330.4,0], [2529.62,6358.53,0], 300]; // index: 20,   Convoy Orlovets to Sosnovka, start and end position
d_x_sm_type = "convoy"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1801";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_753";
};

if (isServer) then {
	d_x_sm_pos spawn d_fnc_sideconvoy;
};