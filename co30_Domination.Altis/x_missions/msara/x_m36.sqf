// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m36.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11919.6,15361.8,0], [11967.2,15314.4,0],[11841.5,15302.9,0],[11935,15480.1,0],[11950.3,15395.7,0],[11897.4,15424.6,0]]; // index: 36,   Capture the flag, Pesadas
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (isServer) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};