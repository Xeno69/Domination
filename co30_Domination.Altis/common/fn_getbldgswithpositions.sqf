// by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// TODO - add sideHostile check here, deprecate fn_getbuildings.sqf
// get all buildings with positions (for unit garrison later)
// parameters: _pos
// parameters: _radius
// parameters: _blacklist (optional, array of building classes to filter out of the result)
params ["_pos", "_radius", ["_blacklist", d_object_spawn_blacklist_common]];

if (_radius isEqualType objNull) then {
	_radius = -1;
};

private _buildingsArrayRaw = nearestObjects [_pos, ["Building", "House"], _radius, true];
	
if (_buildingsArrayRaw isEqualTo []) exitWith {
	[]
};

private _buildingsArrayUsableUnfiltered = _buildingsArrayRaw select {(_x buildingPos -1) isNotEqualTo []};

private _buildingsArrayUsable = _buildingsArrayUsableUnfiltered select { !(getModelInfo _x # 0 in _blacklist) };

if (_buildingsArrayUsable isEqualTo []) exitWith {
	[]
};

_buildingsArrayUsable