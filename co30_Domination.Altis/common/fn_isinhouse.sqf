//by Killzone Kid and modified by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_isinhouse.sqf"
#include "..\x_setup.sqf"

// check if a position is inside a house (tests if intersections isKindOf "House" in several different directions)

// That line doesn't do anything
//if (count _housePos != 3) then { false; };

private _isInHouse = true;
private _testMeHorizontalPlane = [[6,3,0], [6,-3,0], [-6,3,0], [-6,-3,0], [0,0,50]];
{
	private _firstIntersectedItem = lineIntersectsSurfaces [
		_this,
		_this vectorAdd [_x select 0, _x select 1, _x select 2],
		objNull, objNull, true, 1, "GEOM", "NONE"
	];
	if !(((_firstIntersectedItem # 0) select 2) isKindOf "House") then {
		_isInHouse = false;
	}
} forEach _testMeHorizontalPlane;
_isInHouse
