//#define __DEBUG__
#include "..\x_setup.sqf"

//awareness loop - iterate through d_cur_tgt_enemy_units[] and run the awareness script for each unit
while {sleep 0.1; true} do {
	if (d_mt_spotted) then {
		{
			[_x, [west, east], d_ai_awareness_rad, d_ai_pursue_rad, d_ai_aggressiveshoot, d_ai_quickammo] call d_fnc_hallyg_dlegion_Snipe_awareness_global;
		} forEach d_cur_tgt_enemy_units;
		// diag_log [format ["awareness loop time: %1", time]];
	} else {
		sleep 13;
	};
};
