//#define __DEBUG__
#include "..\..\x_setup.sqf"

// markerPos "d_sm_loga": sm pickup point, marker somewhere  on the player's base, where the vehicle will spawn
// markerPos "d_sm_100": sm deliver point, marker somewhere on the map, near military base,camp,structures etc ... 
d_x_sm_pos = [markerPos "d_sm_loga", markerPos "d_sm_31"]; // Deliver truck
d_x_sm_type = "deliver"; // "convoy"


if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1664";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1665";
};

if (isServer) then {
	[d_x_sm_pos # 0, d_x_sm_pos # 1, markerDir "d_sm_loga", markerDir "d_sm_31"] spawn d_fnc_sidedeliver;
};
