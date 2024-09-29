// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Guerilla infantry spawn in a location near the maintarget and then move into the center of maintarget with a Search and Destroy waypoint
// This may run concurrently with fn_event_enemy_incoming

if !(isServer) exitWith {};

params ["_target_radius", "_target_center", ["_spawn_pos", []], ["_with_vehicles", false], ["_target_group_count_multiplier", 1]];

private _event_name = "GUERRILLA_INFANTRY";
private _mt_event_key = format ["d_X_MTEVENT_%1_%2", d_cur_tgt_name, _event_name];

diag_log [format ["start event: %1", _mt_event_key]];

private _townNearbyName = "";
private _townNearbyPos = [];
private _minimumDistanceFromMaintarget = 250;
private _maximumDistanceFromMaintarget = 300;
private _marker = nil;

private _towns = nearestLocations [_target_center, ["NameCityCapital", "NameCity", "NameVillage"], 10000];

// find a town outside the minimum distance
{
	if (_target_center distance2D getPos _x > _minimumDistanceFromMaintarget) exitWith {
		_townNearbyPos = getPos _x;
		_townNearbyName = text _x;
	};
} forEach _towns;

if (_townNearbyPos isEqualTo []) then {
	diag_log ["choosing a random position to start, unable to find a nearby town location to spawn infantry for guerrilla mission event", d_cur_tgt_name];
	_townNearbyPos = [[[_target_center, _maximumDistanceFromMaintarget]],[[_target_center, _minimumDistanceFromMaintarget],["water"]]] call BIS_fnc_randomPos;
	_townNearbyName = "nearby";
};

private _x_mt_event_ar = [];

