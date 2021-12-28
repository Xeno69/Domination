//by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// check if _bldg is occupied by units of _sideHostile

params ["_bldg", "_sideHostile"];
private _distancePlayerSideTooClose = 7;
private _isOccupiedByEnemy = false;
private _pa = _bldg buildingPos -1;
if (_pa isNotEqualTo []) then {
	private _p = _pa # 0; //just test for enemies around pos # 0 in each building
	{
		if (alive _x && {_x isKindOf "CAManBase" && {side group _x == _sideHostile }}) then { // always use side group _x
			_isOccupiedByEnemy = true;
		};
	} forEach (_p nearEntities _distancePlayerSideTooClose);
	
	/*
	// this would be better because it ends the loop once the condition is met
	// Xeno: the forEach loop above sets _isOccupiedByEnemy to true, so all following elements in the array are ignored anyway.
	((_pa # 0) nearEntities _distancePlayerSideTooClose) findIf {
		private _ret = alive _x && {_x isKindOf "CAManBase" && {side group _x == _sideHostile }};
		if (_ret) then {
			_isOccupiedByEnemy = true;
		};
		_ret
	};*/
};
_isOccupiedByEnemy