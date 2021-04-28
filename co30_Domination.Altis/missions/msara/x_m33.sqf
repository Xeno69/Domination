// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[11184.8,8849.94,0],   [11138.7,8869.54,0], [11195.2,8820.68,0], [11203.6,8857.68,0],[11149.1,8791.9,0],[11158.3,8860,0]]; // index: 33,   Capture the flag, Bonanza
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_775";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_776";
};

if (isServer) then {
	[d_x_sm_pos] spawn d_fnc_sideflag;
};
