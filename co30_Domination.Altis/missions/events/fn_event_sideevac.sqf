// by Xeno (modified by Longtime)
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Shot down chopper as an event - no timer.
// Random crash site location, pilots are teleported to a nearby building and ordered posture down.
// The pilots are vulnerable to damage after 30 seconds.  Rescue magically by being near the pilots.

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

//position the event site near target center at max distance 125m and min 15m 
private _poss = [[[_target_center, 125]],[[_target_center, 15]]] call BIS_fnc_randomPos;
private _x_mt_event_ar = [];

private _trigger = [_poss, [120,120,0,false,30], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

private _eventDescription = localize "STR_DOM_MISSIONSTRING_1803_NO_TIMER";
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

private _wreck = createVehicle [d_sm_wrecktype, _poss, [], 0, "NONE"];
_wreck setDir (random 360);
_wreck setPos _poss;
_wreck lock true;
_x_mt_event_ar pushBack _wreck;

private _distanceToEnablePilotMovement = 3; //in meters

sleep 2;

private _marker = ["d_mt_event_marker_sideevac", _poss, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_CRASH", 0, "mil_warning"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_CRASH"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSideEvac",d_kbtel_chan];

private _owngroup1 = [d_side_player] call d_fnc_creategroup;
__TRACE_1("","_owngroup1")
private _nposss = [];
_nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};
private _pilot1 = _owngroup1 createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
[_pilot1] joinSilent _owngroup1;
_x_mt_event_ar pushBack _pilot1;
[_pilot1, 120] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;
[_pilot1, getPos _pilot1] call d_fnc_setposagls;
_pilot1 enableStamina false;
_pilot1 enableFatigue false;
_pilot1 disableAI "RADIOPROTOCOL";
removeFromRemainsCollector [_pilot1];
_pilot1 addEventHandler ["Killed", {
	_this spawn {
		scriptName "special cleanup rules for rescue pilots";
		private _t = time;
		waitUntil { time > (_t + 1200) };
		addToRemainsCollector [_this];
	};
}];

private _owngroup2 = [d_side_player] call d_fnc_creategroup;
__TRACE_1("","_owngroup2")
private _pilot2 = _owngroup2 createUnit [d_sm_pilottype, getPos _pilot1, [], 0, "NONE"];
[_pilot2] joinSilent _owngroup2;
_x_mt_event_ar pushBack _pilot2;
[_pilot2, 120] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot2")
_pilot2 call d_fnc_removenvgoggles_fak;
[_pilot2, getPos _pilot2] call d_fnc_setposagls;
_pilot2 enableStamina false;
_pilot2 enableFatigue false;
_pilot2 disableAI "RADIOPROTOCOL";
removeFromRemainsCollector [_pilot2];
_pilot2 addEventHandler ["Killed", {
	_this spawn {
		scriptName "special cleanup rules for rescue pilots";
		private _t = time;
		waitUntil { time > (_t + 1200) };
		addToRemainsCollector [_this];
	}; 
}];

[
	([[[_poss, 35]],[]] call BIS_fnc_randomPos),											// Params: 1. Array, the building(s) nearest this position is used
	[_pilot1],									//         2. Array of objects, the units that will garrison the building(s)
	-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
	false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
	false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
	true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
	false,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
	2, //  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
] call d_fnc_Zen_OccupyHouse;

[
	([[[_poss, 35]],[]] call BIS_fnc_randomPos),											// Params: 1. Array, the building(s) nearest this position is used
	[_pilot2],									//         2. Array of objects, the units that will garrison the building(s)
	-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
	false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
	false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
	true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
	false,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
	2, //  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
] call d_fnc_Zen_OccupyHouse;

sleep 1;

_pilot1 setUnitPos "DOWN";
_pilot2 setUnitPos "DOWN";
_pilot1 forceSpeed 0;
_pilot2 forceSpeed 0;
_owngroup1 setCombatMode "BLUE";
_owngroup2 setCombatMode "BLUE";

sleep 3.14;

_pilot1 disableAI "PATH";
_pilot1 setDamage 0.5;
_pilot2 disableAI "PATH";
_pilot2 setDamage 0.5;

if (d_with_dynsim == 0) then {
	[_owngroup1] spawn d_fnc_enabledynsim;
	[_owngroup2] spawn d_fnc_enabledynsim;
};

private _is_dead1 = false;
private _is_dead2 = false;
private _is_dead_all = false;
private _rescued1 = false;
private _rescued2 = false;

while { !d_mt_done } do {

	// if both pilots are dead then exit
	if (_is_dead1 && {_is_dead2}) exitWith { _is_dead_all = true };
	
	private _resolved1 = (_rescued1 || _is_dead1);
	private _resolved2 = (_rescued2 || _is_dead2);
	
	// if both pilots are resolved then exit
	if (_resolved1 && {_resolved2}) exitWith {};
	
	// is pilot1 resolved?
	if (!_resolved1) then {
		if (alive _pilot1) then {
			private _nobjs = (_pilot1 nearEntities ["CAManBase", _distanceToEnablePilotMovement]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
			if (_nobjs isNotEqualTo []) then {
				_rescued1 = true;
				__TRACE("rescued1")
				deleteVehicle _pilot1;
				// todo announce
			};
		} else {
			_is_dead1 = true;
		};
	};
	
	// is pilot2 resolved?
	if (!_resolved2) then {
		if (alive _pilot2) then {
			private _nobjs = (_pilot2 nearEntities ["CAManBase", _distanceToEnablePilotMovement]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
			if (_nobjs isNotEqualTo []) then {
				_rescued2 = true;
				__TRACE("rescued2")
				deleteVehicle _pilot2;
				// todo announce
			};
		} else {
			_is_dead2 = true;
		};
	};

	sleep 5.621;
	
};

if (_is_dead_all) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSideEvacFail",d_kbtel_chan];
} else {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSideEvacSucceed",d_kbtel_chan];
};

sleep 5.432;

{
	if (!isNull _x) then {
		if (!isNull objectParent _x) then {
			(objectParent _x) deleteVehicleCrew _x;
		} else {
			deleteVehicle _x;
		};
	};
} forEach [_pilot1, _pilot2];

deleteVehicle _trigger;
deleteMarker _marker; 

//this mission only has a few objects, prefer to leave them until the maintarget is complete
//it looks bad when the crashed helicopter is suddenly deleted during cleanup
waitUntil {sleep 10; d_mt_done};

//cleanup
_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
