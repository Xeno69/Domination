//#define __DEBUG__
#define THIS_FILE "fn_hallyg_dlegion_Snipe_awareness.sqf"
#include "..\x_setup.sqf"

#define EYE_HEIGHT 1.53

params ["_unit", "_targetSide", "_distanceThreshold"];

//by HallyG, dlegion
private _isLOS = {
	params ["_looker", "_target", "_FOV"];

	if ([position _looker, getDir _looker, _FOV, position _target] call BIS_fnc_inAngleSector) then {
		_lineIntersections = lineIntersectsSurfaces [(AGLtoASL (_looker modelToWorldVisual (_looker selectionPosition "pilot"))), getPosASL _target, _target, _looker, true, 1,"GEOM","NONE"];
		if (count (_lineIntersections) > 0) exitWith {
			false
		};
		true
	} else {
		false
	};
};

//by Jezuro
private _sortArrayByDistance = {
	params ["_unitArray", "_fromPosition"];
	_unsorted = _unitArray;
	_sorted = [];
	_pos = _fromPosition;

	{
		_closest = _unsorted select 0;
		{if ((getPos _x distance _pos) < (getPos _closest distance _pos)) then {_closest = _x}} forEach _unsorted;
		_sorted pushBack _closest;
		_unsorted = _unsorted - [_closest]
	} forEach _unsorted;

	_sorted
};

//by sarogahtyp
private _isVisible = {
	params ["_unit", "_target"];
	_visibleThreshold = 0.015;
	_targetEye = eyepos _target;
	_unitEye = eyepos _unit;

	//vector origins are half meter away from looker and target (uses 0.5 of a normalized vector which by definition is 1 meter)
	_unit_in_dir = _unitEye vectorAdd ((_unitEye vectorFromTo _targetEye) vectorMultiply 0.5);
	_target_in_dir = _targetEye vectorAdd ((_targetEye vectorFromTo _unitEye) vectorMultiply 0.5);

	_visiblity = parseNumber str ([objNull, "VIEW"] checkVisibility [_target_in_dir, _unit_in_dir]);

	if (_visiblity > _visibleThreshold) then {
		true
	} else {
		false
	};
};

//in meters
_detectionRadius = 2000;

_loopCountSinceLastMoveOrder = 0;
_loopCountThreshold = 3;

if (d_ai_pursue_dist < 0) then {
	(group _unit) setSpeedMode "FULL";
};

//awareness loop
while {true} do {
	
	if (d_ai_aware == 0 && d_ai_pursue_dist < 0) exitWith {};
		
	_Dtargets = [];

	{
		if (alive _x && {_x isKindOf "CAManBase" && {!(vehicle _unit isKindOf "Air") && {side _x == _targetSide && {_x distance2D _unit < _detectionRadius}}}}) then {
			if (d_ai_aware == 1) then {
				_unit reveal [_x, 4];
			};
			_Dtargets pushBack _x;
		};
	} forEach (_unit nearEntities 1400);
	
	_playersSortedByDistance = [_Dtargets, getPos _unit] call _sortArrayByDistance;
	
	if (count _playersSortedByDistance > 0) then {
		
		{
			if (d_ai_aggressiveshoot == 1) then {
				if (([_unit, _x] call _isVisible) || {[_unit, _x, 360] call _isLOS}) then {
					// execute aggressive shooting
					_unit doTarget _x;
					_unit doSuppressiveFire _x;
				};
			};
		} forEach (_playersSortedByDistance);
		
		_nearestTargetPlayer = _playersSortedByDistance select 0;
		        	
		if (d_ai_pursue_dist > 0 && (_nearestTargetPlayer distance2D _unit < _distanceThreshold)) then {
			if (_loopCountSinceLastMoveOrder > _loopCountThreshold) then {
				_unit doMove (position _nearestTargetPlayer);
			} else {
				_loopCountSinceLastMoveOrder = _loopCountSinceLastMoveOrder + 1;
			};
		};
		
	};
	
	sleep ((random 5) + 3);
	
};