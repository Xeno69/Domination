/**
 * Check if the _entity is placed on either of Freedom, Nimitz or CUP LHD and if so, place it on the deck.
 * The curatorCamera point of view is used to determine if the view intersects with any of the carrier lods.
 * by TeTeT
 */

params ["_curator", "_entity"];
private _objects = lineIntersectsSurfaces [getPosASL curatorCamera, getPosASL _entity, curatorCamera, _entity];
{
	_x params ["_isectPos", "_surfNormal", "_isectObj", "_parObj"];
	// systemChat str typeOf _isectObj;
	// Freedom support
	if (tolowerANSI(typeOf _isectObj) find "land_carrier_01" != -1) exitWith {
		systemChat "Freedom class found";
		[_entity, _isectPos] call d_curatorcv_fnc_adjustEntity;
	};
	// Nimitz support
	if (tolowerANSI(typeOf _isectObj) find "jdg_carrier" != -1) exitWith {
		systemChat "Nimitz class found";
		[_entity, _isectPos] call d_curatorcv_fnc_adjustEntity;
	};
	// LHD support
	if (tolowerANSI(typeOf _isectObj) find "cup_lhd" != -1) exitWith {
		systemChat "LHD class found";
		[_entity, _isectPos] call d_curatorcv_fnc_adjustEntity;
	};

} forEach _objects;
_entity;
