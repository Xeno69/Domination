// by Xeno
#define THIS_FILE "x_m50.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[9419.92,11219.9,0]]; // index: 50,   Artillery base
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1448";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_810";
};

if (isServer) then {
	[d_x_sm_pos # 0] spawn d_fnc_sidearti;
};