//#define __DEBUG__
#include "..\x_setup.sqf"

//awareness loop - iterate through d_cur_tgt_enemy_units[] and run the awareness script for each unit
while {sleep 0.1; true} do {
#ifdef __DEBUG__
	private _start_time = time;
	private _count = 0;
#endif
	if (d_mt_spotted || {d_enable_awareness}) then {
		if (d_mt_spotted && {!d_enable_awareness}) then {
			// if d_mt_spotted is true then awareness should start, d_mt_spotted is set to false when radiotower is destroyed
			d_enable_awareness = true; // later set to false in fn_target_clear
		};
		d_cur_tgt_enemy_units = d_cur_tgt_enemy_units - [objNull];
		{
			if (isNil "_x" || {!alive _x}) then {
				d_cur_tgt_enemy_units set [_forEachIndex, objNull];
			} else {
				[_x, [d_side_player], d_ai_awareness_rad, d_ai_pursue_rad, d_ai_aggressiveshoot, d_ai_quickammo] call d_fnc_hallyg_dlegion_Snipe_awareness_global;
				sleep 0.1;
#ifdef __DEBUG__
				_count = _count + 1;
#endif
			};
		} forEach d_cur_tgt_enemy_units;
		d_cur_tgt_enemy_units = d_cur_tgt_enemy_units - [objNull];
#ifdef __DEBUG__
		diag_log [format ["enemy awareness loop time: %1 and total units process: %2", time - _start_time, _count]];
#endif
	} else {
		sleep 13;
	};
};
