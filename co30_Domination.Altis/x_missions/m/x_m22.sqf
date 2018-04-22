// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m22.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[4535.17,4439.5,0], [11274.6,5495.05,0],140]; // index: 22,   Convoy Kozlovka to Msta, start and end position
d_x_sm_type = "convoy"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1801";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_753";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos spawn d_fnc_sideconvoy;
};