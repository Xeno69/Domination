// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m30.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_30" call d_fnc_smmapos; // index: 30,   Tank depot near Lifou
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (isServer) then {
	[d_x_sm_pos, [markerDir "d_sm_30_1",markerDir "d_sm_30_2",markerDir "d_sm_30_3",markerDir "d_sm_30_4",markerDir "d_sm_30_5",markerDir "d_sm_30_6"]] spawn d_fnc_sidetanks;
};
