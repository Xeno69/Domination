//#define __DEBUG__
#include "..\x_setup.sqf"

#define EYE_HEIGHT 1.53

// runs awareness for one unit
// this script needs to run fast so avoid sleep here

// _unit - this unit
// _targetSide - side the unit is engaging
// _awarenessRadius - distance AI will be aware of players, radius in meters
// _pursueRadius - distance AI will pursue a player, radius in meters
// _isAggressiveShoot - boolean, true will order AI to frequently fire (doTarget and doSuppressiveFire) at player when line of sight is favorable
// _isQuickAmmo - unit will have ammo instantly replenished on a frequent basis (this is useful when doSuppressiveFire causes the unit to burn ammo rapidly)
params ["_unit", "_targetSide", "_awarenessRadius", "_pursueRadius", "_isAggressiveShoot", "_isQuickAmmo"];

__TRACE_1("","_this")

if (_awarenessRadius <= 0) exitWith {};

if (!alive _unit) exitWith {};

if (_targetSide isEqualType "") then {
	_targetSide = [_targetSide];
};

_unit disableAI "TARGET";
private _startingPosition = _unit getVariable "startingPosition";
if (isNil "_startingPosition") then {
	_startingPosition = getPosATL _unit;
	_unit setVariable ["startingPosition", _startingPosition];
};

private _lastFired = _unit getVariable "startingPosition";
if (isNil "_lastFired") then {
	_lastFired = 0;
};

private _lastMoveOrder = _unit getVariable "lastMoveOrder";
if (isNil "_lastMoveOrder") then {
	_lastMoveOrder = 0;
};

private _lastAmmoRefill = _unit getVariable "lastAmmoRefill";
if (isNil "_lastAmmoRefill") then {
	_lastAmmoRefill = 0;
};

private _executingOccupyCommand = _unit getVariable "executingOccupyCommand";
if (isNil "_executingOccupyCommand") then {
	_executingOccupyCommand = false;
};

private _fired = _unit getVariable "fired";
if (isNil "_fired") then {
	_fired = false;
};

private _bodyPositionNext = _unit getVariable "bodyPositionNext";
if (isNil "_bodyPositionNext") then {
	_bodyPositionNext = 0;
};

private _detectionRadius = 2000; //in meters
private _moveOrderInterval = 30;
private _ammoRefillInterval = 15;

private _isSniper = "sniper" in (toLowerANSI (groupId (group _unit)));

if (_unit getVariable ["ammoCount", 0] > _unit ammo primaryWeapon _unit || {_unit getVariable ["magazineCount", 0] > count magazinesAmmo _unit}) then {
	//yes the unit actually fired
	_fired = true;
	_unit setVariable ["fired", true];
	_lastFired = time;
	_unit setVariable ["lastFired", true];
	_executingOccupyCommand = false; //we broke out of the occupy move order
	_unit setVariable ["executingOccupyCommand", false];	
};

if (_fired && {_isQuickAmmo == 1 || {_isSniper}}) then {
	//unit is eligible for quick ammo refill
	if ((time - _lastAmmoRefill) > _ammoRefillInterval) then {
		//unit has waited longer than the required interval
		_unit setVehicleAmmo 1;
		_lastAmmoRefill = time;
		_unit setVariable ["lastAmmoRefill", time];
	};
};

if (!_fired && {_isSniper && {time > _bodyPositionNext}}) then {
	//sniper unit did not find a target, change the unit's body position
	call {
		if (unitPos _unit == "AUTO" || {unitPos _unit == "UP"}) exitWith {
			//if standing upright and could not fire on a target then lay down for a while
			_unit setUnitPos "DOWN";
			_unit setVariable ["bodyPositionNext", time + ((ceil random 40) max 7)];
		};
		if (unitPos _unit == "DOWN") exitWith {
			//if down and could not fire on a target then rise to middle position
			_unit setUnitPos "MIDDLE";
			_unit setVariable ["bodyPositionNext", time + 3 + (random 3)];
		};
		if (unitPos _unit == "MIDDLE") exitWith {
			//if middle and could not fire on a target then rise to up position
			_unit setUnitPos "UP";
			_unit setVariable ["bodyPositionNext", time + 3 + (random 3)];
		};
	};
};


private _Dtargets = [];

{
	if (isPlayer _x && {alive _x && {_x isKindOf "CAManBase" && {!(vehicle _unit isKindOf "Air") && {side (group _x) in _targetSide && {_x distance2D _unit < _detectionRadius}}}}}) then {
		if (!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}) then {
			_unit reveal [_x, 4];
			_Dtargets pushBack [_x distance2D _unit, _x];
		};
	};
} forEach (_unit nearEntities _awarenessRadius);
__TRACE_1("","_Dtargets")

