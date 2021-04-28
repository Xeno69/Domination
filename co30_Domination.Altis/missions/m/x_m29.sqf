// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[9652.59,10430.2,0], [9615.56,10447.7,0], [9614.49,10415.9,0], [9651.87,10460.5,0], [9694.1,10429.5,0], [9707.75,10415.2,0], [9686.9,10392.7,0]]; // index: 29,   Tank depot at Cabo Juventudo
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (isServer) then {
	[d_x_sm_pos, [95.394,92.9621,281.765,29,107,194.826]] spawn d_fnc_sidetanks;
};
