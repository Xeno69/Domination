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

// select buildings with positions
private _buildingsArrayUsableUnfiltered = _buildingsArrayRaw select {(_x buildingPos -1) isNotEqualTo []};

// do not select if inString with any string in the defined blacklist strings array
private _blacklist_building_strings = ["dyke"];
private _buildingsArrayUsableFiltered2 = _buildingsArrayUsableUnfiltered select {
	private _ret = true;
	private _the_bldg = _x;
	{
		if ([toLowerANSI _x, toLowerANSI (getModelInfo _the_bldg # 0)] call BIS_fnc_inString) exitWith { _ret = false; };
	} forEach _blacklist_building_strings;
	_ret
};

// do not select if exact model name matches with any string in the params or default blacklist array
private _buildingsArrayUsable = _buildingsArrayUsableFiltered2 select { !(getModelInfo _x # 0 in _blacklist) };

if (_buildingsArrayUsable isEqualTo []) exitWith {
	[]
};

_buildingsArrayUsable