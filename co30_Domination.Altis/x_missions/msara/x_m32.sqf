// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m32.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11359.1,5325.78,0], [11346.2,5357.91,0],[11249.9,5286.24,0],[11200.1,5182.9,0],[11287.7,5280.05,0],[11347.4,5312.99,0]]; // index: 32,   Capture the flag, Parato
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (isServer) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};