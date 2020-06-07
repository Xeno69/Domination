//by Killzone Kid and modified by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_isbldghostile.sqf"
#include "..\x_setup.sqf"

// check if _bldg is occupied by units of _sideHostile

params ["_bldg", "_sideHostile"];
private _distancePlayerSideTooClose = 7;
private _isOccupiedByEnemy = false;
private _pa = _bldg buildingPos -1;
if !(_pa isEqualTo []) then {
	private _p = _pa select 0; //just test for enemies around pos # 0 in each building
	{
		if (alive _x && {_x isKindOf "CAManBase" && {side _x == _sideHostile }}) then {
			_isOccupiedByEnemy = true;
		};
	} forEach (_p nearEntities _distancePlayerSideTooClose);
};
_isOccupiedByEnemy;