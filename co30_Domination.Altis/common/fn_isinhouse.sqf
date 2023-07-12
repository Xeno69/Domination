//by Killzone Kid and modified by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// check if a position is inside a house (tests if intersections isKindOf "House" in several different directions)

/*private _is_in_house = true;
private _test_vector_endpoints = [[6,3,0], [6,-3,0], [-6,3,0], [-6,-3,0], [0,0,50]];
private _eye_height = 1.53;
private _unit = _this;
private _unit_pos = getPosATL(_unit);
private _position_under_test_plus_eyeheight = AGLToASL ([_unit_pos # 0, _unit_pos # 1, (_unit_pos # 2 + _eye_height)]);
private _acceptable_failures_remaining = 2;

{
	private _first_intersected_item = lineIntersectsSurfaces [
		_position_under_test_plus_eyeheight,
		_position_under_test_plus_eyeheight vectorAdd _x,
		_unit, _unit, true, 1, "GEOM", "NONE"
	];
	private _fii = (_first_intersected_item # 0) select 2;
	if (isNil "_fii" || {!(_fii isKindOf "House")}) then {
		if (_x isEqualTo [0,0,50]) exitWith {
			_is_in_house = false;
		};
		if (_acceptable_failures_remaining == 0) exitWith {
			// the vertical vector check [0,0,50] must pass and it failed OR the loop exceeded 2 vector failures
			_is_in_house = false;
		};
		// some failed vector checks are ok
		_acceptable_failures_remaining = _acceptable_failures_remaining - 1;
	};
} forEach _test_vector_endpoints;
_is_in_house
*/

// NOTE - neither the old code nor the new insideBuilding function seem to work correctly, might not want to use it

insideBuilding _this == 1
