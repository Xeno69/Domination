// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Defense only, enemies will spawn nearby and move into the city, no enemies will spawn in the maintarget
// This may run concurrently with fn_event_guerrila_infantry_incoming

if !(isServer) exitWith {};

params ["_target_radius", "_target_center", ["_target_group_count_multiplier", 1]];

private _event_name = "enemy_incoming";
private _mt_event_key = format ["d_X_MTEVENT_%1_%2", d_cur_tgt_name, _event_name];

diag_log [format ["start event: %1", _mt_event_key]];

private _townNearbyName = "";
private _townNearbyPos = [];
private _minimumDistanceFromMaintarget = 300;
private _maximumDistanceFromMaintarget = 400;

private _towns = nearestLocations [_target_center, ["NameCityCapital", "NameCity", "NameVillage"], 10000];

// find a town outside the minimum distance
{
	if (_target_center distance2D getPos _x > _minimumDistanceFromMaintarget) exitWith {
		_townNearbyPos = getPos _x;
		_townNearbyName = text _x;
	};
} forEach _towns;

private _spawn_pos = [];

if (_townNearbyPos isEqualTo []) then {
	diag_log ["unable to find a nearby town so will choose a random position"];
	_spawn_pos = [[[_target_center, _maximumDistanceFromMaintarget]],[[_target_center, _minimumDistanceFromMaintarget],["water"]]] call BIS_fnc_randomPos;
	_townNearbyName = "Unknown";
} else {
	_spawn_pos = _townNearbyPos;
};

private _x_mt_event_ar = [];

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028_ENEMY_ATTACK", d_cur_tgt_name];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSideEnemyAttack",
	["1", "", d_cur_tgt_name, []],
	d_kbtel_chan
];

