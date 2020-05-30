// by Xeno (modified by Longtime)
//#define __DEBUG__
#define THIS_FILE "fn_sideevac_event.sqf"
#include "..\..\x_setup.sqf"

params ["_target_radius", "_target_center"];

// Shot down chopper as an event - no timer.
// Random crash site location, pilots are teleported to a nearby building and ordered posture down.
// The pilots are vulnerable to damage after 30 seconds.

if !(isServer) exitWith {};

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

//position the crash site near target center at max distance 250m and min 150m 
d_x_mt_event_pos = [[[_target_center, 250]],[[_target_center, 150]]] call BIS_fnc_randomPos;
d_x_mt_event_ar = [];

publicVariable "d_x_mt_event_pos";
private _poss = d_x_mt_event_pos;
d_x_mt_event_start = "";
private _trigger = [_poss, [225,225,0,false], [d_own_side,"PRESENT",true], ["this","d_x_mt_event_start = time",""]] call d_fnc_CreateTrigger;
publicVariable "d_x_mt_event_start";

waitUntil { !(d_x_mt_event_start isEqualTo "") };

private _wreck = createVehicle [d_sm_wrecktype, _poss, [], 0, "NONE"];
_wreck setDir (random 360);
_wreck setPos _poss;
_wreck lock true;
d_x_mt_event_ar pushBack _wreck;

private _distanceToEnablePilotMovement = 3; //in meters

sleep 2;

private _marker = ["d_mt_event_marker", _poss, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_538", 0, "hd_start"] call d_fnc_CreateMarkerGlobal;

[localize "STR_DOM_MISSIONSTRING_1803_NO_TIMER", "SIDE"] call d_fnc_HintChatMsg;

private _owngroup = [d_side_player] call d_fnc_creategroup;
if (d_with_ai) then {
	_owngroup setVariable ["d_do_not_delete", true];
};
__TRACE_1("","_owngroup")
private _nposss = [];
_nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};
private _pilot1 = _owngroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
d_x_mt_event_ar pushBack _pilot1;
[_pilot1, 30] call d_fnc_nodamoffdyn;
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

private _pilot2 = _owngroup createUnit [d_sm_pilottype, getPos _pilot1, [], 0, "NONE"];
d_x_mt_event_ar pushBack _pilot2;
[_pilot2, 30] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot2")
_pilot2 call d_fnc_removenvgoggles_fak;
[_pilot2, getPos _pilot2] call d_fnc_setposagls;
[_pilot1, _pilot2] joinSilent _owngroup;
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
_owngroup setCombatMode "BLUE";

sleep 3.14;

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
private _resctimestarted = time;

private _pcheck_fnc = {
	params ["_u", "_p"];
	{
		private _ogroup = group _x;
		_ogroup setCombatMode "YELLOW";
		_x setUnitPos "AUTO";
		_x enableAI "PATH";
		_x forceSpeed -1;
		[_x] join _p;
		deleteGroup _ogroup;
		doStop _x;
	} forEach _u;
};

while {!_pilots_at_base && {!_is_dead && {!d_mt_event_resolved}}} do {

	//if maintarget is done then just exit the while loop and proceed to cleanup
	if (d_mt_done) exitWith {
		d_mt_event_resolved = true;
		publicVariable "d_mt_event_resolved";
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
					};
				};
			};
		} else {
			if (_pilot1 distance2D d_FLAG_BASE < 50 || {_pilot2 distance2D d_FLAG_BASE < 50}) exitWith {_pilots_at_base = true};
			if (!isNil "d_flag_airfield" && {_pilot1 distance2D d_flag_airfield < 50 || {_pilot2 distance2D d_flag_airfield < 50}}) exitWith {_pilots_at_base = true};
			if (alive _pilot1 && {!(leader (group _pilot1) call d_fnc_isplayer)} || {alive _pilot2 && {!(leader (group _pilot2) call d_fnc_isplayer)}}) then {
				_rescued = false;
			};
		};
	};

	sleep 5.621;
	
};

if (_pilots_at_base) then {
	[localize "STR_DOM_MISSIONSTRING_812", "SIDE"] call d_fnc_HintChatMsg;
} else {
	[localize "STR_DOM_MISSIONSTRING_722", "SIDE"] call d_fnc_HintChatMsg;
};

d_mt_event_resolved = true;

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

sleep 0.5;

//cleanup
{
	if !(isNull _x) then {
		if (_x isKindOf "House") then {
			_x setDamage 0;
			deleteVehicle _x;
		} else {
			if (_x isKindOf "LandVehicle" && {!((crew _x) isEqualTo [])}) then {
				if ({(_x call d_fnc_isplayer) && {alive _x}} count (crew _x) == 0) then {
					_x call d_fnc_DelVecAndCrew;
				};
			} else {
				deleteVehicle _x;
			};
		};
	};
} forEach d_x_mt_event_ar;
d_x_mt_event_ar = [];

deleteVehicle _trigger;
deleteMarker _marker; 
