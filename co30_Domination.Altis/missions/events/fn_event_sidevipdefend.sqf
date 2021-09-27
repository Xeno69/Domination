// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

// When triggered an unconscious friendly pilot will be spawned in a building in the maintarget.
// When players reach the area that pilot will become a priority target.
// All moving enemies will move and attack that specific unit until dead.
// Players must protect the pilot long enough to win the event.

// TODO - bug, sometimes the pilot is spawned in an exposed area and is impossible to defend

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];
 
//position the event site at max distance 85% of target radius and min 40% of target radius
private _poss = [[[_target_center, (d_cur_target_radius * 0.85)]],[[_target_center, (d_cur_target_radius * 0.40)]]] call BIS_fnc_randomPos;
private _trigger = [_poss, [65,65,0,false,10], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start_time', time];",""]] call d_fnc_CreateTriggerLocal;

private _event_start_time = nil;
private _event_target_name = nil;
private _event_survive_time = 180; // in seconds
private _event_succeed_points = 5;

waitUntil {sleep 5;!isNil {_trigger getVariable "d_event_start_time"}};
_event_start_time = _trigger getVariable "d_event_start_time";

private _allActors = [];

// select a starting point, units will be moved later to occupy a building if possible
private _nposss = _poss findEmptyPosition [0, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};

private _rescueGroup = [d_own_side] call d_fnc_creategroup;

// create pilot1
private _pilot1 = _rescueGroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
_allActors pushBack _pilot1;
[_pilot1, 75] call d_fnc_nodamoffdyn;
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
(leader _rescueGroup) setSkill 1;
_rescueGroup allowFleeing 0;
_rescueGroup deleteGroupWhenEmpty true;


if (d_with_dynsim == 0) then {
	[_rescueGroup] spawn d_fnc_enabledynsim;
};

sleep 2.333;

//find a suitable building and occupy
_buildings_array_sorted_by_distance = [[_poss, 200, nil, (count _allActors)] call d_fnc_getbuildings, _poss] call d_fnc_sortarraybydistance;
private _unitsNotGarrisoned = [];
private _bldg = nil;
private _marker = nil;

{
	_unitsNotGarrisoned = [getPos _x, _allActors, -1, false, false, true, false, 2, true, true, true] call d_fnc_Zen_OccupyHouse; // dry run
	if (count _unitsNotGarrisoned == 0) exitWith {
		// building is suitable
		_bldg = _x;
		[getPos _x, _allActors, -1, false, false, true, false, 2, true, true] call d_fnc_Zen_OccupyHouse;
	};

} forEach _buildings_array_sorted_by_distance;

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_MARKEDFORDEATH", name _pilot1, _event_survive_time];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

if (!isNil "_bldg") then {
	_marker = ["d_mt_event_marker_sidevipdefend", getPos _pilot1, "ICON","ColorBlack", [1, 1], _eventDescription, 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
    [_marker, "STR_DOM_MISSIONSTRING_DEFEND"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
};

{
	diag_log [format ["fn_event_sidevipdefend: failed to garrison and will remain in starting position: %1", _x]];
} forEach _unitsNotGarrisoned;

// pilot cannot move for the entire event
_pilot1 setUnconscious true;

_event_target_name = name _pilot1;

[_pilot1, 20] call d_fnc_setekmode;

diag_log [format["vipdefend begins start time: %1 _event_target_name: %2", _event_start_time, _event_target_name]];
d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"PlayerMarkedForDeath",
	["1", "", _event_target_name, []],
	["2", "", str _event_survive_time, []],
	d_kbtel_chan
];

// actually don't immediately target the pilot, allow the players 30 seconds to set up a defense
sleep 30;

// now the attack begins
d_priority_targets pushBack _pilot1;
publicVariable "d_priority_targets";

// waitUntil either killed EH or _event_survive_time duration
waitUntil {sleep 3;d_priority_targets isEqualTo [] || {(time - _event_start_time) > _event_survive_time}};

diag_log ["vipdefend ended"];

sleep 5;

if (d_priority_targets isEqualTo []) then {
	diag_log ["vipdefend failure"];
	private _fail_survive_time = time - _event_start_time;
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"PlayerMarkedForDeathFail",
    	["1", "", _event_target_name, []],
    	["2", "", str _fail_survive_time, []],
    	d_kbtel_chan
    ];
} else {
	diag_log ["vipdefend success"];
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"PlayerMarkedForDeathSucceed",
		["1", "", _event_target_name, []],
		["2", "", str _event_survive_time, []],
		["3", "", str _event_succeed_points, []],
		d_kbtel_chan
	];
	{
		_x addScore _event_succeed_points;
	} forEach d_allplayers;
	// reset 
	d_priority_targets deleteAt 0;
	publicVariable "d_priority_targets";
};

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

// cleanup
deleteVehicle _trigger;
deleteMarker _marker; 