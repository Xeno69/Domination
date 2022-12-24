//by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// check if an AGL position is covered overhead by a house (test vertically if intersection isKindOf "House")
private _pos = AGLToASL _this;
private _is_covered = false;
private _first_intersected_item = lineIntersectsSurfaces [
	_pos,
	_pos vectorAdd [0,0,50],
	objNull, objNull, true, 1, "GEOM", "NONE"
];
private _fii = (_first_intersected_item # 0) select 2;
if (!isNil "_fii" && {(_fii isKindOf "House")}) then {
	_is_covered = true;
};
_is_covered
