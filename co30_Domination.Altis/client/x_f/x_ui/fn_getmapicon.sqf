// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getmapicon.sqf"
#include "..\..\..\x_setup.sqf"

params ["_v", "_u", ["_m", false]];
__TRACE_1("","_this")

private _i = _v getVariable (["d_ma_type", "d_icon_type"] select (!_m));
if (isNil "_i") then {
	_i = getText (configFile >>"CfgVehicles">>typeOf _v>>"icon");
	_v setVariable ["d_icon_type", _i];
};
__TRACE_1("","_i")
private _s = _v getVariable "d_icon_size";
if (isNil "_s") then {
	_s = if (_v isKindOf "Man") then {
		22
	} else {
		if (_v isKindOf "LandVehicle" || {_v isKindOf "Air"}) then {
			28
		} else {
			26 // Ship
		};
	};
	_v setVariable ["d_icon_size", _s];
};
__TRACE_1("","_i")

if (!_m) then {
	private _a = [0.7, 0.9] select (!isNull _u && {(group _u) isEqualTo (group player)});

#ifdef __OWN_SIDE_BLUFOR__
	private _c = [0, 0.3, 0.6, _a];
#endif
#ifdef __OWN_SIDE_OPFOR__
	private _c = [0.5, 0, 0, _a];
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	private _c = [0, 0.5, 0, _a];
#endif
#ifdef __TT__
	private _c = [0, 0.5, 0, _a];
#endif
	[_i, _s, _c]
} else {
#ifdef __DEBUG__
	_res = [_i, _s, _v getVariable "d_ma_color"];
	__TRACE_1("_res","")
#endif
	[_i, _s, _v getVariable "d_ma_color"]
};