// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_v", "_u", ["_m", false]];
__TRACE_1("","_this")

private _rr = _v getVariable "d_v_not_m";
if (!isNil "_rr") exitWith {
	_rr
};

private _i = _v getVariable (["d_ma_type", "d_icon_type"] select (!_m));
if (isNil "_i") then {
	_i = getText ((configOf _v)>>"icon");
	_v setVariable ["d_icon_type", _i];
};
__TRACE_1("","_i")
private _s = _v getVariable "d_icon_size";
if (isNil "_s") then {
	_s = call {
		if (_v isKindOf "Man") exitWith {
			22
		};
		if (_v isKindOf "LandVehicle" || {_v isKindOf "Air"}) exitWith {
			28
		};
		26 // Ship
	};
	_v setVariable ["d_icon_size", _s];
};
__TRACE_1("","_i")

if (!_m) exitWith {
	//private _a = [0.7, 0.9] select (!isNull _u && {(group _u) isEqualTo (group player)});

#ifdef __OWN_SIDE_BLUFOR__
	private _c = [0, 0.3, 0.6, 0.9];
#endif
#ifdef __OWN_SIDE_OPFOR__
	private _c = [0.5, 0, 0, 0.9];
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	private _c = [0, 0.5, 0, 0.9];
#endif
#ifdef __TT__
	private _c = [0, 0.5, 0, 0.9];
#endif
	private _r = [_i, _s, _c];
	_v setVariable ["d_v_not_m", _r];
	_r
};
#ifdef __DEBUG__
_res = [_i, _s, _v getVariable "d_ma_color"];
__TRACE_1("","_res")
#endif
private _r = [_i, _s, _v getVariable "d_ma_color"];
_v setVariable ["d_v_not_m", _r];
_r
