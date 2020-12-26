// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_event_guerrilla_infantry_incoming.sqf"
#include "..\..\x_setup.sqf"

params ["_target_radius", "_target_center"];

// Guerilla infantry spawn in a location near the maintarget and then move into the center of maintarget with a Search and Destroy waypoint

if !(isServer) exitWith {};

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _townNearbyName = "";
private _townNearbyPos = [];
private _minimumDistanceFromMaintarget = 500;
private _maximumDistanceFromMaintarget = 800;

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

_x_mt_event_ar = [];

private _trigger = [_target_center, [600,600,0,false,30], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

_eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028_INFANTRY", _townNearbyName];
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
	_guerrillaForce = ["allmen", "allmen", "specops"];
};
if (_targetGroupCount > 20) then {
	_guerrillaForce = ["allmen", "allmen", "allmen", "specops"];
};
private _guerrillaBaseSkill = 0.35;

{
	private _unitlist = [_x, "G"] call d_fnc_getunitlistm;
	private _newgroup = [independent] call d_fnc_creategroup;
	private _units = [_spawn_pos, _unitlist, _newgroup, false, true, 5, opfor] call d_fnc_makemgroup;
	{
		_x setSkill _guerrillaBaseSkill;
		_x setSkill ["spotTime", 0.6];
		_x setSkill ["spotDistance", 0.6];
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		_x_mt_event_ar pushBack _x;
	} forEach _units;
	_newgroup deleteGroupWhenEmpty true;
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

private _all_dead = false;

while {sleep 1; !d_mt_done && {!_all_dead}} do {                                             	
	private _foundAlive = false;
	{
		private _grp = _x;
		{
			if (alive _x) exitWith {
				_foundAlive = true;
			};
		} forEach (units _grp);
	} forEach _newgroups;
	
	if !(_foundAlive) then {
		_all_dead = true;
	};
	
	sleep 15;
};

sleep 60;

//cleanup
{
	if !(isNull _x) then {
		if (_x isKindOf "House") then {
			_x setDamage 0;
			deleteVehicle _x;
		} else {
			if (_x isKindOf "LandVehicle" && {!((crew _x) isEqualTo [])}) then {
				if ({(_x call d_fnc_isplayer) && {alive _x}} count (crew _x) == 0) then {
					_x call d_fnc_DelVecAndCrew;
				};
			} else {
				deleteVehicle _x;
			};
		};
	};
} forEach _x_mt_event_ar;
_x_mt_event_ar = [];

deleteVehicle _trigger;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
