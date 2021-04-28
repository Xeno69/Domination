/**
 * Check if the _entity is placed on either of Freedom, Nimitz or CUP LHD and if so, place it on the deck.
 * The curatorCamera point of view is used to determine if the view intersects with any of the carrier lods.
 * by TeTeT
 */

params ["_curator", "_entity"];
private _objects = lineIntersectsSurfaces [getPosASL curatorCamera, getPosASL _entity, curatorCamera, _entity];
{
	_x params ["_isectPos", "", "_isectObj", ""];
	// systemChat str typeOf _isectObj;
	// Freedom support
	if ("land_carrier_01" in tolowerANSI(typeOf _isectObj)) exitWith {
		systemChat "Freedom class found";
		[_entity, _isectPos] call d_curatorcv_fnc_adjustEntity;
	};
	// Nimitz support
	if ("jdg_carrier" in tolowerANSI(typeOf _isectObj)) exitWith {
		systemChat "Nimitz class found";
		[_entity, _isectPos] call d_curatorcv_fnc_adjustEntity;
	};
	// LHD support
	if ("cup_lhd" in tolowerANSI(typeOf _isectObj)) exitWith {
		systemChat "LHD class found";
		[_entity, _isectPos] call d_curatorcv_fnc_adjustEntity;
	};
} forEach _objects;
_entity;
