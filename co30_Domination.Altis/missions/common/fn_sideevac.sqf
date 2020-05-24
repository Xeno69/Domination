// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideevac.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_pos_array", "_endtime"];
_pos_array params ["_poss"];

private _wreck = createVehicle [d_sm_wrecktype, _poss, [], 0, "NONE"];
_wreck setDir (random 360);
_wreck setPos _poss;
_wreck lock true;
d_x_sm_vec_rem_ar pushBack _wreck;

private _distanceToEnablePilotMovement = 20;

sleep 2;

private _owngroup = [d_side_player] call d_fnc_creategroup;
if (d_with_ai) then {
	_owngroup setVariable ["d_do_not_delete", true];
};
__TRACE_1("","_owngroup")
private _nposss = [];
if (d_MissionType == 3) then {
	_nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
} else {
	_nposss = _poss findEmptyPosition [20, 100, d_sm_pilottype];
};
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

if (d_MissionType == 3) then {

	[
		([[[_poss, 35]],[]] call BIS_fnc_randomPos),											// Params: 1. Array, the building(s) nearest this position is used
		[_pilot1],									//         2. Array of objects, the units that will garrison the building(s)
		-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
		false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
		false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
		true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
		false,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
		2   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	] call d_fnc_Zen_OccupyHouse;
	
	[
		([[[_poss, 35]],[]] call BIS_fnc_randomPos),											// Params: 1. Array, the building(s) nearest this position is used
		[_pilot2],									//         2. Array of objects, the units that will garrison the building(s)
		-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
		false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
		false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
		true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
		false,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
		2   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	] call d_fnc_Zen_OccupyHouse;


	sleep 1;
	_pilot1 setUnitPos "DOWN";
	_pilot2 setUnitPos "DOWN";
	_pilot1 forceSpeed 0;
	_pilot2 forceSpeed 0;
	_owngroup setCombatMode "BLUE";
	sleep 180;
	//180 seconds then good luck, boys.
	if (alive _pilot1) then {
		_pilot1 allowDamage true;
	};
	if (alive _pilot2) then {
		_pilot2 allowDamage true;
	};
	_distanceToEnablePilotMovement = 3;
};

sleep 15;
_pilot1 disableAI "PATH";
_pilot1 setDamage 0.5;
_pilot2 disableAI "PATH";
_pilot2 setDamage 0.5;

_owngroup deleteGroupWhenEmpty true;

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
		_x forceSpeed -1;
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
				private _nobjs = (_pilot1 nearEntities ["CAManBase", _distanceToEnablePilotMovement]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
				if !(_nobjs isEqualTo []) then {
					_resctimestarted = time;
					_rescued = true;
					[[_pilot1, _pilot2], _nobjs # 0] call _pcheck_fnc;
					deleteVehicle _otrig;
				};
			};
			
			if (!_rescued) then {
				if (alive _pilot2) then {
					__TRACE("_pilot2 alive")
					private _nobjs = (_pilot2 nearEntities ["CAManBase", _distanceToEnablePilotMovement]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
					if !(_nobjs isEqualTo []) then {
						_resctimestarted = time;
						_rescued = true;
						[[_pilot1, _pilot2], _nobjs # 0] call _pcheck_fnc;
						deleteVehicle _otrig;
					};
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
			if (alive _pilot1 && {!(leader (group _pilot1) call d_fnc_isplayer)} || {alive _pilot2 && {!(leader (group _pilot2) call d_fnc_isplayer)}}) then {
				_rescued = false;
			};
		};
	};

	sleep 5.621;
	
};

if (!d_sm_resolved) then {
	if (_is_dead) then {
		d_sm_winner = -700;
	} else {
		if (d_with_ranked || {d_database_found}) then {
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
} forEach [_pilot1, _pilot2];
if (!isNull _otrig) then {
	deleteVehicle _otrig;
};
sleep 0.5;

d_sm_resolved = true;
d_sm_nearby_cleared = true;