private _trigger = [_target_center, [d_cur_target_radius,d_cur_target_radius,0,false,30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

if (d_preemptive_special_event) then {
	_townNearbyName = "nearby";
} else {
	waitUntil {sleep 1; !isNil {_trigger getVariable "d_event_start"}};
};

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028_INFANTRY", _townNearbyName];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSideGuerrInfantry",
	["1", "", _townNearbyName, []],
	d_kbtel_chan
];

private _newgroups_inf = [];
private _newgroups_veh = [];

if (_spawn_pos isEqualTo []) then {
	// spawn position was not provided, calculate the spawn position using _townNearbyPos  
	_spawn_pos = _townNearbyPos;
	
	if (_target_center distance2D _spawn_pos > _maximumDistanceFromMaintarget) then {
		// try to find a midpoint between chosen location and maintarget, too far for infantry to walk from location to location
		private _midpoint_pos = [
			((_target_center # 0) + (_townNearbyPos # 0))/2,
			((_target_center # 1) + (_townNearbyPos # 1))/2
		];
		if ((_midpoint_pos distance2D _target_center) > _maximumDistanceFromMaintarget || {(_midpoint_pos distance2D _target_center) < _minimumDistanceFromMaintarget}) then {
			// midpoint is too far or too close, give up looking for nearby towns and just choose a random position in the desired range
			_spawn_pos = [[[_target_center, _maximumDistanceFromMaintarget]],[[_target_center, _minimumDistanceFromMaintarget],["water"]]] call BIS_fnc_randomPos;
		} else {
			_spawn_pos = _midpoint_pos;
		};
	};
};

while {surfaceIsWater _spawn_pos} do {
	_spawn_pos = _spawn_pos getPos [20, _spawn_pos getDir _target_center];
	sleep 0.01;
};

if (_with_vehicles) then {
	private _incoming_vehs = [];
	
	if (d_WithLessArmor == 0 || d_WithLessArmor == 3) then {
		// "normal" or random which we force to normal
		_incoming_vehs = [
			selectRandom (d_faction_independent_array select 1),
			selectRandom (d_faction_independent_array select 1)
		];
	};
	
	if (d_WithLessArmor == 1) then {
		// "less"
		_incoming_vehs = [
			selectRandom (d_faction_independent_array select 1)
		];
	};
	
	if (d_WithLessArmor == 4) then {
		// "high"
		_incoming_vehs = [
			selectRandom (d_faction_independent_array select 1),
			selectRandom (d_faction_independent_array select 1),
			selectRandom (d_faction_independent_array select 1)
		];
	};
	
	private _vdir = _spawn_pos getDir _target_center;
    {
    	//private _vehicle_list = [_x, "G"] call d_fnc_getunitlistv;
    	private _vname = _x;
    	private _newgroup = [independent] call d_fnc_creategroup;
    	private _rand_pos = [[[_spawn_pos, 150]],["water"]] call BIS_fnc_randomPos;
		private _road_list = _rand_pos nearroads 30;
		private _spawn_pos_foreach = [];
		if (!(_road_list isEqualTo [])) then {
			_spawn_pos_foreach = getPosASL (selectRandom _road_list);
		} else {
			_spawn_pos_foreach = _rand_pos;
		};
    	private _vecs_and_crews = [1, _spawn_pos_foreach, _vname, _newgroup, _vdir, true, true, true] call d_fnc_makevgroup;
    	_newgroups_veh pushBack _newgroup;
    	if (d_with_dynsim == 0) then {
    		[_newgroup, 0] spawn d_fnc_enabledynsim;
    	};
    	_x_mt_event_ar append (_vecs_and_crews # 0); // vehicles
    	_x_mt_event_ar append (_vecs_and_crews # 1); // crews
    	d_delvecsmt append (_vecs_and_crews # 0);
		d_delinfsm append (_vecs_and_crews # 1);
		{
			_x setSkill ["courage", 1];
			_x setSkill ["commanding", 1];
		} forEach _vecs_and_crews # 1; // crews
    } forEach _incoming_vehs;
};

// calculate the sum of all groups of AI
private _targetGroupCount = ceil ((d_occ_cnt_current + d_ovrw_cnt_current + d_amb_cnt_current + d_grp_cnt_footpatrol) * _target_group_count_multiplier);

// guerrillas should be outnumbered
private _guerrillaGroupCount = round(_targetGroupCount / 3) min 3;
private _guerrillaForce = [];
for "_i" from 0 to _guerrillaGroupCount do {
	_guerrillaForce pushBack "allmen";
};

private _guerrillaBaseSkill = 0.85;

{
	private _unitlist = [_x, "G"] call d_fnc_getunitlistm;
	if !(d_faction_independent_array isEqualTo []) then {
		_unitlist = selectRandom (d_faction_independent_array select 0);
	};
	private _newgroup = [independent] call d_fnc_creategroup;
	private _rand_pos = [[[_spawn_pos, 100]],["water"]] call BIS_fnc_randomPos;
	private _units = [_rand_pos, _unitlist, _newgroup, false, true, 5, true] call d_fnc_makemgroup;
	{
		_x setSkill _guerrillaBaseSkill;
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		_x_mt_event_ar pushBack _x;
		_x addEventHandler ["handleHeal", {call d_fnc_handleheal}];
	} forEach _units;
	_newgroups_inf pushBack _newgroup;
	d_delinfsm append _units;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _guerrillaForce;

_marker = ["d_mt_event_marker_guerrillainfantry", _spawn_pos, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_GUERRILLAS", 0, "mil_start"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_GUERRILLAS"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

if (d_preemptive_special_event) then {
	sleep 45;
};

// infantry go first
{
	// each group moves toward a random waypoint near the target center
	_wp_pos = [[[_target_center, (d_cur_target_radius * 0.2)]],["water"]] call BIS_fnc_randomPos;
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "CARELESS";
	_wp = _x addWaypoint[_wp_pos, 0];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "STAG COLUMN";
} forEach _newgroups_inf;

sleep 120;

// vehicles go second
{
	// each group moves toward a random waypoint near the target center
	_wp_pos = [[[_target_center, (d_cur_target_radius * 0.2)]],["water"]] call BIS_fnc_randomPos;
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "CARELESS";
	_wp = _x addWaypoint[_wp_pos, 0];
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "VEE";
} forEach _newgroups_veh;

sleep 2.333;

if (!isNil "d_event_trigger_tanks_guerr") then {
	d_event_trigger_tanks_guerr setVariable ["d_event_start", true, true];
};

private _all_dead = false;
while {sleep 1; !d_mt_done && {!_all_dead}} do {
	private _foundAlive = _newgroups_inf findIf {(units _x) findIf {alive _x} > -1} > -1 ||
		_newgroups_veh findIf {(units _x) findIf {alive _x} > -1} > -1;
	_all_dead = !_foundAlive;
};

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

waitUntil {sleep 1; d_mt_radio_down && {d_mt_done}};

// cleanup
diag_log [format ["cleanup of event: %1", _mt_event_key]];
deleteVehicle _trigger;
deleteMarker _marker;
