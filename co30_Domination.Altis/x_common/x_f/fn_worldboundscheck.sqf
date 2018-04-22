// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_worldboundscheck.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

private _pos = _this;
if (_pos isEqualTo []) exitWith {
	_pos;
};
if (_pos # 0 < 0) then {
	_pos set [0, 400];
} else {
	if (_pos # 0 > (d_island_x_max - 2)) then {
		_pos set [0, d_island_x_max - 400];
	};
};
if (_pos # 1 < 0) then {
	_pos set [1, 400];
} else {
	if (_pos # 1 > (d_island_y_max - 2)) then {
		_pos set [1, d_island_y_max - 400];
	};
};
__TRACE_1("","_pos")
_pos