if (_target_center distance2D _spawn_pos > _maximumDistanceFromMaintarget) then {
	// try to find a midpoint between chosen location and maintarget, too far for infantry to walk from location to location
	private _midpoint_pos = [
		((_target_center # 0) + (_spawn_pos # 0))/2,
		((_target_center # 1) + (_spawn_pos # 1))/2
	];
	if ((_midpoint_pos distance2D _target_center) > _maximumDistanceFromMaintarget || {(_midpoint_pos distance2D _target_center) < _minimumDistanceFromMaintarget}) then {
		// midpoint is too far or too close, give up looking for nearby towns and just choose a random position in the desired range
		_spawn_pos = [[[_target_center, _maximumDistanceFromMaintarget]],[[_target_center, _minimumDistanceFromMaintarget],["water"]]] call BIS_fnc_randomPos;
	} else {
		_spawn_pos = _midpoint_pos;
	};
};

d_preemptive_special_event_startpos_opfor = _spawn_pos;
publicVariable "d_preemptive_special_event_startpos_opfor";

// wait for the radiotower to be created
// if we don't wait then creating enemies may cause the maintarget to "start"
// if the maintarget "starts" without a radiotower then the server may incorrectly run target_clear (mt immediately turns all green)
waitUntil {sleep 1; !(d_mt_tower_pos isEqualTo [])};

diag_log ["radiotower exists, creating incoming enemy units now"];

sleep 7;

private _newgroups_inf = [];
private _newgroups_veh = [];
// calculate the sum of all groups of AI
private _targetGroupCount = ceil ((d_occ_cnt_current + d_ovrw_cnt_current + d_amb_cnt_current + d_grp_cnt_footpatrol) * _target_group_count_multiplier);
private _enemyForceInf = [];

for "_i" from 0 to _targetGroupCount do {
	_enemyForceInf pushBack "allmen";
};

private _incoming_vehs = [];

if (d_WithLessArmor == 0 || d_WithLessArmor == 3) then {
	// "normal" or random which we force to normal
	_incoming_vehs = ["jeep_mg", "wheeled_apc"];
};

if (d_WithLessArmor == 1) then {
	// "less"
	_incoming_vehs = ["jeep_mg", "jeep_mg"];
};

if (d_WithLessArmor == 4) then {
	// high
	_incoming_vehs = ["jeep_mg", "wheeled_apc", "tracked_apc"];
};

{
	private _unitlist = [_x, d_enemy_side_short] call d_fnc_getunitlistm;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _rand_pos = [[[_spawn_pos, 175]],["water"]] call BIS_fnc_randomPos;
	private _units = [_rand_pos, _unitlist, _newgroup, false, true] call d_fnc_makemgroup;
	{
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		_x_mt_event_ar pushBack _x;
	} forEach _units;
	_newgroups_inf pushBack _newgroup;
	d_delinfsm append _units;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _enemyForceInf;

private _vdir = _spawn_pos getDir _target_center;
{
	private _unitlist = [_x, d_enemy_side_short] call d_fnc_getunitlistv;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _rand_pos = [[[_spawn_pos, 35]],["water"]] call BIS_fnc_randomPos;
	private _road_list = _rand_pos nearroads 20;
	private _spawn_pos_foreach = [];
	if (!(_road_list isEqualTo [])) then {
		_spawn_pos_foreach = getPosASL (selectRandom _road_list);
	} else {
		_spawn_pos_foreach = _rand_pos;
	};
	private _vecs_and_crews = [1, _spawn_pos_foreach, _unitlist, _newgroup, _vdir, true, true, true] call d_fnc_makevgroup;
	{
		{
			_x setSkill ["courage", 1];
			_x setSkill ["commanding", 1];
		} forEach _vecs_and_crews # 1; // crews
	} forEach _vecs_and_crews;
	_x_mt_event_ar append (_vecs_and_crews # 0); // vehicles
	_x_mt_event_ar append (_vecs_and_crews # 1); // crews
	d_delvecsmt append (_vecs_and_crews # 0);
	d_delinfsm append (_vecs_and_crews # 1);
	_newgroups_veh pushBack _newgroup;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _incoming_vehs;

private _marker_enemy_spawn = ["d_mt_event_marker_enemyincoming", _spawn_pos, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_964", 0, "mil_start"] call d_fnc_CreateMarkerGlobal;
[_marker_enemy_spawn, "STR_DOM_MISSIONSTRING_964"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

sleep 30;

// infantry go first
{
	// each group moves toward a random position near the target center
	private _wp_pos = [];
	if (33 > random 100) then {
		// some enemy groups stay back from target center, near midpoint of enemy start and target center
		private _midpoint_pos = [
			((_target_center # 0) + (_spawn_pos # 0))/2,
			((_target_center # 1) + (_spawn_pos # 1))/2
		];
		_wp_pos = [[[_midpoint_pos, (d_cur_target_radius * 0.2)]],["water"]] call BIS_fnc_randomPos;
	} else {
		// near target center
		_wp_pos = [[[_target_center, (d_cur_target_radius * 0.2)]],["water"]] call BIS_fnc_randomPos;
	};
	//if (25 > random 100) then {
	if (false) then { // todo - fix non-teleport occupyhouse, skipping for now, many units are not moving at all
		// some units will garrison in a building near the random position (walk to the position, not teleported)
		private _unitsNotGarrisoned = [
        	_wp_pos,											// Params: 1. Array, the building(s) nearest this position is used
        	units _x,									//         2. Array of objects, the units that will garrison the building(s)
        	20,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
        	false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
        	false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
        	false,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
        	true,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
        	0,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
        	false, //true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead // todo - fix the roof check, currently disqualifies many top floor position when set to true
        	false,												//  (opt.) 10. _isAllowSpawnNearEnemy Boolean, true to allow the selected position to be near an enemy (default: false)
        	false,												//  (opt.) 11. _isDryRun Boolean, true to dry run, for testing only no units are moved, still returns array of units that could not be garrisoned at given pos (default: false)
        	-1 //,													//  (opt.) 12. _distanceFromBuildingCenter Scalar, distance a unit may be placed from the center of a building (usually safer) or -1 for any (default: -1)
//        	_targetBuilding //true                                       //  (opt.) 13. Object, target building may be passed
        ] call d_fnc_Zen_OccupyHouse;
		
	} else {
		// most units will walk directly to the waypoint
		_x setCombatMode "RED";
		_x setSpeedMode "FULL";
		_x setBehaviour "SAFE";
		_wp = _x addWaypoint[_wp_pos, 0];
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "FULL";
		_wp setwaypointtype "SAD";
		_wp setWaypointFormation "STAG COLUMN";
	};
} forEach _newgroups_inf;

sleep 120;

// vehicles go second
{
	// each group moves toward a random waypoint near the target center
	_wp_pos = [[[_target_center, (d_cur_target_radius * 0.4)]],["water"]] call BIS_fnc_randomPos;
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "SAFE";
	_wp = _x addWaypoint[_wp_pos, 0];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "STAG COLUMN";
} forEach _newgroups_veh;

waitUntil {sleep 1; d_mt_radio_down && {d_mt_done}};

// cleanup
diag_log [format ["cleanup of event: %1", _mt_event_key]];
d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

deleteMarker _marker_enemy_spawn;

d_preemptive_special_event = false;
publicVariable "d_preemptive_special_event";
d_preemptive_special_event_startpos_opfor = [];
publicVariable "d_preemptive_special_event_startpos_opfor";

