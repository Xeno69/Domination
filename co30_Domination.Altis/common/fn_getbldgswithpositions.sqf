// by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// get all buildings with positions (for unit garrison later)
// parameters: _pos
// parameters: radius
params ["_pos", "_radius"];

if (_radius isEqualType objNull) then {
	_radius = -1;
};

private _buildingsArrayRaw = nearestObjects [_pos, ["Building", "House"], _radius, true];
	
if (_buildingsArrayRaw isEqualTo []) exitWith {
	[]
};

private _buildingsArrayUsableUnfiltered = _buildingsArrayRaw select {(_x buildingPos -1) isNotEqualTo []};

private _buildingsArrayUsable = _buildingsArrayUsableUnfiltered select { !(getModelInfo _x # 0 in d_object_spawn_blacklist) };

if (_buildingsArrayUsable isEqualTo []) exitWith {
	[]
};

_buildingsArrayUsable