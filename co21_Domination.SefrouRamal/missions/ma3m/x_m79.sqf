// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_79" call d_fnc_smmapos; // Prison camp
d_x_sm_type = "prisoners";

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1805";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_789";
};

if (isServer) then {
	[d_x_sm_pos] spawn d_fnc_sideprisoners;
};
