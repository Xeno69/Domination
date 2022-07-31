// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Guerilla infantry spawn in a location near the maintarget and then move into the center of maintarget with a Search and Destroy waypoint

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _townNearbyName = "";
private _townNearbyPos = [];
private _minimumDistanceFromMaintarget = 500;
private _maximumDistanceFromMaintarget = 800;
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

waitUntil {sleep 0.1; !isNil {_trigger getVariable "d_event_start"}};

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

private _newgroups = [];
// calculate the sum of all groups of AI already in the maintarget and size the guerrilla force accordingly
private _targetGroupCount = d_occ_cnt + d_ovrw_cnt + d_amb_cnt + d_snp_cnt;
// default guerrilla force
private _guerrillaForce = ["allmen", "allmen"];
if (_targetGroupCount > 10) then {
	_guerrillaForce = ["allmen", "allmen", "allmen"];
};
if (_targetGroupCount > 20) then {
	_guerrillaForce = ["allmen", "allmen", "allmen", "allmen"];
};
private _guerrillaBaseSkill = 0.35;

{
	private _unitlist = [_x, "G"] call d_fnc_getunitlistm;
	if !(d_faction_independent_array isEqualTo []) then {
		_unitlist = selectRandom d_faction_independent_array;
	};
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

sleep 3.14;

{
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "CARELESS";
	_wp = _x addWaypoint[_target_center, 0];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "STAG COLUMN";
} forEach _newgroups;

sleep 2.333;

_marker = ["d_mt_event_marker_guerrillainfantry", _spawn_pos, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_GUERRILLAS", 0, "mil_start"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_GUERRILLAS"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

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

if (d_ai_persistent_corpses == 0) then {
	waitUntil {sleep 10; d_mt_done};
} else {
	sleep 120;
};

//cleanup
_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;
