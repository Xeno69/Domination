// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m42.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_42" call d_fnc_smmapos; // index: 42,   Shot down chopper
d_x_sm_type = "evac";

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1803";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_812";
};

if (isServer) then {
	[d_x_sm_pos, time + ((15 * 60) + random 60)] spawn d_fnc_sideevac;
};
