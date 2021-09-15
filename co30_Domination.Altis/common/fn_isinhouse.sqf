//by Killzone Kid and modified by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// check if a position is inside a house (tests if intersections isKindOf "House" in several different directions)

private _is_in_house = true;
private _test_vector_endpoints = [[6,3,0], [6,-3,0], [-6,3,0], [-6,-3,0], [0,0,50]];
private _eye_height = 1.53;
private _position_under_test_plus_eyeheight = [_this # 0, _this # 1, (_this # 2) + _eye_height];
{
	private _first_intersected_item = lineIntersectsSurfaces [
		_position_under_test_plus_eyeheight,
		_position_under_test_plus_eyeheight vectorAdd _x,
		objNull, objNull, true, 1, "GEOM", "NONE"
	];
	private _fii = (_first_intersected_item # 0) select 2;
	if (isNil "_fii" || {!(_fii isKindOf "House")}) exitWith {
		_is_in_house = false;
	};
} forEach _test_vector_endpoints;
_is_in_house