if (d_civ_massacre) then {
	// these enemies are attacking civs, add nearby civs within 75m to _Dtargets array
	{
		if (alive _x && {_x isKindOf "CAManBase" && {side _x == civilian}}) then {
			_Dtargets pushBack [_x distance2D _unit, _x];
		};
	} forEach (nearestObjects [_unit, ["Man"], 75]);
};

private _targets = [];
private _isDoingSuppressiveFire = false;

if (_Dtargets isNotEqualTo []) then {
	_Dtargets sort true;
	_playersSortedByDistance = _Dtargets apply {_x # 1};
	if (d_priority_targets isNotEqualTo []) then {
		// if priority target exists then it should be first in the targets array
		reverse _playersSortedByDistance;
		_playersSortedByDistance pushBack d_priority_targets # 0;
		reverse _playersSortedByDistance;
		_targets = _playersSortedByDistance;
	} else {
		_targets = _playersSortedByDistance;
	};
	if (count _targets > 0) then {
		__TRACE_1("","_targets")
		if (_isAggressiveShoot == 1) then {
			__TRACE("Aggressive Shoot")
			{
				if (!(_x getVariable ["xr_pluncon", false]) && {[_unit, _x] call d_fnc_isvisible}) exitWith {
					if (alive _x && {_x isKindOf "CAManBase" && {side _x == civilian}}) then {
						// targeting a civ, make the civ a renegade so enemy will engage
						_x addRating -10000;
						_x forceSpeed -1; // allow the targeted civilian to move, why not
					};
					//to check if unit actually fired
					_unit setVariable ["ammoCount", _unit ammo primaryWeapon _unit]; 
					_unit setVariable ["magazineCount", count magazinesAmmo _unit]; 
					// execute aggressive shooting
					_isDoingSuppressiveFire = true;
					_unit doTarget _x;
					_unit doSuppressiveFire _x;
				};
			} forEach _targets;
		};
		
		if !(_isDoingSuppressiveFire) then {
			_target_move_dest = _targets # 0;
			__TRACE_1("","_target_move_dest")
			// if a priority target is defined or a target is within pursue radius then doMove
			if (d_priority_targets isNotEqualTo [] || {_pursueRadius > 0 && {_target_move_dest distance2D _unit < _pursueRadius}}) then {
				__TRACE("pursue radius")
				//unit is eligible for a move order
				if ((time - _lastMoveOrder) > _moveOrderInterval) then {
					//unit has waited longer than the required interval
					_unit doMove (getPosATL _target_move_dest);
					_unit setCombatMode "RED";
					(group _unit) setSpeedMode "FULL";
					_lastMoveOrder = time;
					_unit setVariable ["lastMoveOrder", _lastMoveOrder];
					_executingOccupyCommand = false; //we broke out of the occupy move order
					_unit setVariable ["executingOccupyCommand", false];
				};
			};
		};
	};
} else {
	//no target nearby
	__TRACE("no target nearby")
	if (!_isSniper && {leader _unit == _unit}) then {
		//unit is the group leader
		//group must 1) resume existing waypoints or 2) return to the unit's original position and occupy a building
		//hack - just get them back in buildings for now
		if ((time - _lastMoveOrder) > _moveOrderInterval && {!_executingOccupyCommand && {!isNull group _unit && {(getPos _unit distance [0,0,0]) > 0 && {(count units group _unit) > 0 && {(getPosATL _unit distance _startingPosition) > 10}}}}}) then {
			(group _unit) setCombatMode "YELLOW";
			(group _unit) setSpeedMode "NORMAL";
			//unit is eligible for a move order
			if (count (waypoints leader _unit) > 0) then {
				__TRACE("occupy building")
				//unit is leader and has waypoints, find nearest waypoint and resume - todo
				//hack, just resume at waypoint #1
				//(group _unit) setCurrentWaypoint [group _unit, 1];
				//hack above doesn't work, just scatter them in nearby buildings
				[
					getPosATL _unit,											// Params: 1. Array, the building(s) nearest this position is used
					units _unit,									//         2. Array of objects, the units that will garrison the building(s)
					-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
					false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
					true,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
					true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
					true,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
					1,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
					true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
				] call d_fnc_Zen_OccupyHouse;
				_executingOccupyCommand = true;
				_unit setVariable ["executingOccupyCommand", true];
			} else {
				if (((getPosATL _unit) distance2D _startingPosition) > 3) then {
					//group will occupy a house at unit's original position
					[
						_startingPosition,											// Params: 1. Array, the building(s) nearest this position is used
						units _unit,									//         2. Array of objects, the units that will garrison the building(s)
						-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
						false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
						false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
						true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
						true,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
						1,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
						true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
					] call d_fnc_Zen_OccupyHouse;
					_executingOccupyCommand = true;
					_unit setVariable ["executingOccupyCommand", true];
				};
			};
			_lastMoveOrder = time;
			_unit setVariable ["lastMoveOrder", _lastMoveOrder];
		};
	};
};
