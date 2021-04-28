// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[8828.15,11857.7,0], [9152.35,3899.26,0],286]; // index: 21,   Convoy Gvozdno to Pusta, start and end position
d_x_sm_type = "convoy"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1801";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_753";
};

if (isServer) then {
	d_x_sm_pos spawn d_fnc_sideconvoy;
};