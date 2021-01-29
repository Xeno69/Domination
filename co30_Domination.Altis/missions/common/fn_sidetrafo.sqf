// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sidetrafo.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_poss"];

private _objs = nearestObjects [_poss, ["Land_trafostanica_velka"], 40];

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
{_x addEventHandler ["handleDamage", {call d_fnc_AddSMPoints}]} forEach _objs;
#endif

sleep 2.123;
["specops", 2, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
sleep 2.221;
["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 300, true] spawn d_fnc_CreateArmor;

private _num_t = count _objs;

while {true} do {
	if ({damage _x >= 0.9 || {!alive _x}} count _objs == _num_t) exitWith {};
	sleep 5.326;
	__TRACE_1("","_objs")
	#ifdef __DEBUG__
	{
		__TRACE_3("","_x","damage _x","alive _x")
	} forEach _objs;
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
