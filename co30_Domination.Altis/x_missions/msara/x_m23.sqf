// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m23.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10312.7,13407.5,0], [10284,13425.8,0], [10326.3,13397.6,0], [10335.9,13354.9,0], [10202.5,13416.8,0], [10309.9,13471.5,0], [10433.7,13239.7,0], [10319.8,13444.5,0]]; // index: 23,   Special forces boats in a bay near Pacamac
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1603";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1604";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos, [32, 336.274, 73.0341, 96.5422]] spawn d_fnc_sideboats;
};
