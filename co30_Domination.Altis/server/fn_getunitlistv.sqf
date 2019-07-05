// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitlistv.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_grptype", "_side"];
private _side_char = if (_side isEqualType "") then {
	_side
} else {
	switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case civilian: {"W"};}
};
private _idx = ["tank", "tracked_apc", "wheeled_apc", "aa", "jeep_mg", "jeep_gl", "stat_mg", "stat_gl", "arty", "tr_fuel", "tr_rep", "tr_ammo"] find _grptype;
if (_idx != -1) exitWith {
	selectRandom ((missionNamespace getVariable format ["d_veh_a_%1", _side_char]) select _idx)
};
[]