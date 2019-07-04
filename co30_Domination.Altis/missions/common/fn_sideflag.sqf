// by Xeno
#define THIS_FILE "fn_sideflag.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_posi_array"];

private _ran_pos = selectRandom _posi_array;

_posi_array = nil;

if (d_with_ranked || {d_database_found}) then {d_sm_p_pos = nil};

private _flag = createVehicle [d_flag_pole, _ran_pos, [], 0, "NONE"];
_flag setPos _ran_pos;

_flag setFlagTexture (call d_fnc_getenemyflagtex);

_flag setFlagside d_side_enemy;

sleep 2.123;
[selectRandom ["aa", "tank"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, _ran_pos, 1, 350, true] spawn d_fnc_CreateArmor;
sleep 1;
["stat_mg", 1, "stat_gl", 1, "", 0, _ran_pos, 1, 100, false] spawn d_fnc_CreateArmor;
sleep 2.123;
["specops", (floor (random 4)) min 2, "allmen", (floor (random 3)) min 1, _ran_pos, 250, true] spawn d_fnc_CreateInf;

_ran_pos = nil;

sleep 15.111;

d_sm_flag_failed = false;
private _ownerthere = false;

while {true} do {
	private _owner = flagOwner _flag;
	
	if (!isNull _owner && {isNil {_owner getVariable "d_flagowner"}}) then {
		_ownerthere = true;
		_owner setVariable ["d_flagowner", _owner addMPEventHandler ["MPKilled", {if (!isNil "d_sm_flag_failed") then {d_sm_flag_failed = true}}]];
	};

#ifndef __TT__
	if (!isNull _owner && {_owner distance2D d_FLAG_BASE < 40 || {!isNil "d_flag_airfield" && {_owner distance2D d_flag_airfield < 40}}}) exitWith {
		if (d_with_ranked || {d_database_found}) then {
			[missionNamespace, ["d_sm_p_pos", getPosATL d_FLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
		};
		_flag setFlagOwner objNull;
		if (!d_sm_resolved) then {
			d_sm_winner = 2;
		};
		d_sm_resolved = true;
	};
#else
	if (!isNull _owner && {(_owner distance2D d_EFLAG_BASE < 40)}) exitWith {
		if (d_with_ranked || {d_database_found}) then {
			[missionNamespace, ["d_sm_p_pos", getPosATL d_EFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
		};
		_flag setFlagOwner objNull;
		if (!d_sm_resolved) then {
			d_sm_winner = 1;
		};
		d_sm_resolved = true;
	};
	if (!isNull _owner && {(_owner distance2D d_WFLAG_BASE < 40)}) exitWith {
		if (d_with_ranked || {d_database_found}) then {
			[missionNamespace, ["d_sm_p_pos", getPosATL d_WFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
		};
		_flag setFlagOwner objNull;
		if (!d_sm_resolved) then {
			d_sm_winner = 2;
		};
		d_sm_resolved = true;
	};
#endif
	
	if (d_sm_flag_failed  || {_ownerthere && {isNil "_owner" || {isNull _owner}}}) exitWith {
		_flag setFlagOwner objNull;
		if (!d_sm_resolved) then {
			d_sm_winner = -900;
		};
		d_sm_resolved = true;
		if (!isNil "_owner" && {!isNull _owner}) then {
			_owner removeMPEventHandler ["MPKilled", _owner getVariable "d_flagowner"];
			_owner setVariable ["d_flagowner", nil];
		};
	};
	sleep 5.123;
	if (d_sm_resolved) exitWith {};
};

deleteVehicle _flag;

d_sm_flag_failed = nil;