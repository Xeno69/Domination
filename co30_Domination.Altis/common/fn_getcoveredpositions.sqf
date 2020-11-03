//by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_getcoveredpositions.sqf"
#include "..\x_setup.sqf"

// get array of positions, return only positions that are covered (inside the building with walls on all sides)
// _posArray - array of positions

params ["_posArray"];

private _posArrayFiltered = [];

{
	lineIntersectsSurfaces [
		AGLToASL _x,
		AGLToASL _x vectorAdd [0, 0, 5],
		objNull, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if (!isNil "_house" && {_house isKindOf "House"}) then {
		lineIntersectsSurfaces [
			AGLToASL _x,
			AGLToASL _x vectorAdd [0, 5, 0],
			objNull, objNull, true, 1, "GEOM", "NONE"
		] select 0 params ["","","","_house2"];
		if (!isNil "_house2" && {_house2 isKindOf "House"}) then {
			lineIntersectsSurfaces [
				AGLToASL _x,
				AGLToASL _x vectorAdd [5, 0, 0],
				objNull, objNull, true, 1, "GEOM", "NONE"
			] select 0 params ["","","","_house3"];
			if (!isNil "_house3" && {_house3 isKindOf "House"}) then {
				_posArrayFiltered pushBack _x;
			};
		};
	};
} forEach _posArray;

_posArrayFiltered