//#define __DEBUG__
#define THIS_FILE "x_m107.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_107" call d_fnc_smmapos; // evac a tank
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1848";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1849";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos, markerDir "d_sm_107", "land", "evac", "tank", false] spawn d_fnc_sidesteal;
};