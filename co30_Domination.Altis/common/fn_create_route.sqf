// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params [["_sector", 0]]; // 0 = west/east sector, 1 = north/south sector, 2 = 4 sectors, sw-ns-ne-se

private _alltargetsar =+ d_target_names;
#ifndef __TT__
private _firstpoint = getPosASL d_FLAG_BASE;
#else
private _firstpoint = d_island_center;
#endif

private _route_ar = [];

private _half = (d_island_center # 0) / 2;
private _area = call {
	if (_sector == 0) exitWith {
		[
			[[_half, d_island_center # 0], _half, d_island_center # 0, 0, true],
			[[_half + d_island_center # 0, d_island_center # 0], _half, d_island_center # 0, 0, true]
		]
	};
	if (_sector == 1) exitWith {
		[
			[[d_island_center # 0, _half], d_island_center # 0, _half, 0, true],
			[[d_island_center # 0, _half + d_island_center # 0], d_island_center # 0, _half, 0, true]
		]
	};
	[
		[[_half, _half], _half, _half, 0, true],
		[[_half, _half + d_island_center # 0], _half, _half, 0, true],
		[[_half + d_island_center # 0, _half + d_island_center # 0], _half, _half, 0, true],
		[[_half + d_island_center # 0, _half], _half, _half, 0, true]
	]
};

/*{
	diag_log [_x, _forEachIndex];
	[format ["d_areamar_%1", _forEachIndex], _x # 0, "RECTANGLE", "ColorOrange", [_x # 1, _x # 2]] call d_fnc_createMarkerLocal;
} forEach _area;
*/

private _area_ar = [[[], [], [], []], [[], []]] select (_sector < 2);

{
	private _cur = _x;
	(_area_ar # (_area findIf {(_cur # 0) inArea _x})) pushBack _x;
} forEach _alltargetsar;

private _whicharea = _area findIf {_firstPoint inArea _x};
if (_whicharea == -1) then {_whicharea = 0};
private _num_areas = count _area;
private _areas_done = 0;

while {true} do {
	private _cur_ar = _area_ar # _areas_done;
	while {_cur_ar isNotEqualTo []} do {
		private _curdistance = 100000000;
		private _curclosest = -1;
		{
			private _dist = _firstpoint distance2D (_x # 0);
			if (_dist < _curdistance) then {
				_curdistance = _dist;
				_curclosest = _forEachIndex;
			};
		} forEach _cur_ar;

#ifdef __DEBUG__
		[_firstpoint, _cur_ar # _curclosest # 0, format ["d_dtarline_%1", _cur_ar # _curclosest # 3], 20] call d_fnc_linemaker2;
#endif
		
		_route_ar pushBack (_cur_ar # _curclosest # 3);
		_firstpoint = _cur_ar # _curclosest # 0;
		_cur_ar deleteAt _curclosest;
	};
	_areas_done = _areas_done + 1;
	if (_areas_done == _num_areas) exitWith {};
};

_route_ar