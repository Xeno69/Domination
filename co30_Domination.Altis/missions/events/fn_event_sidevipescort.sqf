// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

// When triggered a friendly pilot will be spawned in a building in the maintarget.
// When players reach the area that pilot will become a priority target.
// All moving enemies will move and attack that specific unit until dead or "rescued."
// Players must move the pilot to a rescue location (_target_center) to win the event.

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _wait_time = 90;
private _joined = false;
private _check_player_nearby = {
	// check if player is close enough to "rescue" the pilot
	private _nobjs = (_pilot1 nearEntities ["CAManBase", 7]) select {alive _x && {isPlayer _x && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
	if (_nobjs isNotEqualTo []) exitWith {
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventVIPEscort",d_kbtel_chan];
        _pilot1 setUnconscious false;
		_pilot1 setCaptive false;
        _pilot1 enableAI "PATH";
        _pilot1 enableAI "RADIOPROTOCOL";
        _pilot1 forceSpeed -1;
        sleep 1;
		[_pilot1] join (group (_nobjs # 0));
		// players have the VIP, now the attack begins
        d_priority_targets pushBack _pilot1;
        publicVariable "d_priority_targets";
        _joined = true;
	};
};

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];
 
//position the event site at max distance 85% of target radius and min 40% of target radius
private _poss = [[[_target_center, (d_cur_target_radius * 0.85)]],[[_target_center, (d_cur_target_radius * 0.40)]]] call BIS_fnc_randomPos;
private _trigger = [_poss, [100,100,0,false,10], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start_time', time];",""]] call d_fnc_CreateTriggerLocal;

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
_buildings_array_sorted_by_distance = [[_poss, 200] call d_fnc_getbldgswithpositions, _poss] call d_fnc_sortarraybydistance;
private _unitsNotGarrisoned = [];
private _bldg = nil;
private _marker = nil;

{
	_unitsNotGarrisoned = [getPos _x, _allActors, 199, false, false, false, false, 2, true, true, true] call d_fnc_Zen_OccupyHouse; // dry run
	if (count _unitsNotGarrisoned == 0) exitWith {
		// building is suitable
		_bldg = _x;
		[getPos _x, _allActors, 199, false, false, false, false, 2, true, true] call d_fnc_Zen_OccupyHouse;
	};

} forEach _buildings_array_sorted_by_distance;

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_MARKEDFORDEATH_ESCORT", name _pilot1];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

if (!isNil "_bldg") then {
	_marker = ["d_mt_event_marker_sidevipescort", getPos _pilot1, "ICON","ColorBlack", [1, 1], name _pilot1, 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
    [_marker, "STR_DOM_MISSIONSTRING_DEFEND"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
};

{
	diag_log [format ["fn_event_sidevipescort: failed to garrison and will remain in starting position: %1", _x]];
} forEach _unitsNotGarrisoned;

_event_target_name = name _pilot1;
private _all_dead = false;

[_pilot1, 19] call d_fnc_setekmode;

diag_log [format["vipescort begins start time: %1 _event_target_name: %2", _event_start_time, _event_target_name]];
d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"PlayerMarkedForDeathEscort",
	["1", "", _event_target_name, []],
	d_kbtel_chan
];

// wait for the players to arrive or for _wait_time then begin the attack
while {sleep 3.14; !d_mt_done; !_all_dead; !_joined} do {
	if !(alive _pilot1) exitWith {
		__TRACE("All dead exiting")
		_all_dead = true;
	};
	if ((time - _event_start_time) > _wait_time) exitWith {
		// waited long enough, now the attack begins
        d_priority_targets pushBack _pilot1;
        publicVariable "d_priority_targets";
	};
	[] call _check_player_nearby;
};


while {sleep 3.14; !d_mt_done; !_all_dead} do {
	if !(alive _pilot1) exitWith {
		__TRACE("All dead exiting")
		_all_dead = true;
	};
	if !(_joined) then {
		[] call _check_player_nearby;
	};
	// detect if near rescue location (23m)
	if (_pilot1 distance _target_center < 23) exitWith {
		// success
	};
};

diag_log ["vipescort ended"];

sleep 5;

if (_all_dead) then {
	diag_log ["vipescort failure"];
	private _fail_survive_time = time - _event_start_time;
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"PlayerMarkedForDeathFailEscort",
    	["1", "", _event_target_name, []],
    	d_kbtel_chan
    ];
} else {
	diag_log ["vipescort success"];
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"PlayerMarkedForDeathSucceedEscort",
		["1", "", _event_target_name, []],
		["2", "", str _event_succeed_points, []],
		d_kbtel_chan
	];
	{
		_x addScore _event_succeed_points;
	} forEach ((allPlayers - entities "HeadlessClient_F") select {!(_x isKindOf "VirtualMan_F")});
};

// cleanup
if (_pilot1 in d_priority_targets) then {
	d_priority_targets deleteAt (d_priority_targets find _pilot1);
	publicVariable "d_priority_targets";
};
deleteVehicle [_pilot1, _trigger];
deleteMarker _marker;
d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
