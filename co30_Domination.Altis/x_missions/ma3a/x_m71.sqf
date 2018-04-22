// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m71.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_71" call d_fnc_smmapos; // index: 71,   Tank Attacks near Kalochori
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos, [markerDir "d_sm_71_1",markerDir "d_sm_71_2",markerDir "d_sm_71_3",markerDir "d_sm_71_4",markerDir "d_sm_71_5",markerDir "d_sm_71_6"]] spawn d_fnc_sidetanks;
};
