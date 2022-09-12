//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

while {sleep 0.1; true} do {
	 {
	 	if (!alive _x) then {
			d_cur_tgt_civ_units deleteAt (d_cur_tgt_civ_units find _x);
		} else {
	 		_x call d_fnc_afterfirednear_civ_global;
	 	};
	 } forEach d_cur_tgt_civ_units;
	// diag_log [format ["civ loop time: %1", time]];
};
