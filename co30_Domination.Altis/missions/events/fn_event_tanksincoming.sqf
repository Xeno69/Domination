// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

// DEPRECATED - this script has been replaced by fn_event_guerrilla_infantry_incoming (that event now has an option to add tanks so this script is no longer needed)

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Guerilla tanks spawn in a location near the maintarget and then move into the center of maintarget with a Search and Destroy waypoint

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private ["_eventArmorHeavy", "_eventArmorMedium", "_eventArmorLight"];
//armor types
_eventArmorHeavy = "I_MBT_03_cannon_F";
_eventArmorMedium = "I_APC_tracked_03_cannon_F";
_eventArmorLight = "I_LT_01_cannon_F";

//array of armor vehicles to create
private _eventArmorAll = [];

private _with_less_armor = if (!isNil "d_enemy_mode_current_maintarget") then {
	d_enemy_mode_current_maintarget;
} else {
	d_WithLessArmor;
};

switch (_with_less_armor) do {
	// normal
	case 0: {
		_eventArmorAll = [
			_eventArmorMedium,
			_eventArmorLight,
			_eventArmorLight
		];
	};
	// low
	case 1: {
		_eventArmorAll = [
			_eventArmorMedium,
			_eventArmorLight
		];	
	};
	// none
	case 2: {
		_eventArmorAll = [
			_eventArmorLight
		];
	};
	// high
	case 4: {
		_eventArmorAll = [
			_eventArmorHeavy,
			_eventArmorMedium,
			_eventArmorLight,
			_eventArmorLight
		];
	};
};

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _chosen = false;
private _tries = 0;
private _townNearbyName = "";
private _townNearbyPos = [];
private _numberOfTanks = 2;
if (_with_less_armor == 0) then { _numberOfTanks = 4; };

private _towns = nearestLocations [_target_center, ["NameCityCapital", "NameCity", "NameVillage"], 10000];
if (count _towns > 1) then {
	private _loc = _towns # 1;
	_townNearbyPos = getPos _loc;
	_townNearbyName = text _loc;
};

if (_townNearbyPos isEqualTo []) exitWith {
	diag_log ["unable to find a location to spawn tanks for mission event", d_cur_tgt_name];
};

private _x_mt_event_ar = [];

private _trigger = [_target_center, [475,475,0,false,30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

if (isNil "d_event_trigger_tanks_guerr") then {
	// special trigger stored for later, guerrilla infantry event may also trigger this event
	d_event_trigger_tanks_guerr = _trigger;
	publicVariable "d_event_trigger_tanks_guerr";
};

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028", _townNearbyName];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

private _newgroups = [];

private _roadList = _townNearbyPos nearroads 350;
if (_roadList isEqualTo []) exitWith {
	diag_log [format["exiting mission event, no roads found to spawn vehicles %1 %2", _townNearbyName, _townNearbyPos]];
};

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSideGuerrTanks",
	["1", "", _townNearbyName, []],
	d_kbtel_chan
];

private _iter = 0;
{
	private _veh = createVehicle [_x, _roadList # _iter, [], 0, "NONE"];
	_iter = _iter + 1;
	_x_mt_event_ar pushBack _veh;
	_veh call d_fnc_nodamoff;
	sleep 5;
	private _newgroup = createVehicleCrew _veh;
	_newgroups pushBack _newgroup;
} forEach _eventArmorAll;

sleep 3.14;

{
	(units _x) join (_newgroups select 0);
	_x setCombatMode "RED";
	_x setSpeedMode "FULL";
	_x setBehaviour "COMBAT";
	_wp = _x addWaypoint[_target_center, 0];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setwaypointtype "SAD";
	_wp setWaypointFormation "FILE";
	
} forEach _newgroups;

if (d_with_dynsim == 0) then {
	{
		[_x] spawn d_fnc_enabledynsim;
	} forEach _newgroups;
};

sleep 2.333;

private _all_dead = false;

while {!d_mt_done} do {
	private _foundAlive = _newgroups findIf {(units _x) findIf {alive _x} > -1} > -1;
	
	if (!_foundAlive) exitWith {};
	
	sleep 15;
};

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

if (d_ai_persistent_corpses == 0) then {
	waitUntil {sleep 10; d_mt_done};
} else {
	sleep 120;
};

//cleanup
d_event_trigger_tanks_guerr = nil;
publicVariable "d_event_trigger_tanks_guerr";
_x_mt_event_ar call d_fnc_deletearrayunitsvehicles;
deleteVehicle _trigger;
