// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_event_sidekilltriggerman.sqf"
#include "..\..\x_setup.sqf"

// When triggered an enemy is spawned and designated as the "trigger man" and a friendly pilot is the target to explode.
// Players must kill the trigger man within X seconds to win the mission.

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _event_name = "KILL_TRIGGERMAN";
private _mt_event_key = format ["d_X_MTEVENT_%1_%2", d_cur_tgt_name, _event_name];

diag_log [format ["start event: %1", _mt_event_key]];

//position the event site at max distance 65% of target radius and min 25% of target radius
private _poss = [[[_target_center, (d_cur_target_radius * 0.65)]],[[_target_center, (d_cur_target_radius * 0.25)]]] call BIS_fnc_randomPos;
private _x_mt_event_ar = [];

//find a suitable building
_buildings_array_sorted_by_distance = [[_poss, 200] call d_fnc_getbldgswithpositions, _poss] call d_fnc_sortarraybydistance;
private _unitsNotGarrisoned = [];
private _bldg = nil;
private _marker = nil;

// create a temporary unit to help find a suitable building
private _tempgroup = [d_own_side] call d_fnc_creategroup;
private _tempunit = _tempgroup createUnit [d_sm_pilottype, [0,0,0], [], 0, "NONE"];

{
	_unitsNotGarrisoned = [getPos _x, [_tempunit], 199, false, false, false, false, 2, true, true, true] call d_fnc_Zen_OccupyHouse; // dry run
	if (count _unitsNotGarrisoned == 0) exitWith {
		// building is suitable
		_bldg = _x;
	};
} forEach _buildings_array_sorted_by_distance;

// delete temporary unit
_tempgroup deleteGroupWhenEmpty true;
deleteVehicle _tempunit;

if (isNil "_bldg") exitWith {
	diag_log ["killtriggerman - No suitable building found, event skipped"];
};

// only trigger the event when players are within 125x125 area of the building
private _trigger = [getPos _bldg, [125,125,0,false,30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

// event begins
private _distance_to_rescue = 3.5; // meters
private _defuse_time_limit = 120; // seconds
private _event_succeed_points = 5;

private _allActors = [];

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_1805_TRIGGERMAN", _defuse_time_limit];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSidePrisonersTriggerman",
	["1", "", str _defuse_time_limit, []],
	d_kbtel_chan
];

private _prisonerGroup = [d_own_side] call d_fnc_creategroup;

__TRACE_1("","_prisonerGroup")
private _pos = (getPos _bldg) findEmptyPosition [0, 99, d_sm_pilottype];
if (_pos isEqualTo []) then { _pos = _poss };

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

// create 1 enemy with unusual hat/bandanna to help players identify them
private _hat_type = selectRandom ["H_Cap_red", "H_Shemag_olive_hs", "H_Bandanna_surfer"];
private _enemyGuardGroup = (["specops", 0, "allmen", 1, getPos _bldg , 5, false, true, 1] call d_fnc_CreateInf) # 0;
{
	[_x, 5] call d_fnc_nodamoffdyn;
	_x forceSpeed 0;
	_x unlinkItem (hmd _x); //remove nvgs
	removeHeadgear _x;
	_x addHeadgear _hat_type;
	_x removeWeapon (secondaryWeapon _x); //remove launcher
	removeBackpack _x;
	_allActors pushBack _x;
	_x_mt_event_ar pushBack _x;
} forEach (units _enemyGuardGroup);

private _triggerman = leader _enemyGuardGroup;

_unitsNotGarrisoned = [getPos _bldg, _allActors, 199, false, false, false, false, 2, true, true] call d_fnc_Zen_OccupyHouse;

{
	// log if garrison function fails
	diag_log [format ["fn_event_killtriggerman: failed to garrison and will remain in starting position: %1", _x]];
} forEach _unitsNotGarrisoned;

_marker = ["d_mt_event_marker_killtriggerman", getPos _bldg, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_PRISONERSANDEXPLOSIVES_TRIGGERMAN", 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_PRISONERSANDEXPLOSIVES_TRIGGERMAN"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

private _all_dead = false;
private _success = false;
private _start_fuse = time;
private _warning_given = false;

while {sleep 3.14; !d_mt_done; !_all_dead} do {
	private _elapsed_time = (time - _start_fuse);
	if (!alive _triggerman) exitWith {
		_all_dead = true;
		_success = true;
	};
	// check if 30 second warning
	if ((_defuse_time_limit - _elapsed_time) < 30 && {!_warning_given}) then {
		d_kb_logic1 kbTell [
			d_kb_logic2,
			d_kb_topic_side,
			"EventWarningTime",
			["1", "", "30", []],
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

if (!_success) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersFail",d_kbtel_chan];
} else {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventDetonateSuccess",d_kbtel_chan];
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersSucceed",d_kbtel_chan];
	diag_log ["killtriggerman success"];
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"EventSucceed",
		["1", "", str _event_succeed_points, []],
		d_kbtel_chan
	];
	sleep 1;
	deleteVehicle _pilot1;
	{
		_x addScore _event_succeed_points;
	} forEach ((allPlayers - entities "HeadlessClient_F") select {!(_x isKindOf "VirtualMan_F")});
};

deleteVehicle _trigger;
deleteMarker _marker;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

if (d_ai_persistent_corpses == 0) then {
	waitUntil {sleep 10; d_mt_done};
} else {
	sleep 120;
};

// cleanup
diag_log [format ["cleanup of event: %1", _mt_event_key]];
_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;
