// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Protect an unconscious pilot somewhere in the maintarget, enemy spawned nearby will attack the pilot
// Defense only, no enemy will spawn in the maintarget

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _townNearbyName = "";
private _townNearbyPos = [];
private _minimumDistanceFromMaintarget = 325;
private _maximumDistanceFromMaintarget = 400;
private _marker = nil;

private _towns = nearestLocations [_target_center, ["NameCityCapital", "NameCity", "NameVillage"], 10000];

// find a town outside the minimum distance
{
	if (_target_center distance2D getPos _x > _minimumDistanceFromMaintarget) exitWith {
		_townNearbyPos = getPos _x;
		_townNearbyName = text _x;
	};
} forEach _towns;

if (_townNearbyPos isEqualTo []) exitWith {
	diag_log ["unable to find a location to spawn infantry for guerrilla mission event", d_cur_tgt_name];
};

private _x_mt_event_ar = [];

private _trigger = [_target_center, [d_cur_target_radius,d_cur_target_radius,0,false,30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028_INFANTRY", _townNearbyName];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSideEnemyAttack",
	["1", "", _townNearbyName, []],
	d_kbtel_chan
];

// TODO - wait or make the players move quickly?
//waitUntil {sleep 0.1; !isNil {_trigger getVariable "d_event_start"}};

private _spawn_pos = _townNearbyPos;

if (_target_center distance2D _townNearbyPos > _maximumDistanceFromMaintarget) then {
	// try to find a midpoint between chosen location and maintarget, too far for infantry to walk from location to location
	private _midpoint_pos = [
		((_target_center # 0) + (_townNearbyPos # 0))/2,
		((_target_center # 1) + (_townNearbyPos # 1))/2
	];
	if ((_midpoint_pos distance2D _target_center) > _minimumDistanceFromMaintarget) then {
		// if midpoint is not too close then use it instead of _townNearbyPos
		_spawn_pos = _midpoint_pos;
	};
};

d_preemptive_special_event_startpos = _spawn_pos;
publicVariable "d_preemptive_special_event_startpos";

private _newgroups = [];
// calculate the sum of all groups of AI already in the maintarget and size the enemy force accordingly
private _targetGroupCount = d_occ_cnt + d_ovrw_cnt + d_amb_cnt + d_snp_cnt;
// default guerrilla force
private _enemyForceInf = ["allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen"];
private _enemyForceVeh = ["jeep_mg"];
if (_targetGroupCount > 10) then {
	_enemyForceInf = ["allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen"];
	_enemyForceVeh = ["jeep_mg", "wheeled_apc"];
};
if (_targetGroupCount > 20) then {
	_enemyForceInf = ["allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen", "allmen"];
	_enemyForceVeh = ["jeep_mg", "wheeled_apc", "tracked_apc"];
};

{
	private _unitlist = [_x, d_enemy_side_short] call d_fnc_getunitlistm;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _units = [_spawn_pos, _unitlist, _newgroup, false, true] call d_fnc_makemgroup;
	{
		//_x setSkill _guerrillaBaseSkill;
		//_x setSkill ["spotTime", 0.6];
		//_x setSkill ["spotDistance", 0.6];
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		_x_mt_event_ar pushBack _x;
	} forEach _units;
	_newgroups pushBack _newgroup;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _enemyForceInf;

private _vdir = _target_center getDir _spawn_pos;
{
	private _unitlist = [_x, d_enemy_side_short] call d_fnc_getunitlistv;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _units = [1, _spawn_pos, _unitlist, _newgroup, _vdir, true, true, true] call d_fnc_makevgroup;
	_newgroups pushBack _newgroup;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _enemyForceVeh;

sleep 3.14;




/*
private _poss = [[[_target_center, (d_cur_target_radius * 0.85)]],[[_target_center, (d_cur_target_radius * 0.40)]]] call BIS_fnc_randomPos;
private _nposss = _poss findEmptyPosition [0, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};

private _rescueGroup = [d_own_side] call d_fnc_creategroup;

// create pilot1
private _pilot1 = _rescueGroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
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

// pilot cannot move for the entire event
_pilot1 setUnconscious true;

private _eventDescription = localize "STR_DOM_MISSIONSTRING_DEFEND";
_marker_def = ["d_mt_event_enemy_incoming", getPos _pilot1, "ICON","ColorBlack", [1, 1], _eventDescription, 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
[_marker_def, "STR_DOM_MISSIONSTRING_DEFEND"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

// actually don't immediately target the pilot, allow the players 90 seconds to set up a defense
//sleep 90;
sleep 10;

// now the attack begins
d_priority_targets pushBack _pilot1;
publicVariable "d_priority_targets";
*/




sleep 2.333;

{
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "CARELESS";
	_wp = _x addWaypoint[getPos _pilot1, 0];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "STAG COLUMN";
} forEach _newgroups;

_marker_enemy_spawn = ["d_mt_event_marker_enemyincoming", _spawn_pos, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_964", 0, "mil_start"] call d_fnc_CreateMarkerGlobal;
[_marker_enemy_spawn, "STR_DOM_MISSIONSTRING_964"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

private _event_start_time = time;
private _event_survive_time = 10*60; // 10 minutes
//private _failed = false;

//while {sleep 15; (time - _start_time) < _duration;} do {
	//private _foundAlive = _newgroups findIf {(units _x) findIf {alive _x} > -1} > -1;
	//if (!_foundAlive) exitWith {};
	// mission failed if enemies are within 25m of target center
	//if ({ side _x == d_side_enemy } count nearestObjects [_target_center, ["Man","Car","Tank"], 25] > 0) exitWith { _failed = true; };
//};

// waitUntil either killed EH or _event_survive_time duration
waitUntil {sleep 3;!(_pilot1 in d_priority_targets) || {(time - _event_start_time) > _event_survive_time}};

diag_log ["enemy_incoming ended"];

sleep 5;

//if (_failed) then {
if (!(_pilot1 in d_priority_targets)) then {	
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSideEnemyAttackFail",d_kbtel_chan];
} else {
	private _event_succeed_points = 20;
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"EventSucceed",
    	["1", "", str _event_succeed_points, []],
    	d_kbtel_chan
    ];
    {
    	_x addScore _event_succeed_points;
    } forEach (allPlayers - entities "HeadlessClient_F");
};

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

deleteVehicle _trigger;
deleteMarker _marker_def;
deleteMarker _marker_enemy_spawn;

d_preemptive_special_event = false;
publicVariable "d_preemptive_special_event";
d_preemptive_special_event_startpos = [];
publicVariable "d_preemptive_special_event_startpos";


if (d_ai_persistent_corpses == 0) then {
	waitUntil {sleep 10; d_mt_done};
} else {
	sleep 120;
};

//cleanup
//_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;
