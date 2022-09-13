//#define __DEBUG__
#include "..\x_setup.sqf"

//awareness loop - iterate through d_cur_tgt_enemy_units[] and run the awareness script for each unit
while {sleep 0.1; true} do {
	private _start_time = time;
	private _count = 0;
	if (d_mt_spotted || {d_enable_awareness}) then {
		if (d_mt_spotted && {!d_enable_awareness}) then {
			// if d_mt_spotted is true then awareness should start, d_mt_spotted is set to false when radiotower is destroyed
			d_enable_awareness = true; // later set to false in fn_target_clear
		};
		{
			if (!alive _x) then {
				d_cur_tgt_enemy_units deleteAt (d_cur_tgt_enemy_units find _x);
			} else {
				[_x, [d_side_player], d_ai_awareness_rad, d_ai_pursue_rad, d_ai_aggressiveshoot, d_ai_quickammo] call d_fnc_hallyg_dlegion_Snipe_awareness_global;
				_count = _count + 1;
			};
		} forEach d_cur_tgt_enemy_units;
		//diag_log [format ["enemy awareness loop time: %1 and total units process: %2", time - _start_time, _count]];
	} else {
		sleep 13;
	};
};
