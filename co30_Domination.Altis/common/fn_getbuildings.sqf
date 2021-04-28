//by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

// get array of buildings, return only buildings with defined positions inside
// _center - position
// _buildingRadius - set nearestObjects radius, -1 to return only the nearest building
// _sideHostile - (optional) side, return only buildings that are not occupied by a hostile unit
// _minimumNumberOfPositions - (optional) return only buildings that have this many positions in the building

params ["_center", "_buildingRadius", "_sideHostile", ["_minimumNumberOfPositions", 0, [0]]];

private _buildingsArray = [];

if (_buildingRadius isEqualType objNull) then {
	_buildingsArray = [_buildingRadius];
	__TRACE_1("","_buildingsArray")
} else {
	if (_buildingRadius < 0) then {
		_buildingsArray = [nearestBuilding _center];
	} else {
		_buildingsArray = (nearestObjects [_center, ["house"], _buildingRadius]) arrayIntersect (nearestObjects [_center, ["building"], _buildingRadius]);
	};
};

if (count _buildingsArray == 0) exitWith {
	diag_log "Error fn_getbuildings : No buildings found.";
	[]
};

private _buildingsArrayFiltered = [];

{
	private _keep = true;
	call {
		// check if bldg has any positions available for units
		if ((_x buildingPos -1) isEqualTo []) exitWith {_keep = false};
		// (optional) check if bldg has hostile units present
		if (!isNil "_sideHostile" && {([_x, _sideHostile] call d_fnc_isbldghostile)}) exitWith {_keep = false};
		// (optional) check if bldg has minimum number of positions TODO: check if positions are already occupied!!
		if (_minimumNumberOfPositions != 0 && {count (_x buildingPos -1) < _minimumNumberOfPositions}) exitWith {_keep = false};
	};
	if (_keep) then {
		_buildingsArrayFiltered pushBack _x;
	};
} forEach _buildingsArray;

_buildingsArrayFiltered
