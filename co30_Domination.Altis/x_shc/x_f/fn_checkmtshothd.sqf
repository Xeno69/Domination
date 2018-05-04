// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkmtshothd.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];
if (!alive _obj) exitWith {
	_obj removeAllEventHandlers "handleDamage";
};
#ifdef __DEBUG__
_mm = toUpper(getText(configFile>>"CfgAmmo">>(param [4])>>"simulation"));
__TRACE_1("","_mm")
#endif
private _r = if (d_MTTowerSatchelsOnly == 1 || {(param [4]) call d_fnc_checksimminet}) then {
	param [2]
} else {
	0
};
__TRACE_1("_r new","_r")
if (_r > 0) then {
	private _val = _obj getVariable ["d_damt", 0];
	__TRACE_1("","_val")
	if (_val > 0) then {_r = _r + _val};
	_obj setVariable ["d_damt", _r];
	__TRACE_1("_r result","_r")
	
	if (!d_with_ace && {param [5] == 0 && {!isNull (param [6]) && {(param [6]) call d_fnc_isplayer}}}) then {
		_obj setVariable ["d_last_damager", param [6]];
	};
};
_r