//#define __DEBUG__
#define THIS_FILE "fn_hallyg_dlegion_Snipe_awareness.sqf"
#include "..\x_setup.sqf"

#define EYE_HEIGHT 1.53

// _unit - this unit
// _targetSide - side the unit is engaging
// _awarenessRadius - distance AI will be aware of players, radius in meters
// _pursueRadius - distance AI will pursue a player, radius in meters
// _isAggressiveShoot - boolean, true will order AI to frequently fire (doTarget and doSuppressiveFire) at player when line of sight is favorable
// _isQuickAmmo - unit will have ammo instantly replenished on a frequent basis (this is useful when doSuppressiveFire causes the unit to burn ammo rapidly)
params ["_unit", "_targetSide", "_awarenessRadius", "_pursueRadius", "_isAggressiveShoot", "_isQuickAmmo"];

//by HallyG, dlegion
private _isLOS = {
	params ["_looker", "_target", "_FOV"];

	if ([position _looker, getDir _looker, _FOV, position _target] call BIS_fnc_inAngleSector) then {
		_lineIntersections = lineIntersectsSurfaces [(AGLtoASL (_looker modelToWorldVisual (_looker selectionPosition "pilot"))), getPosASL _target, _target, _looker, true, 1, "GEOM", "NONE"];
		if (count (_lineIntersections) > 0) exitWith {
			false
		};
		true
	} else {
		false
	};
};

//_unit disableAI "AIMINGERROR";
_unit disableAI "TARGET";

sleep (30 + (random 45));

private _startingPosition = getPosATL _unit;

private _detectionRadius = 2000; //in meters
private _lastFired = 0;
private _lastMoveOrder = 0;
private _moveOrderInterval = 30;
private _lastAmmoRefill = 0;
private _ammoRefillInterval = 15;
private _executingOccupyCommand = false;


private _isSniper = ["Sniper", groupId(group _unit)] call BIS_fnc_inString;

//awareness loop
while {true} do {
	_Dtargets = [];

	if (!alive _unit) exitWith {};
	{
		if (isPlayer _x && {alive _x && {_x isKindOf "CAManBase" && {!(vehicle _unit isKindOf "Air") && {side _x == _targetSide && {_x distance2D _unit < _detectionRadius}}}}}) then {
			if (_awarenessRadius > 0 && {_x getVariable ["xr_pluncon", false] || {_x getVariable ["ace_isunconscious", false]}}) then {
				_unit reveal [_x, 4];
			};
			_Dtargets pushBack _x;
		};
	} forEach (_unit nearEntities _awarenessRadius);
	
	_fired = false;
	
	if (count _Dtargets > 0) then {
		_playersSortedByDistance = [_Dtargets, getPos _unit] call d_fnc_sortarraybydistance;
		
		if (_isAggressiveShoot == 1) then {
			{
				if (!alive _unit) exitWith {};
				if (([_unit, _x] call d_fnc_isvisible) || {[_unit, _x, 360] call _isLOS}) then {
					//to check if unit actually fired
					_ammoCount = _unit ammo primaryWeapon _unit;
					_magazineCount = count magazinesAmmo _unit; 
					// execute aggressive shooting
					_unit doTarget _x;
					_unit doSuppressiveFire _x;
					sleep 15;
					if (!alive _unit) exitWith {};
					if (_ammoCount > _unit ammo primaryWeapon _unit || {_magazineCount > count magazinesAmmo _unit}) then {
						//yes the unit actually fired
						_fired = true;
						_lastFired = time;
					};
					if (_fired) exitWith {
						_executingOccupyCommand = false; //we broke out of the occupy move order
					};
				};
			} forEach _playersSortedByDistance;
		};
		
		if (!alive _unit) exitWith {};
		
		_nearestTargetPlayer = _playersSortedByDistance select 0;

		if (_pursueRadius > 0 && {_nearestTargetPlayer distance2D _unit < _pursueRadius}) then {
			//unit is eligible for a move order
			if ((time - _lastMoveOrder) > _moveOrderInterval) then {
				//unit has waited longer than the required interval
				_unit doMove (getPosATL _nearestTargetPlayer);
				_unit setCombatMode "RED";
				(group _unit) setSpeedMode "FULL";
				_lastMoveOrder = time;
				_executingOccupyCommand = false; //we broke out of the occupy move order
			};
		};
	} else {
		//no target nearby
		if (!_isSniper && {leader _unit == _unit}) then {
			//unit is the group leader
			//group must 1) resume existing waypoints or 2) return to the unit's original position and occupy a building
			//hack - just get them back in buildings for now
			if ((time - _lastMoveOrder) > _moveOrderInterval && {!_executingOccupyCommand && {!isNull group _unit && {(getPos _unit distance [0,0,0]) > 0 && {(count units group _unit) > 0 && {(getPosATL _unit distance _startingPosition) > 10}}}}}) then {
				(group _unit) setCombatMode "YELLOW";
				(group _unit) setSpeedMode "NORMAL";
				//unit is eligible for a move order
				if (count (waypoints leader _unit) > 0) then {
					//unit is leader and has waypoints, find nearest waypoint and resume - todo
					//hack, just resume at waypoint #1
					//(group _unit) setCurrentWaypoint [group _unit, 1];
					//hack above doesn't work, just scatter them in nearby buildings
					[
						getPosATL _unit,											// Params: 1. Array, the building(s) nearest this position is used
						units (group _unit),									//         2. Array of objects, the units that will garrison the building(s)
						-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
						false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
						true,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
						true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
						true,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
						1,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
						true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
					] call d_fnc_Zen_OccupyHouse;
					_executingOccupyCommand = true;
				} else {
					if (((getPosATL _unit) distance2D _startingPosition) > 3) then {
						//group will occupy a house at unit's original position
						[
							_startingPosition,											// Params: 1. Array, the building(s) nearest this position is used
							units (group _unit),									//         2. Array of objects, the units that will garrison the building(s)
							-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
							false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
							false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
							true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
							true,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
							1,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
							true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
						] call d_fnc_Zen_OccupyHouse;
						_executingOccupyCommand = true;
					};
				};
				if (!alive _unit) exitWith {};
				sleep 30;
				_lastMoveOrder = time;
			};
		} else {
			sleep 3;
		};
	};
	
	if (!alive _unit) exitWith {};
		
	if (_fired && {_isQuickAmmo == 1 || {_isSniper}}) then {
		//unit is eligible for quick ammo refill
		if ((time - _lastAmmoRefill) > _ammoRefillInterval) then {
			//unit has waited longer than the required interval
			_unit setVehicleAmmo 1;
			_lastAmmoRefill = time;
		};
	};
	
	if (!_fired && {_isSniper}) then {
		//sniper unit did not find a target, change the unit's body position
		call {
			if (unitPos _unit == "AUTO" || {unitPos _unit == "UP"}) exitWith {
				//if standing upright and could not fire on a target then lay down for a while
				_unit setUnitPos "DOWN";
				sleep ((ceil random 40) max 7);
			};
			if (unitPos _unit == "DOWN") exitWith {
				//if down and could not fire on a target then rise to middle position
				_unit setUnitPos "MIDDLE";
				sleep 3;
			};
			if (unitPos _unit == "MIDDLE") exitWith {
				//if middle and could not fire on a target then rise to up position
				_unit setUnitPos "UP";
				sleep 3;
			};
		};
	};
	
	if (!alive _unit) exitWith {};
	
	sleep (3 + random 3);
};
