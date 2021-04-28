// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[17452.8,13577.6,0], [11851.9,14376.5,0]]; // index: 20,   Convoy Ixel to Tandag, start and end position
d_x_sm_type = "convoy"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1801";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_753";
};

if (isServer) then {
	[d_x_sm_pos # 0, d_x_sm_pos # 1, 0] spawn d_fnc_sideconvoy;
};
