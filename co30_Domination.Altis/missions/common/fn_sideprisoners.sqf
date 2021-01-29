// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideprisoners.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

(_this # 0) params ["_pos"];

if (d_with_ranked || {d_database_found}) then {d_sm_p_pos = nil};

sleep 2;

#ifndef __TT__
private _newgroup = [d_own_side] call d_fnc_creategroup;
#else
private _newgroup = [civilian] call d_fnc_creategroup;
#endif
private _units = [_pos, call d_fnc_getunitlistc, _newgroup, false, false] call d_fnc_makemgroup;
{
	removeAllWeapons _x;
	_x setCaptive true;
	_x disableAI "PATH";
	_x allowDamage false;
} forEach _units;
private _leader = leader _newgroup;
_leader setSkill 1;
_newgroup allowFleeing 0;
_newgroup deleteGroupWhenEmpty true;

d_x_sm_rem_ar append _units;

private _otrig = [_leader, [800, 800, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["this", "[thisTrigger, 0] call d_fnc_trigwork", "[thisTrigger, 1] call d_fnc_trigwork"]] call d_fnc_createtriggerlocal;
_otrig setVariable ["d_objs", _units];

__TRACE_1("","_units")

if (d_with_dynsim == 0) then {
	[_newgroup] spawn d_fnc_enabledynsim;
};

sleep 2.333;

["specops", 2, "allmen", (floor (random 3)) min 1, _pos, 150, true] spawn d_fnc_CreateInf;
sleep 2.333;
[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 1, selectRandom ["jeep_mg", "jeep_gl"], 2, _pos, 1, 400, true] spawn d_fnc_CreateArmor;
sleep 1;
["stat_mg", 1, "stat_gl", 1, "", 0, _pos, 1, 100, false] spawn d_fnc_CreateArmor;

sleep 32.123;

_units spawn {
	scriptName "spawn sideevac";
	sleep 30;
	{
		_x setDamage 0;
		_x allowDamage true;
	} forEach _this;
};

private _hostages_reached_dest = false;
private _all_dead = false;
private _rescued = false;
private _mforceendtime = time + 2400;
__TRACE_1("","_mforceendtime")

private _rescuer = objNull;
#ifdef __TT__
private _winner = 0;
#endif
while {!_hostages_reached_dest && {!_all_dead && {!d_sm_resolved}}} do {
	if (isMultiplayer && {(call d_fnc_PlayersNumber) == 0}) then {
		__TRACE("No players")
		while {true} do {
			sleep (1.012 + random 1);
			if ((call d_fnc_PlayersNumber) > 0) exitWith {};
		};
		_mforceendtime = time + 2400;
		__TRACE_1("1","_mforceendtime")
	};
	if (_units findIf {alive _x} == -1) exitWith {
		__TRACE("All dead exiting")
		_all_dead = true;
	};
	if (!_rescued) then {
		_leader = leader _newgroup;
		private _nobjs = _leader nearEntities ["CAManBase", 20];
		if (_nobjs isNotEqualTo []) then {
			{
				if (alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}) exitWith {
					_rescued = true;
					deleteVehicle _otrig;
					_mforceendtime = time + 2400;
					__TRACE_2("rescued","_rescued","_mforceendtime")
					_rescuer = _x;
					{
						_x setCaptive false;
						_x enableAI "PATH";
					} forEach (_units select {alive _x});
					_units join _rescuer;
#ifdef __TT__
					_winner = switch (side (group _rescuer)) do {case blufor: {2}; case opfor: {1};default {0}}; 
#endif
				};
				sleep 0.01;
			} forEach _nobjs;
		};
	} else {
#ifndef __TT__
		private _tmp_flag = d_FLAG_BASE;
#else
		private _tmp_flag = if (_winner == 1) then {d_EFLAG_BASE} else {d_WFLAG_BASE};
#endif
		_hostages_reached_dest = _units findIf {alive _x && {(vehicle _x) distance2D _tmp_flag < 50 || {!isNil "d_flag_airfield" && {(vehicle _x) distance2D d_flag_airfield < 50}}}} > -1;
		
		__TRACE_1("1","_hostages_reached_dest")
		
		if (!_hostages_reached_dest) then {
			private _fidx = _units findIf {alive _x};
			if (_fidx > -1) then {
				_newgroup = group (_units # _fidx);
			};
			if !((leader _newgroup) call d_fnc_isplayer) then {
				_rescued = false;
#ifdef __TT__
				_winner = 0;
#endif
			};
		};
	};
	if ((d_with_ranked  || {d_database_found}) && {_hostages_reached_dest}) then {
#ifndef __TT__
		private _tmp_flag = d_FLAG_BASE;
#else
		private _tmp_flag = if (_winner == 1) then {d_EFLAG_BASE} else {d_WFLAG_BASE};
#endif
		(getPosATL _tmp_flag) remoteExecCall ["d_fnc_smsvpos", [0, -2] select isDedicated];
	};
	if (time > _mforceendtime) exitWith {
		{
			_x setDamage 1;
		} forEach _units;
		_all_dead = true;
		__TRACE("Reached end time")
	};
	sleep 5.123;
};

__TRACE_3("over","_hostages_reached_dest","_all_dead","_rescued")
__TRACE_1("over","_mforceendtime")

if (!d_sm_resolved) then {
	if (_all_dead) then {
		d_sm_winner = -400;
	} else {
		if ({alive _x} count _units > 7) then {
	#ifndef __TT__
			d_sm_winner = 2;
	#else
			d_sm_winner = _winner;
	#endif
		} else {
			d_sm_winner = -400;
		};
	};
};

d_sm_resolved = true;

sleep 5.123;

{
	if (!isNull objectParent _x) then {
		(vehicle _x) deleteVehicleCrew _x;
	} else {
		deleteVehicle _x;
	};
} forEach (_units select {!isNull _x});
if (!isNull _otrig) then {
	deleteVehicle _otrig;
};
sleep 0.5321;
if (!isNull _newgroup) then {deleteGroup _newgroup};
