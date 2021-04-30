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

//position the event site near target center at max distance 125m and min 50m 
private _poss = [[[_target_center, 125]],[[_target_center, 50]]] call BIS_fnc_randomPos;
private _trigger = [_poss, [75,75,0,false,10], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start_time', time];",""]] call d_fnc_CreateTriggerLocal;

private _event_start_time = nil;
private _event_target_name = nil;
private _event_survive_time = 180; // in seconds
private _event_succeed_points = 0; // haha maybe someday

waitUntil {sleep 5;!isNil {_trigger getVariable "d_event_start_time"}};
_event_start_time = _trigger getVariable "d_event_start_time";

private _allActors = [];

// select a starting point, units will be moved later to occupy a building if possible
private _nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
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
	_unitsNotGarrisoned = [getPos _x, _allActors, -1, false, false, true, false, 2, true, true, true] call d_fnc_Zen_OccupyHouse;
	if (count _unitsNotGarrisoned == 0) exitWith {
		// building is suitable
		_bldg = _x;
		_unitsNotGarrisoned = [getPos _x, _allActors, -1, false, false, true, false, 2, true, true] call d_fnc_Zen_OccupyHouse;
	};

} forEach _buildings_array_sorted_by_distance;

if (!isNil "_bldg") then {
	_marker = ["d_mt_event_marker_sidevipdefend", getPos _bldg, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_DEFEND", 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
    [_marker, "STR_DOM_MISSIONSTRING_DEFEND"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
};

{
	diag_log [format ["fn_event_sidevipdefend: failed to garrison and will remain in starting position: %1", _x]];
} forEach _unitsNotGarrisoned;

// pilot cannot move for the entire event
_pilot1 setUnconscious true;

_event_target_name = name _pilot1;

_pilot1 addEventHandler ["Killed", {
	// reset
	d_priority_target = nil;
	publicVariable "d_priority_target";
}];

diag_log [format["vipdefend begins start time: %1 _event_target_name: %2", _event_start_time, _event_target_name]];
d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"PlayerMarkedForDeath",
	["1", "", _event_target_name, []],
	["2", "", str _event_survive_time, []],
	d_kbtel_chan
];

// actually don't immediately target the pilot, allow the players 60 seconds to set up a defense
sleep 60;

// now the attack begins
d_priority_target = _pilot1;
publicVariable "d_priority_target";

// waitUntil either killed EH or _event_survive_time duration
waitUntil {sleep 3;isNil "d_priority_target" || {(time - _event_start_time) > _event_survive_time}};

diag_log ["markedfordeath ended"];

sleep 5;

if (isNil "d_priority_target") then {
	diag_log ["markedfordeath failure"];
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"PlayerMarkedForDeathFail",
    	["1", "", _event_target_name, []],
    	["2", "", str (time - _event_start_time), []],
    	d_kbtel_chan
    ];
} else {
	diag_log ["markedfordeath success"];
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"PlayerMarkedForDeathSucceed",
		["1", "", _event_target_name, []],
		["2", "", str _event_survive_time, []],
		["3", "", str _event_succeed_points, []],
		d_kbtel_chan
	];
	// reset 
	d_priority_target = nil;
	publicVariable "d_priority_target";
};

// cleanup
deleteVehicle _trigger;
deleteMarker _marker; 