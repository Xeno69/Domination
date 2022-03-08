//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

while {sleep 0.1; true} do {
	 {
	 	_x call d_fnc_afterfirednear_civ_global;
	 } forEach d_cur_tgt_civ_units;
	// diag_log [format ["civ loop time: %1", time]];
};
