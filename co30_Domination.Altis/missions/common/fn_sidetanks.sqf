// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_posi_array", "_dirs"];

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
#endif

private _tanks_ar = [];
for "_ii" from 1 to (count _posi_array) - 1 do {
	private _tank = createVehicle [d_sm_tank, _posi_array # _ii, [], 0, "NONE"];
	_tank allowDamage false;
	_tank spawn {
		scriptName "spawn_sidetanksallowdamage";
		sleep 30;
		_this allowDamage true;
		__TRACE_1("damage1 allowed","_this")
	};
	_tank setDir (_dirs # _ii);
	_tank setPos (_posi_array # _ii);
	d_x_sm_vec_rem_ar pushBack _tank;
	_tank lock true;
#ifdef __TT__
	_tank addEventHandler ["handleDamage", {call d_fnc_AddSMPoints}];
#endif
	_tanks_ar pushBack _tank;
	sleep 0.512;
};

sleep 2.333;
["specops", (floor (random 3)) min 1, "allmen", (floor (random 3)) min 1, _posi_array # 0, 300, true] spawn d_fnc_CreateInf;
sleep 2.333;
[selectRandom ["aa", "tank"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 1, selectRandom ["jeep_mg", "jeep_gl"], 2, _posi_array # 0, 1, 400, true] spawn d_fnc_CreateArmor;
sleep 1;
["stat_mg", 1, "stat_gl", 1, "", 0, _posi_array # 0, 1, 100, false] spawn d_fnc_CreateArmor;

_dirs = nil;
_posi_array = nil;

sleep 15.321;

private _num_t = count _tanks_ar;

while {true} do {
	if ({damage _x >= 0.9 || {!alive _x}} count _tanks_ar == _num_t) exitWith {};
	sleep 5.321;
	__TRACE_1("","_tanks_ar")
	#ifdef __DEBUG__
	{
		__TRACE_3("","_x","damage _x","alive _x")
	} forEach _tanks_ar;
	#endif
	if (d_sm_resolved) exitWith {};
};

if (!d_sm_resolved) then {
	#ifndef __TT__
	d_sm_winner = 2;
	#else
	if (d_sm_points_blufor > d_sm_points_opfor) then {
		d_sm_winner = 2;
	} else {
		if (d_sm_points_opfor > d_sm_points_blufor) then {
			d_sm_winner = 1;
		} else {
			if (d_sm_points_opfor == d_sm_points_blufor) then {
				d_sm_winner = 123;
			};
		};
	};
	#endif
};

d_sm_resolved = true;
