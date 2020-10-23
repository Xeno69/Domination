// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hanbuilddam.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];
if (!alive _obj) exitWith {
	_obj removeAllEventHandlers "handleDamage";
	__TRACE_1("not alive","_obj")
};

private _r = if (getText(configFile>>"CfgAmmo">>(_this # 4)>>"simulation") != "shotMissile") then {
	_this # 2
} else {
	0
};
__TRACE_1("","_r")
if (_r > 0) then {
	_obj setVariable ["d_damhd", _r];
} else {
	_r = _obj getVariable ["d_damhd", 0];
	__TRACE_1("_r 2","_r")
};
_r
