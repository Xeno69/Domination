// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m20.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_20" call d_fnc_smmapos; // index: 20,   Convoy, start and end position
d_x_sm_type = "convoy"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1801";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_753";
};

if (isServer) then {
	[d_x_sm_pos # 0, d_x_sm_pos # 1, markerDir "d_sm_20"] spawn d_fnc_sideconvoy;
};
