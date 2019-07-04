// by Xeno
#define THIS_FILE "x_m56.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_56" call d_fnc_smmapos; // index: 59,   Artillery base Ifestonia
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1448";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_810";
};

if (isServer) then {
	[d_x_sm_pos # 0] spawn d_fnc_sidearti;
};
