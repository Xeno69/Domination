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

params ["_target_radius", "_target_center", ["_spawn_pos", []], ["_with_vehicles", false]];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

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

if (_townNearbyPos isEqualTo []) exitWith {
	diag_log ["unable to find a location to spawn infantry for guerrilla mission event", d_cur_tgt_name];
};

private _x_mt_event_ar = [];

private _trigger = [_target_center, [d_cur_target_radius,d_cur_target_radius,0,false,30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

if (!d_preemptive_special_event) then {
	waitUntil {sleep 0.1; !isNil {_trigger getVariable "d_event_start"}};
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

private _newgroups = [];

if (_spawn_pos isEqualTo []) then {
	// spawn position was not provided, calculate the spawn position using _townNearbyPos  
	_spawn_pos = _townNearbyPos;
	
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
};

while {surfaceIsWater _spawn_pos} do {
	_spawn_pos = _spawn_pos getPos [20, _spawn_pos getDir _target_center];
	sleep 0.01;
};

if (_with_vehicles) then {
	private _incoming_vehs = [];
	if (d_WithLessArmor == 0 || d_WithLessArmor == 3) then {
    	// "normal" or random which we force to normal
    	_incoming_vehs = ["jeep_mg", "wheeled_apc", "tracked_apc", "tank"];
    };
    
    if (d_WithLessArmor == 1) then {
    	// "less"
    	_incoming_vehs = ["jeep_mg", "wheeled_apc"];
    };
    
    if (d_WithLessArmor == 4) then {
    	// high
    	_incoming_vehs = ["wheeled_apc", "tracked_apc", "tracked_apc"];
    };
	private _vdir = _spawn_pos getDir _target_center;
    {
    	private _unitlist = [_x, "G"] call d_fnc_getunitlistv;
    	private _newgroup = [independent] call d_fnc_creategroup;
    	private _rand_pos = [[[_spawn_pos, 30]],["water"]] call BIS_fnc_randomPos;
		private _road_list = _rand_pos nearroads 30;
		private _spawn_pos_foreach = [];
		if (!(_road_list isEqualTo [])) then {
			_spawn_pos_foreach = getPosASL (selectRandom _road_list);
		} else {
			_spawn_pos_foreach = _rand_pos;
		};
    	private _vecs_and_crews = [1, _spawn_pos_foreach, _unitlist, _newgroup, _vdir, true, true, true] call d_fnc_makevgroup;
    	_newgroups pushBack _newgroup;
    	if (d_with_dynsim == 0) then {
    		[_newgroup, 0] spawn d_fnc_enabledynsim;
    	};
    	_x_mt_event_ar append (_vecs_and_crews # 0); // vehicles
    	_x_mt_event_ar append (_vecs_and_crews # 1); // crews
		{
			_x setSkill ["courage", 1];
			_x setSkill ["commanding", 1];
		} forEach _vecs_and_crews # 1; // crews
    } forEach _incoming_vehs;
};

// calculate the sum of all groups of AI already in the maintarget and size the guerrilla force accordingly
private _targetGroupCount = d_occ_cnt + d_ovrw_cnt + d_amb_cnt + d_snp_cnt;
// default guerrilla force
private _guerrillaForce = ["allmen", "allmen"];
if (_targetGroupCount > 10) then {
	_guerrillaForce = ["allmen", "allmen", "specops"];
};
if (_targetGroupCount > 20) then {
	_guerrillaForce = ["allmen", "allmen", "allmen", "specops"];
};

if (d_preemptive_special_event) then {
	// full battle, give the guerrillas the number of opfor groups / 4 or at least 3 groups
	_guerrillaGroupCount = round(_targetGroupCount / 4) max 3;
	_guerrillaForce = [];
	for "_i" from 0 to _guerrillaGroupCount do {
    	_guerrillaForce pushBack "allmen";
    };
};

private _guerrillaBaseSkill = 0.35;

{
	private _unitlist = [_x, "G"] call d_fnc_getunitlistm;
	private _newgroup = [independent] call d_fnc_creategroup;
	private _units = [_spawn_pos, _unitlist, _newgroup, false, true, 5, true] call d_fnc_makemgroup;
	{
		_x setSkill _guerrillaBaseSkill;
		_x setSkill ["spotTime", 0.6];
		_x setSkill ["spotDistance", 0.6];
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		_x_mt_event_ar pushBack _x;
	} forEach _units;
	_newgroups pushBack _newgroup;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _guerrillaForce;

_marker = ["d_mt_event_marker_guerrillainfantry", _spawn_pos, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_GUERRILLAS", 0, "mil_start"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_GUERRILLAS"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

if (d_preemptive_special_event) then {
	sleep 45;
};

{
	// each group moves toward a random waypoint near the target center
	_wp_pos = [[[_target_center, (d_cur_target_radius * 0.4)]],["water"]] call BIS_fnc_randomPos;
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "COMBAT";
	_wp = _x addWaypoint[_wp_pos, 0];
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "STAG COLUMN";
} forEach _newgroups;

sleep 2.333;

if (!isNil "d_event_trigger_tanks_guerr") then {
	d_event_trigger_tanks_guerr setVariable ["d_event_start", true, true];
};

while {sleep 1; !d_mt_done} do {
	private _foundAlive = _newgroups findIf {(units _x) findIf {alive _x} > -1} > -1;
	
	if (!_foundAlive) exitWith {};
	
	sleep 15;
};

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

deleteVehicle _trigger;
deleteMarker _marker;

if (d_preemptive_special_event) then {
	diag_log ["quick cleanup of preemptive event"];
} else {
	if (d_ai_persistent_corpses == 0) then {
		waitUntil {sleep 10; d_mt_done};
	} else {
		sleep 120;
	};
};

//cleanup
_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;
