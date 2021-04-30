// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_event_sideprisonerdefuse.sqf"
#include "..\..\x_setup.sqf"

// When players are nearby spawn a friendly captive unit.
// To win the event players must reach the unit before the time limit expires.
// A bomb will detonate and kill the unit if players do not arrive in time.
// TODO - maybe a smoke grenade to mark the location? 

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

//private _mt_event_key = format ["d_X_MTEVENT_PRISONERDEFUSE_%1", d_cur_tgt_name];

//position the event site near target center at max distance 150m and min 35m, find a building position later
private _poss = [[[_target_center, 150]],[[_target_center, 35]]] call BIS_fnc_randomPos;
private _x_mt_event_ar = [];

//find a suitable building and occupy
_buildings_array_sorted_by_distance = [[_poss, 200, nil, 1] call d_fnc_getbuildings, _poss] call d_fnc_sortarraybydistance;
private _unitsNotGarrisoned = [];
private _bldg = nil;
private _marker = nil;

// create a temporary unit to help find a suitable building
private _tempgroup = [d_own_side] call d_fnc_creategroup;
private _tempunit = _tempgroup createUnit [d_sm_pilottype, [0,0,0], [], 0, "NONE"];

{
	_unitsNotGarrisoned = [getPos _x, [_tempunit], -1, false, false, true, false, 2, true, true, true] call d_fnc_Zen_OccupyHouse;
	if (count _unitsNotGarrisoned == 0) exitWith {
		// building is suitable
		_bldg = _x;
	};
} forEach _buildings_array_sorted_by_distance;

// delete temporary unit
_tempgroup deleteGroupWhenEmpty true;
deleteVehicle _tempunit;

if (isNil "_bldg") exitWith {
	diag_log ["sideprisonerdefuse - No suitable building found, event skipped"];
};

// only trigger the event when players are within 130x130 area of the captive pilot
private _trigger = [getPos _bldg, [130,130,0,false,30], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

// event begins
private _distance_to_rescue = 1.5; // meters
private _defuse_time_limit = 150; // seconds
private _event_succeed_points = 0; // haha maybe someday

private _allActors = [];

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_1805_DEFUSE", _defuse_time_limit];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"MTEventSidePrisonersDefuse",
		["1", "", str _defuse_time_limit, []],
		d_kbtel_chan
	];

private _prisonerGroup = [d_own_side] call d_fnc_creategroup;

__TRACE_1("","_prisonerGroup")
private _pos = (getPos _bldg) findEmptyPosition [10, 25, d_sm_pilottype];
if (_pos isEqualTo []) then { _pos = getPos _bldg };

// create pilot1
private _pilot1 = _prisonerGroup createUnit [d_sm_pilottype, _pos, [], 0, "NONE"];
_x_mt_event_ar pushBack _pilot1;
_allActors pushBack _pilot1;
[_pilot1, 15] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;
removeHeadgear _pilot1;
_pilot1 unlinkItem (hmd _pilot1); //remove nvgs
[_pilot1, getPos _pilot1] call d_fnc_setposagls;

removeAllWeapons _pilot1;
_pilot1 setCaptive true;
_pilot1 enableStamina false;
_pilot1 enableFatigue false;
_pilot1 disableAI "PATH";
_pilot1 disableAI "RADIOPROTOCOL";
_pilot1 forceSpeed 0;
(leader _prisonerGroup) setSkill 1;
_prisonerGroup allowFleeing 0;
_prisonerGroup deleteGroupWhenEmpty true;

if (d_with_dynsim == 0) then {
	[_prisonerGroup] spawn d_fnc_enabledynsim;
};

sleep 2.333;

_unitsNotGarrisoned = [getPos _bldg, _allActors, -1, false, false, true, false, 2, true, true] call d_fnc_Zen_OccupyHouse;

_pilot1 setUnitPos "MIDDLE";

_marker = ["d_mt_event_marker_sideprisonerdefuse", getPos _bldg, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_PRISONERSANDEXPLOSIVES_DEFUSE", 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_PRISONERSANDEXPLOSIVES_DEFUSE"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

{
	// log if garrison function fails
	diag_log [format ["fn_event_sideprisoners: failed to garrison and will remain in starting position: %1", _x]];
} forEach _unitsNotGarrisoned;

private _all_dead = false;
private _is_rescued = false;
private _start_fuse = time;
private _warning_given = false;

while {sleep 3.14; !d_mt_done; !_is_rescued} do {
	private _elapsed_time = (time - _start_fuse);
	if (!alive _pilot1) exitWith { _all_dead = true };
	// check if player is close enough to "rescue" the pilot
	private _nobjs = (_pilot1 nearEntities ["CAManBase", _distance_to_rescue]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
	if (_nobjs isNotEqualTo []) exitWith {
		__TRACE("rescued _pilot1")
		_is_rescued = true;
		sleep 2;
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersDefuseNow",d_kbtel_chan];
		_pilot1 setDamage 0;
		sleep 5;
		deleteVehicle _pilot1;
	};
	// check if 45 second warning
	if ((_defuse_time_limit - _elapsed_time) < 45 && {!_warning_given}) then {
		d_kb_logic1 kbTell [
			d_kb_logic2,
			d_kb_topic_side,
			"EventWarningTime",
			["1", "", "45", []],
			d_kbtel_chan
		];
		_warning_given = true;
	};
	// check if detonation time has elapsed
	if (_elapsed_time > _defuse_time_limit) then {
		_all_dead = true;
		_bomb_type = "Rocket_04_HE_F";
		_bomb = _bomb_type createVehicle [0,0,5000];
		_bomb setPosASL eyePos _pilot1;
		// inform the players of the failure
		sleep 7;
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventDetonateFail",d_kbtel_chan];
	};
};

if (_all_dead) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersFail",d_kbtel_chan];
} else {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventDetonateSuccess",d_kbtel_chan];
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersSucceed",d_kbtel_chan];
	diag_log ["prisonerdefuse success"];
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"EventSucceed",
		["1", "", str _event_succeed_points, []],
		d_kbtel_chan
	];
};

deleteVehicle _trigger;
deleteMarker _marker;

if (d_ai_persistent_corpses == 0) then {
	waitUntil {sleep 10; d_mt_done};
} else {
	sleep 120;
};

//cleanup
_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
