// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gleak.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(isServer) exitWith {};

params ["_poss", ["_createarmor", false], ["_createinf", false]];

private _vec = createVehicle ["Land_ReservoirTank_V1_F", _poss, [], 0, "NONE"];
_vec allowDamage false;

if (_createarmor) then {
	__TRACE("Creating armor")
	sleep 2.22;
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 1, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};
if (_createinf) then {
	sleep 2.123;
	__TRACE("Creating inf")
	["specops", 2, "allmen", (floor (random 3)) min 1, _poss, 150, true] spawn d_fnc_CreateInf;
};

private _moduleGroup = createGroup sideLogic;
private _module = _moduleGroup createUnit ["ModuleSmokeGreen_F", _poss, [], 0, "CAN_COLLIDE"];
_module setPos _poss;
[_module] call BIS_fnc_initModules;

d_sm_leak_sealed = false;
publicVariable "d_sm_leak_sealed";
[_vec, 1] remoteExecCall ["d_fnc_addactionssm", [0, -2] select isDedicated, _vec];

d_x_sm_vec_rem_ar pushBack _vec;

[_vec, 0] remoteExecCall ["d_fnc_createtrigsm", [0, -2] select isDedicated, _vec];

while {!d_sm_leak_sealed && {!d_sm_resolved}} do {
	sleep 2.5;
};

deleteVehicle _module;

#ifndef __TT__
d_sm_winner = 2;
#else
if (d_sm_side_caller == blufor) then {
	d_sm_winner = 2;
} else {
	if (d_sm_side_caller == opfor) then {
		d_sm_winner = 1;
	} else {
		d_sm_winner = -1000;
	};
};
d_sm_side_caller = nil;
#endif

d_sm_leak_sealed = nil;

d_sm_resolved = true;