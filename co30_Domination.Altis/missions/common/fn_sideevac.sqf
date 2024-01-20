// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_pos_array", "_endtime"];
_pos_array params ["_poss"];

private _wreck = createVehicle [d_sm_wrecktype, _poss, [], 0, "NONE"];
_wreck setDir (random 360);
_wreck setPos _poss;
_wreck lock true;
d_x_sm_vec_rem_ar pushBack _wreck;

sleep 2;

private _owngroup = [d_side_player] call d_fnc_creategroup;
__TRACE_1("","_owngroup")
private _nposss = _poss findEmptyPosition [20, 100, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};
private _pilot1 = _owngroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
_pilot1 allowDamage false;
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;
[_pilot1, getPos _pilot1] call d_fnc_setposagls;
_pilot1 enableStamina false;
_pilot1 enableFatigue false;
_pilot1 disableAI "RADIOPROTOCOL";

private _pilot2 = _owngroup createUnit [d_sm_pilottype, getPos _pilot1, [], 0, "NONE"];
_pilot2 allowDamage false;
__TRACE_1("","_pilot2")
_pilot2 call d_fnc_removenvgoggles_fak;
[_pilot2, getPos _pilot2] call d_fnc_setposagls;
[_pilot1, _pilot2] joinSilent _owngroup;
_pilot2 enableStamina false;
_pilot2 enableFatigue false;
_pilot2 disableAI "RADIOPROTOCOL";

private _otrig = [_pilot1, [800, 800, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["this", "[thisTrigger, 0] call d_fnc_trigwork", "[thisTrigger, 1] call d_fnc_trigwork"]] call d_fnc_createtriggerlocal;
_otrig setVariable ["d_objs", [_pilot1, _pilot2]];

sleep 15;
_pilot1 disableAI "PATH";
_pilot1 setDamage 0.5;
_pilot2 disableAI "PATH";
_pilot2 setDamage 0.5;

if (d_with_dynsim == 0) then {
	[_owngroup] spawn d_fnc_enabledynsim;
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
	} forEach _u;
};

#ifdef __TT__
private _which_base = 0;
#endif

while {!_pilots_at_base && {!_is_dead && {!d_sm_resolved}}} do {
	if (isMultiplayer) then {
		while {true} do {
			sleep (1.012 + random 1);
			_pnum = call d_fnc_PlayersNumber;
			if (_pnum == 0) then {_resctimestarted = time};
			if (_pnum > 0) exitWith {};
		};
	};
	if (!alive _pilot1 && {!alive _pilot2}) then {
		_is_dead = true;
	} else {
		if (!_rescued) then {
			__TRACE("not rescued")
			if (alive _pilot1) then {
				__TRACE("_pilot1 alive")
				private _nobjs = (_pilot1 nearEntities ["CAManBase", 20]) select {alive _x && {(isPlayer _x) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
				if (_nobjs isNotEqualTo []) then {
					_resctimestarted = time;
					_rescued = true;
					[[_pilot1, _pilot2], _nobjs # 0] call _pcheck_fnc;
					deleteVehicle _otrig;
				};
			};
			
			if (!_rescued) then {
				if (alive _pilot2) then {
					__TRACE("_pilot2 alive")
					private _nobjs = (_pilot2 nearEntities ["CAManBase", 20]) select {alive _x && {(isPlayer _x) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
					if (_nobjs isNotEqualTo []) then {
						_resctimestarted = time;
						_rescued = true;
						[[_pilot1, _pilot2], _nobjs # 0] call _pcheck_fnc;
						deleteVehicle _otrig;
					};
				};
				
				if (!_rescued && {time - _resctimestarted > 3600}) then {
					_is_dead = true;
				};
			};
		} else {
#ifndef __TT__
			if (_pilot1 distance2D d_FLAG_BASE < 50 || {_pilot2 distance2D d_FLAG_BASE < 50}) exitWith {_pilots_at_base = true};
			if (!isNil "d_flag_airfield" && {_pilot1 distance2D d_flag_airfield < 50 || {_pilot2 distance2D d_flag_airfield < 50}}) exitWith {_pilots_at_base = true};
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
			if (alive _pilot1 && {!(isPlayer [leader (group _pilot1)])} || {alive _pilot2 && {!(isPlayer [leader (group _pilot2)])}}) then {
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
				[23] call d_fnc_DoKBMsg;
#else
				[24] call d_fnc_DoKBMsg;
#endif
			};
		} else {
			if (_time_over == 2) then {
				if (_endtime - time <= 300) then {
					_time_over = 1;
#ifndef __TT__
					[25] call d_fnc_DoKBMsg;
#else
					[26] call d_fnc_DoKBMsg;
#endif
				};
			} else {
				if (_time_over == 1) then {
					if (_endtime - time <= 120) then {
						_time_over = 0;
#ifndef __TT__
						[27] call d_fnc_DoKBMsg;
#else
						[28] call d_fnc_DoKBMsg;
#endif
					};
				};
			};
		};
	} else {
		if (!_enemy_created) then {
			_enemy_created = true;
			if (alive _pilot1) then {
				_pilot1 allowDamage true;
			};
			if (alive _pilot2) then {
				_pilot2 allowDamage true;
			};
			deleteVehicle _otrig;
			private _estart_pos = [_poss, 250] call d_fnc_GetRanPointCircleOuter;
			private _unit_array = ["allmen", d_enemy_side_short] call d_fnc_getunitlistm;
			for "_i" from 1 to ([3,5] call d_fnc_GetRandomRangeInt) do {
				private _newgroup = [d_enemy_side] call d_fnc_creategroup;
				private _units = [_estart_pos, _unit_array, _newgroup, false, true] call d_fnc_makemgroup;
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
				{_x triggerDynamicSimulation true} forEach _units;
				sleep 1.012;
			};
			_unit_array = nil;
		};
	};
};

if (!d_sm_resolved) then {
	if (_is_dead) then {
		d_sm_winner = -700;
	} else {
		if (d_with_ranked || {d_database_found}) then {
	#ifndef __TT__
			(getPosATL d_FLAG_BASE) remoteExecCall ["d_fnc_smsvpos", [0, -2] select isDedicated];
	#else
			if (d_sm_winner == 1) then {
				(getPosATL d_EFLAG_BASE) remoteExecCall ["d_fnc_smsvpos", [0, -2] select isDedicated];
			} else {
				(getPosATL d_WFLAG_BASE) remoteExecCall ["d_fnc_smsvpos", [0, -2] select isDedicated];
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
} forEach [_pilot1, _pilot2];
if (!isNull _otrig) then {
	deleteVehicle _otrig;
};
sleep 0.5;

d_sm_resolved = true;
