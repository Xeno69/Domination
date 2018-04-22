// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m36.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[12781.8,4453.06,0], [12636.5,4378.36,0],[12819.6,4437.2,0],[12845.8,4440.17,0],[12904,4434.44,0],[12854,4481.98,0]]; // index: 36,   Capture the flag, Tulga
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};