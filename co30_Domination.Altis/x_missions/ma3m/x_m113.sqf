// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m113.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_113" call d_fnc_smmapos; // Tank depot
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (isServer) then {
	[d_x_sm_pos, [markerDir "d_sm_113_1",markerDir "d_sm_113_2",markerDir "d_sm_113_3",markerDir "d_sm_113_4",markerDir "d_sm_113_5",markerDir "d_sm_113_6"]] spawn d_fnc_sidetanks;
};
