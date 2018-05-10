// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_getwparray.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")
params ["_tc", "_radius","_mode", ["_sizem", 2], ["_maxgrad", 0.7], ["_gradar", 4]];
private _wfunc = if (_mode isEqualTo 0) then {
	d_fnc_GetRanPointCircle
} else {
	d_fnc_GetRanPointCircleOuter
};
private _wp_a = [];
_wp_a resize 100;
for "_i" from 0 to 99 do {
	private _point = [_tc, _radius, _sizem, _maxgrad, _gradar] call _wfunc;
	if (_point isEqualTo []) then {
		for "_e" from 0 to 99 do {
			_point = [_tc, _radius, _sizem, _maxgrad, _gradar] call _wfunc;
			if !(_point isEqualTo []) exitWith {
				_wp_a set [_i, _point];
#ifdef __DEBUG__
				[str _point, _point, "ICON", "ColorBlue", [0.5, 0.5], "", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
			};
		};
		if (_point isEqualTo []) then {
			_wp_a set [_i, _tc];
#ifdef __DEBUG__
			[str _tc, _tc, "ICON", "ColorBlue", [0.5, 0.5], "", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
		};
	} else {
		_wp_a set [_i, _point];
#ifdef __DEBUG__
		[str _point, _point, "ICON", "ColorBlue", [0.5, 0.5], "", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
	};
};
_wp_a