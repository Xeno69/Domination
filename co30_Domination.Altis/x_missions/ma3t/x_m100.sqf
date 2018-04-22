//#define __DEBUG__
#define THIS_FILE "x_m100.sqf"
#include "..\..\x_setup.sqf"

// markerPos "d_sm_loga": sm pickup point, marker somewhere  on the player's base, where the vehicle will spawn
// markerPos "d_sm_100": sm deliver point, marker somewhere on the map, near military base,camp,structures etc ... 
d_x_sm_pos = [markerPos "d_sm_loga", markerPos "d_sm_100"]; // Deliver truck
d_x_sm_type = "deliver"; // "convoy"


if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1664";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1665";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos # 0, d_x_sm_pos # 1, markerDir "d_sm_loga", markerDir "d_sm_100"] spawn d_fnc_sidedeliver;
};
