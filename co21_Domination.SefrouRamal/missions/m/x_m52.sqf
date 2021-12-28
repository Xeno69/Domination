// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[8541.77,14202.3,0]]; // index: 52,   Shot down chopper
d_x_sm_type = "evac";

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1803";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_812";
};

if (isServer) then {
	[d_x_sm_pos, time + ((15 * 60) + random 60)] spawn d_fnc_sideevac;
};