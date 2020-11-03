//by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_getbuildings.sqf"
#include "..\x_setup.sqf"

// get array of buildings, return only buildings with defined positions inside
// _center - position
// _buildingRadius - set nearestObjects radius, -1 to return only the nearest building
// _sideHostile - (optional) side, return only buildings that are not occupied by a hostile unit

params ["_center", "_buildingRadius", "_sideHostile"];

_buildingsArray = [];

if (_buildingRadius < 0) then {
	_buildingsArray = [nearestBuilding _center];
} else {
	private _buildingsArray0 = nearestObjects [_center, ["house"], _buildingRadius];
	private _buildingsArray1 = nearestObjects [_center, ["building"], _buildingRadius];
	_buildingsArray = _buildingsArray0 arrayIntersect _buildingsArray1;
};

if (count _buildingsArray == 0) exitWith {
	diag_log "Error fn_getbuildings : No buildings found.";
	[]
};

_buildingsArrayFiltered = [];

if !(isNil "_sideHostile") then {
	{
    	if (!((_x buildingPos -1) isEqualTo []) && {!([_x, _sideHostile] call d_fnc_isbldghostile)}) then {
    		_buildingsArrayFiltered pushBack _x;
    	};
    } forEach _buildingsArray;
} else {
	{
		if (!((_x buildingPos -1) isEqualTo [])) then {
			_buildingsArrayFiltered pushBack _x;
		};
	} forEach _buildingsArray;
};

_buildingsArrayFiltered