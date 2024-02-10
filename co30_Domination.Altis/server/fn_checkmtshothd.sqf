// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

#ifdef __DEBUG__
_mm = toLowerANSI(getText(configFile>>"CfgAmmo">>(_this # 4)>>"simulation"));
__TRACE_1("","_mm")
#endif

params ["_obj"];
if (!alive _obj) exitWith {
	_obj removeAllEventHandlers "handleDamage";
	__TRACE_1("not alive","_obj")
};
private _r = if ((_this # 4) call d_fnc_checksimminet) then {
	(_this # 2) * 1.1
} else {
	0
};
__TRACE_1("","_r")
if (_r > 0) then {
	_obj setVariable ["d_damt", _r];
	
	if (!d_with_ace && {_this # 5 == 0 && {!isNull (_this # 6) && {isPlayer [_this # 6]}}}) then {
		_obj setVariable ["d_last_damager", _this # 6];
	};
} else {
	_r = _obj getVariable ["d_damt", 0];
	__TRACE_1("_r 2","_r")
};
_r