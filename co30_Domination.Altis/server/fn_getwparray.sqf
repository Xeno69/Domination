// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getwparray.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")
params ["_tc", "_radius","_mode", ["_sizem", 1], ["_maxgrad", 0.7], ["_blacklist", false]];
private _wfunc = if (_mode isEqualTo 0) then {
	d_fnc_GetRanPointCircle
} else {
	d_fnc_GetRanPointCircleOuter
};
private _wp_a = [];
private _blackl = [];
_wp_a resize 60;
for "_i" from 0 to 59 do {
	private _point = [_tc, _radius, _sizem, _maxgrad, 0, false, false, _blackl] call _wfunc;
	if (_point isEqualTo []) then {
		for "_e" from 0 to 49 do {
			_point = [_tc, _radius, _sizem, _maxgrad, 0, false, false, _blackl] call _wfunc;
			if !(_point isEqualTo []) exitWith {
				_wp_a set [_i, _point];
				if (_blacklist) then {
					_blackl pushBack [_point, _sizem, _sizem, 0, false];
				};
#ifdef __DEBUG__
				if (isNil "d_mmmcoui") then {
					d_mmmcoui = 0;
				};
				d_mmmcoui = d_mmmcoui + 1;
				[format ["d_gwpa_%1", d_mmmcoui], _point, "ICON", "ColorBlue", [0.5, 0.5], str d_mmmcoui, 0, "hd_dot"] call d_fnc_CreateMarkerLocal;
#endif
			};
		};
		if (_point isEqualTo []) then {
			_wp_a set [_i, _tc];
			if (_blacklist) then {
				_blackl pushBack [_tc, _sizem, _sizem, 0, false];
			};
#ifdef __DEBUG__
			if (isNil "d_mmmcoui") then {
				d_mmmcoui = 0;
			};
			d_mmmcoui = d_mmmcoui + 1;
			[format ["d_gwpa_%1", d_mmmcoui], _tc, "ICON", "ColorBlue", [0.5, 0.5], str d_mmmcoui, 0, "hd_dot"] call d_fnc_CreateMarkerLocal;
#endif
		};
	} else {
		_wp_a set [_i, _point];
		if (_blacklist) then {
			_blackl pushBack [_point, _sizem, _sizem, 0, false];
		};
#ifdef __DEBUG__
		if (isNil "d_mmmcoui") then {
			d_mmmcoui = 0;
		};
		d_mmmcoui = d_mmmcoui + 1;
		[format ["d_gwpa_%1", d_mmmcoui], _point, "ICON", "ColorBlue", [0.5, 0.5], str d_mmmcoui, 0, "hd_dot"] call d_fnc_CreateMarkerLocal;
#endif
	};
};
_wp_a
