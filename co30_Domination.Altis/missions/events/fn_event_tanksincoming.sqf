// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_event_tanksincoming.sqf"
#include "..\..\x_setup.sqf"

params ["_target_radius", "_target_center"];

// Guerilla tanks spawn in a location near the maintarget and then move into the center of maintarget with a Search and Destroy waypoint

if !(isServer) exitWith {};

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _chosen = false;
private _tries = 0;
private _townNearbyName = "";
private _townNearbyPos = [];

private _towns = nearestLocations [_target_center, ["NameCityCapital", "NameCity", "NameVillage"], 10000];
if (count _towns > 1) then {
	private _loc = _towns # 1;
	_townNearbyPos = getPos _loc;
	_townNearbyName = text _loc;
};

if (_townNearbyPos isEqualTo []) exitWith {
	diag_log ["unable to find a location to spawn tanks for mission event", d_cur_tgt_name];
	d_mt_event_resolved = true;
};

d_x_mt_event_ar = [];
d_mt_event_resolved = false;

//d_x_mt_event_pos = _townNearbyPos;
//publicVariable "d_x_mt_event_pos";

private _trigger = [_target_center, [225,225,0,false], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

d_kb_logic1 kbTell [d_kb_logic2 ,d_kb_topic_side, "MTEventSideGuerrTanks", d_kbtel_chan];

private _newgroups = [];

private _roadList = _townNearbyPos nearroads 200;
if (_roadList isEqualTo []) exitWith {
	diag_log ["exiting mission event, no roads found to spawn vehicles"];
};

for "_i" from 1 to 2 do {
	private _veh = createVehicle ["I_MBT_03_cannon_F", _roadList select _i, [], 0, "NONE"];
	d_x_mt_event_ar pushBack _veh;
	_veh call d_fnc_nodamoff;
	sleep 3;
	private _hhe = createVehicle [d_HeliHEmpty, getPosATL _veh, [], 0, "NONE"];
    _veh setPos (getPosATL _hhe);
    deleteVehicle _hhe;
    sleep 3;
	private _newgroup = createVehicleCrew _veh;
	_newgroups pushBack _newgroup;
	{
		_x call d_fnc_nodamoff;
	} forEach units _newgroup;
    if (d_with_ai) then {
    	_newgroup setVariable ["d_do_not_delete", true];
    };
};

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

while {!d_mt_event_resolved && {!_all_dead}} do {                                             
	//if maintarget is done then just exit the while loop and proceed to cleanup
	if (d_mt_done) exitWith {
		d_mt_event_resolved = true;
		publicVariable "d_mt_event_resolved";
	};
	
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
} forEach d_x_mt_event_ar;
d_x_mt_event_ar = [];

deleteVehicle _trigger;
deleteMarker _marker;
