﻿/*===========================================================================================
	Random House Patrol Script v2.2 for Arma 3
	by Tophe of Östgöta Ops [OOPS]

	Contact & bugreport: BIS forums

=============================================================================================
HOW TO USE:
Place unit close to a house and put this in the init field:
guard = [this] execVM "HousePatrol.sqf"


OPTIONAL SETTINGS:

guard = [this, MODE, STAND TIME, EXCLUDED POS, STARTING POS, DEBUG] execVM "HousePatrol.sqf"

* BEHAVIOUR - set unit behaviour.
	guard = [this,"COMBAT"] execVM "HousePatrol.sqf"

	Options: CARELESS, SAFE, AWARE, COMBAT, STEALTH
	Default: SAFE

* STAND TIME - Set maximum amount of seconds the unit will wait before moving to next waypoint.
	guard = [this,"SAFE",50] execVM "HousePatrol.sqf"

	Options: Any value in seconds. 0 = continuous patrol.
	Default: 30

* EXCLUDED POSITIONS - exclude certain building positions from patrol route.
	guard = [this,"SAFE",30, [5,4]] execVM "HousePatrol.sqf"

	Options: Array of building positions
	Default: [] (no excluded positions)

* STARTING POS - Some building positions doesn't work well will the setPos command.
	Here you may add a custom starting pos. Negative number means starting pos will be randomized.
	guard = [this,"SAFE",30, [5,4], 2] execVM "HousePatrol.sqf"

	Options: Any available building position
	Default: -1 (random)

* STANCE - Tell the unit what stance to use.
	To keep the unit from going prone you can set this to MIDDLE or UP.
	AUTO will be the standard behaviour and unit will crawl around in combat mode.
	HIGH is the default mode. This is like AUTO but prone position is excluded.

	Options: UP, DOWN, MIDDLE, AUTO, HIGH
	Default: HIGH

* DEBUG - Use markers and chatlog for mission design debugging.
	guard = [this,"SAFE",30, [], -1, true] execVM "HousePatrol.sqf"

	Options: true/false
	Default: false

===========================================================================================*/

//#define __DEBUG__
#define THIS_FILE "fn_HousePatrol.sqf"
#include "..\x_setup.sqf"

if !(isServer) exitWith {};

sleep random 1;

params ["_unit", ["_behaviour", "safe"], ["_maxWaitTime", 30], ["_excludedPositions", []], ["_startingPos", -1], ["_stance", "high"], ["_debug", false], ["_house", objNull]];

_behaviour = toLowerANSI _behaviour;
_stance = toLowerANSI _stance;

if (isNull _house) then {_house = nearestBuilding _unit};
if (isNull _house) exitWith {};
private _numOfBuildingPos = count (_house buildingPos -1);
if (_numOfBuildingPos == 0) exitWith {};
private _currentBuildingPos = 0;
private _lastBuildingPos = 0;
private _waitTime = 0;
private _timeout = 0;

private _behaviours = ["careless", "safe", "aware", "combat", "stealth"];
private _stances = ["up", "down", "middle", "auto", "high"];

#ifdef __DEBUG__
private _name = vehicleVarName _unit;

if (isNil "_name") then {
	private _position = getPos _unit;
	_name = format ["Guard x%1y%2", floor (_position select 0), floor (_position select 1)];
};
#endif

// Set behaviour of unit
if (_behaviour in _behaviours) then {
	_unit setBehaviour _behaviour;
} else {
	_unit setBehaviour "SAFE";
};

// Set unit stance
private "_stancehandle";
if (_stance == "high") then {
	_stancehandle = [_unit] spawn {
		scriptName "spawn_housepatrol";
		params ["_unit"];
		while {alive _unit} do {
			if (unitPos _unit == "DOWN") then {
				if (random 1 < 0.5) then {_unit setUnitPos "MIDDLE"} else {_unit setUnitPos "UP"};
				sleep random 5;
				_unit setUnitPos "AUTO";
			};
			sleep 0.2;
		};
	};
} else {
	if (_stance in _stances) then {
		_unit setUnitPos _stance;
	} else {
		_unit setBehaviour "UP";
	};
};

// DEBUGGING - Mark house on map, mark building positions ingame, broadcast information
#ifdef __DEBUG__
	for [{_i = 0}, {_i <= _numOfBuildingPos}, {_i = _i + 1}] do	{
		if !(_i in _excludedPositions) then {
			_arrow = "Sign_Arrow_F" createVehicle (_house buildingPos _i);
			_arrow setPos (_house buildingpos _i);
		};
	};
	player globalChat format["%1 - Number of available positions: %2", _name, _numOfBuildingPos];
	if (count _excludedPositions > 0) then {
		player globalChat format["%1 - Excluded positions: %2", _name, _excludedPositions];
	};

	_marker = createMarker [_name, position _unit];
	_marker setMarkerType "mil_dot";
	_marker setMarkerText _name;
	_marker setMarkerColor "ColorGreen";
#endif

// Put unit at random starting pos.
while {_startingPos in _excludedPositions || {_startingPos < 0}} do {
	_startingPos = floor (random _numOfBuildingPos);
};

if (_startingPos > _numOfBuildingPos - 1) then {
	_startingPos = _numOfBuildingPos - 1
};

//if (_numOfBuildingPos > 0) then {
//	_unit setPos (_house buildingPos _startingPos);
//	_unit setPos (getPos _unit);
//};

// DEBUGGING - broadcast starting position
#ifdef __DEBUG__
	player globalChat format["%1 - starting at building pos %2", _name, _startingPos];
#endif

_unit setVariable ["d_housepatrol", true];

// Have unit patrol inside house
private _searchcounter = 0;
while {alive _unit && {(_numOfBuildingPos - count _excludedPositions) > 0}} do {
	if (_numOfBuildingPos < 2) exitWith {};

	while {_lastBuildingPos == _currentBuildingPos || {_currentBuildingPos in _excludedPositions}} do {
		_currentBuildingPos = floor (random _numOfBuildingPos);
	};

	_waitTime = floor (random _maxWaitTime);
	_unit doMove (_house buildingPos _currentBuildingPos);
	_unit moveTo (_house buildingPos _currentBuildingPos);
	sleep 0.5;
	_timeout = time + 50;
	while {true} do {
		sleep 0.1;
		if (moveToCompleted _unit || {moveToFailed _unit || {!alive _unit || {_timeout < time}}}) exitWith {};
	};
	if (_timeout < time) then {_unit setPos (_house buildingPos _currentBuildingPos)};

	// DEBUGGING - move marker to new position
#ifdef __DEBUG__
		_name setMarkerPos position _unit;
		_text = format["%1: moving to pos %2", _name, _currentBuildingPos];
		_name setMarkerText _text;
#endif

	_searchcounter = _searchcounter + 1;
	if (_searchcounter == 6) exitWith {};

	sleep _waitTime;
	_lastBuildingPos = _currentBuildingPos;
};
if (alive _unit) then {
	_unit setVariable ["d_housepatrol", nil];
};

if (!isNil "_stancehandle" && {!isNull _stancehandle}) then {
	terminate _stancehandle;
};

// DEBUGGING - Change marker color if script ends
#ifdef __DEBUG__
	player globalChat format["%1 - ended house patrol loop", _name];
	_name setMarkerColor "ColorRed";
#endif
