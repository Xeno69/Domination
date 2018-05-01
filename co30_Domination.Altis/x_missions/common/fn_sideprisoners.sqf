// by Xeno
#define THIS_FILE "fn_sideprisoners.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

(param [0]) params ["_pos"];

if (d_with_ranked) then {d_sm_p_pos = nil};

sleep 2;

#ifndef __TT__
private _newgroup = [d_own_side] call d_fnc_creategroup;
#else
private _newgroup = [civilian] call d_fnc_creategroup;
#endif
[_pos, call d_fnc_getunitlistc, _newgroup] call d_fnc_makemgroup;
private _leader = leader _newgroup;
_leader setSkill 1;
sleep 2.0112;
_newgroup allowFleeing 0;
_newgroup deleteGroupWhenEmpty true;
private _units = units _newgroup;
{
	removeAllWeapons _x;
	_x setCaptive true;
	_x disableAI "PATH";
	false
} count _units;

if (d_with_dynsim == 0) then {
	_newgroup enableDynamicSimulation true;
};

sleep 2.333;
["specops", 2, "allmen", (floor (random 4)) min 2, _pos, 150, true] spawn d_fnc_CreateInf;
sleep 2.333;
[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, _pos, 1, 400, true] spawn d_fnc_CreateArmor;
sleep 1;
["stat_mg", 1, "stat_gl", 1, "", 0, _pos, 1, 100, false] spawn d_fnc_CreateArmor;

sleep 32.123;

private _hostages_reached_dest = false;
private _all_dead = false;
private _rescued = false;
private _mforceendtime = time + 2400;

private _aiver_check_fnc = {
	if (!d_with_ai) then {
		(str _this) in d_can_use_artillery
	} else {
		true
	}
};

private _rescuer = objNull;
#ifdef __TT__
private _winner = 0;
#endif
while {!_hostages_reached_dest && {!_all_dead && {!d_sm_resolved}}} do {
	call d_fnc_mpcheck;
	if (_units findIf {alive _x} == -1) exitWith {
		_all_dead = true;
	};
	if (!_rescued) then {
		_leader = leader _newgroup;
		private _nobjs = _leader nearEntities ["CAManBase", 20];
		if !(_nobjs isEqualTo []) then {
			{
				if (alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false]) && {_x call _aiver_check_fnc}}}}) exitWith {
					_rescued = true;
					_mforceendtime = time + 2400;
					_rescuer = _x;
					{
						_x setCaptive false;
						_x enableAI "PATH";
						false
					} count (_units select {alive _x});
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
		_hostages_reached_dest = _units findIf {alive _x && {(vehicle _x) distance2D _tmp_flag < 50}} > -1;
		
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
	if (d_with_ranked && {_hostages_reached_dest}) then {
#ifndef __TT__
		private _tmp_flag = d_FLAG_BASE;
#else
		private _tmp_flag = if (_winner == 1) then {d_EFLAG_BASE} else {d_WFLAG_BASE};
#endif
		[missionNamespace, ["d_sm_p_pos", getPosATL _tmp_flag]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
	};
	if (time > _mforceendtime) then {
		{
			_x setDamage 1;
			false
		} count _units;
		_all_dead = true;
	};
	sleep 5.123;
};

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
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};

sleep 5.123;

{
	if (!isNull objectParent _x) then {
		(vehicle _x) deleteVehicleCrew _x;
	} else {
		deleteVehicle _x;
	};
	false
} count (_units select {!isNull _x});
sleep 0.5321;
if (!isNull _newgroup) then {deleteGroup _newgroup};
