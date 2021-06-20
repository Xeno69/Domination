// by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

// get all buildings with positions (for unit garrison later)
// parameters: _pos
// parameters: radius
params ["_pos", "_radius"];

private _buildingsArrayRaw = nearestObjects [_pos, ["Building", "House"], _radius, true];
	
if (_buildingsArrayRaw isEqualTo []) exitWith {
	[]
};

private _buildingsArrayUsable = _buildingsArrayRaw select {(_x buildingPos -1) isNotEqualTo []};

if (_buildingsArrayUsable isEqualTo []) exitWith {
	[]
};

_buildingsArrayUsable