//#define __DEBUG__
#define THIS_FILE "x_m116.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_116" call d_fnc_smmapos; // Destroy trucks
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_49";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_50";
};

if (call d_fnc_checkSHC) then {
	[d_x_sm_pos # 0, markerDir "d_sm_114", [d_sm_ammotrucktype, d_sm_fueltrucktype, d_sm_cargotrucktype], false, true, true, true, true, true] spawn d_fnc_sideobjects;
};

