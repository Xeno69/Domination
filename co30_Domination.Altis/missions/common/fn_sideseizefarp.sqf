// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_seizefarp.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(isServer) exitWith {};

params ["_poss", ["_createarmor", false], ["_createinf", false]];

private _flag = objNull;

((allMissionObjects "FlagCarrierCore") select {(str _x) select [0, 9] isEqualTo "d_flag_bb"}) findIf {
	private _ret = _x distance2D _poss < 50;
	if (_ret) then {
		_flag = _x;
	};
	_ret
};

d_sm_farpseized = false;
publicVariable "d_sm_farpseized";
[_flag, 2] remoteExecCall ["d_fnc_addactionssm", [0, -2] select isDedicated, _flag];

if (_createarmor) then {
	__TRACE("Creating armor")
	sleep 2.22;
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 1, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 250, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};
if (_createinf) then {
	sleep 2.123;
	__TRACE("Creating inf")
	["specops", 2, "allmen", (floor (random 3)) min 1, _poss, 150, true] spawn d_fnc_CreateInf;
};

while {!d_sm_farpseized && {!d_sm_resolved}} do {
	sleep 2.5;
};

_flag setVariable ["d_farptaken", true, true];

[_flag] remoteExecCall ["d_fnc_remactionssm", [0, -2] select isDedicated];
remoteExecCall ["", _flag];

d_retaken_farpspos pushBack _poss;

private _box = [_flag getVariable "d_farp_aboxmarker"] call d_fnc_aboxcreate;
[_flag, _box] remoteExecCall ["d_fnc_ccreateboxfarp", [0, -2] select isDedicated];
d_player_ammoboxes pushBack _box;
publicVariable "d_player_ammoboxes";

private _ma = _flag getVariable "d_farp_marker";
if (!isNil "_ma") then {
	_ma setMarkerAlpha 1;
};

// 1243 - 1245

d_sm_farpseized = nil;
publicVariable "d_sm_farpseized";

d_sm_winner = 2;
d_sm_resolved = true;
