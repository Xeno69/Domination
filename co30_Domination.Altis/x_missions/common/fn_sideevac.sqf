// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideevac.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_pos_array", "_endtime"];
_pos_array params ["_poss"];

private _wreck = createVehicle [d_sm_wrecktype, _poss, [], 0, "NONE"];
_wreck setDir (random 360);
_wreck setPos _poss;
_wreck lock true;
d_x_sm_vec_rem_ar pushBack _wreck;

sleep 2;

private _owngroup = [d_side_player] call d_fnc_creategroup;
if (d_with_ai) then {
	_owngroup setVariable ["d_do_not_delete", true];
};
__TRACE_1("","_owngroup")
private _pilot1 = _owngroup createUnit [d_sm_pilottype, _poss, [], 60, "NONE"];
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;

private _pilot2 = _owngroup createUnit [d_sm_pilottype, getPosATL _pilot1, [], 0, "NONE"];
__TRACE_1("","_pilot2")
_pilot2 call d_fnc_removenvgoggles_fak;
[_pilot1, _pilot2] joinSilent _owngroup;

sleep 15;
_pilot1 disableAI "PATH";
_pilot1 setDamage 0.5;
_pilot2 disableAI "PATH";
_pilot2 setDamage 0.5;

_owngroup deleteGroupWhenEmpty true;

if (d_with_dynsim == 0) then {
	_owngroup enableDynamicSimulation true;
};

private _is_dead = false;
private _pilots_at_base = false;
private _rescued = false;
private _time_over = 3;
private _enemy_created = false;
private _resctimestarted = time;

private _pcheck_fnc = {
	params ["_u", "_p"];
	{
		private _ogroup = group _x;
		_x setUnitPos "AUTO";
		_x enableAI "PATH";
		[_x] join _p;
		deleteGroup _ogroup;
		false
	} count _u;
};

private _aiver_check_fnc = {
	if (!d_with_ai) then {
		(str _this) in d_can_use_artillery
	} else {
		true
	}
};

#ifdef __TT__
private _which_base = 0;
#endif

while {!_pilots_at_base && {!_is_dead && {!d_sm_resolved}}} do {
	if (isMultiplayer) then {waitUntil {sleep (1.012 + random 1);_pnum = call d_fnc_PlayersNumber; if (_pnum == 0) then {_resctimestarted = time};_pnum > 0}};
	if (!alive _pilot1 && {!alive _pilot2}) then {
		_is_dead = true;
	} else {
		if (!_rescued) then {
			__TRACE("not rescued")
			if (alive _pilot1) then {
				__TRACE("_pilot1 alive")
				private _nobjs = (_pilot1 nearEntities ["CAManBase", 20]) select {alive _x && {isPlayer _x && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false]) && {_x call _aiver_check_fnc}}}}};
				if !(_nobjs isEqualTo []) then {
					_resctimestarted = time;
					_rescued = true;
					[[_pilot1, _pilot2], _nobjs # 0] call _pcheck_fnc;
				};
			};
			
			if (!_rescued) then {
				if (alive _pilot2) then {
					__TRACE("_pilot2 alive")
					private _nobjs = (_pilot2 nearEntities ["CAManBase", 20]) select {alive _x && {isPlayer _x && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false]) && {_x call _aiver_check_fnc}}}}};
					if !(_nobjs isEqualTo []) then {
						_resctimestarted = time;
						_rescued = true;
						[[_pilot1, _pilot2], _nobjs # 0] call _pcheck_fnc;
					};
				};
				
				if (!_rescued && {time - _resctimestarted > 3600}) then {
					_is_dead = true;
				};
			};
		} else {
#ifndef __TT__
			if (_pilot1 distance2D d_FLAG_BASE < 50 || {_pilot2 distance2D d_FLAG_BASE < 50}) exitWith {_pilots_at_base = true};
#else
			if (_pilot1 distance2D d_EFLAG_BASE < 50 || {_pilot2 distance2D d_EFLAG_BASE < 50}) exitWith {
				_pilots_at_base = true;
				_which_base = 1;
			};
			if (_pilot1 distance2D d_WFLAG_BASE < 50 || {_pilot2 distance2D d_WFLAG_BASE < 50}) exitWith {
				_pilots_at_base = true;
				_which_base = 2;
			};
#endif
			if (alive _pilot1 && {!(isPlayer leader (group _pilot1))} || {alive _pilot2 && {!(isPlayer leader (group _pilot2))}}) then {
				_rescued = false;
			};
			if (time - _resctimestarted > 3600) then {
				_is_dead = true;
			};
		};
	};

	sleep 5.621;
	if (_time_over > 0) then {
		if (_time_over == 3) then {
			if (_endtime - time <= 600) then {
				_time_over = 2;
#ifndef __TT__
				[23] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
				[24] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
			};
		} else {
			if (_time_over == 2) then {
				if (_endtime - time <= 300) then {
					_time_over = 1;
#ifndef __TT__
					[25] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
					[26] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
				};
			} else {
				if (_time_over == 1) then {
					if (_endtime - time <= 120) then {
						_time_over = 0;
#ifndef __TT__
						[27] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
						[28] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
					};
				};
			};
		};
	} else {
		if (!_enemy_created) then {
			_enemy_created = true;
			private _estart_pos = [_poss,250] call d_fnc_GetRanPointCircleOuter;
			private _unit_array = ["allmen", d_enemy_side_short] call d_fnc_getunitlistm;
			for "_i" from 1 to ([3,5] call d_fnc_GetRandomRangeInt) do {
				private _newgroup = [d_enemy_side] call d_fnc_creategroup;
				private _units = [_estart_pos, _unit_array, _newgroup] call d_fnc_makemgroup;
				_newgroup deleteGroupWhenEmpty true;
				sleep 1.045;
				private _leader = leader _newgroup;
				_leader setRank "LIEUTENANT";
				_newgroup allowFleeing 0;
				_newgroup setBehaviour "AWARE";
				private _gwp = _newgroup addWaypoint [_poss, 30];
				_gwp setWaypointtype "SAD";
				_gwp setWaypointCombatMode "YELLOW";
				_gwp setWaypointSpeed "FULL";
				d_x_sm_rem_ar append _units;
				{_x triggerDynamicSimulation true; false} count _units;
				sleep 1.012;
			};
			if (d_with_dynsim == 0) then {
				_owngroup enableDynamicSimulation false;
			};
			_unit_array = nil;
		};
	};
};

if (!d_sm_resolved) then {
	if (_is_dead) then {
		d_sm_winner = -700;
	} else {
		if (d_with_ranked) then {
	#ifndef __TT__
			[missionNamespace, ["d_sm_p_pos", getPosATL d_FLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
	#else
			if (d_sm_winner == 1) then {
				[missionNamespace, ["d_sm_p_pos", getPosATL d_EFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
			} else {
				[missionNamespace, ["d_sm_p_pos", getPosATL d_WFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
			};
	#endif
		};
	#ifndef __TT__
		d_sm_winner = 2;
	#else
		d_sm_winner = _which_base;
	#endif
	};
};

sleep 2.123;

{
	if (!isNull _x) then {
		if (!isNull objectParent _x) then {
			(objectParent _x) deleteVehicleCrew _x;
		} else {
			deleteVehicle _x;
		};
	};
	false
} count [_pilot1, _pilot2];
sleep 0.5;

d_sm_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};