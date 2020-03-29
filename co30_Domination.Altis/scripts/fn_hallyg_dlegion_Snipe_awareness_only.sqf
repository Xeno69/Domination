//#define __DEBUG__
#define THIS_FILE "fn_hallyg_dlegion_Snipe_awareness_only.sqf"
#include "..\x_setup.sqf"

#define EYE_HEIGHT 1.53

params ["_unit", "_targetSide", "_distanceThreshold"];

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

//in meters
_detectionRadius = 2000;

//sniper aware loop
while {true} do {
	sleep (35 + random 19);
	
	_Dtargets = [];

	{
		if (alive _x && {_x isKindOf "CAManBase" && {!(vehicle _unit isKindOf "Air") && {side _x == _targetSide && {_x distance2D _unit < _detectionRadius}}}}) then {
			_unit reveal [_x, 4];
			_Dtargets pushBack _x;
		};
	} forEach (_unit nearEntities 1400);
	
	if (count _Dtargets > 0) then {
		_playersSortedByDistance = [_Dtargets, getPos _unit] call _sortArrayByDistance;
		_nearestTargetPlayer = _playersSortedByDistance select 0;
		        	
		if (_nearestTargetPlayer distance2D _unit < _distanceThreshold) then {
			_unit doMove (position _nearestTargetPlayer);
		};
	};
	
};