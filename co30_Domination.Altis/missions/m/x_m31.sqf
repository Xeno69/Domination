// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m31.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[7704.97,5188.01,0], [7716.81,5161.65,0], [7705.86,5167.78,0], [7686.79,5177.37,0], [7668.16,5186.41,0], [7639.87,5177.35,0], [7623.4,5178.56,0]]; // index: 31,   Tank depot Mogilevka
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (isServer) then {
	[d_x_sm_pos, [18, 18, 18, 18, 18, 18]] spawn d_fnc_sidetanks;
};