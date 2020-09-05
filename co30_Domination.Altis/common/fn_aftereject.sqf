// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_aftereject.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_vec"];

if (!isNil {_vec getVariable "d_eject_check"}) exitWith {};

_vec setVariable ["d_eject_check", true];

_vec spawn {
	scriptName "spawn aftereject";
	sleep 20;
	if (!alive _this) exitWith {};

	if (_this animationPhase (getText ((configOf _this) >> "EjectionSystem" >> "CanopyHideAnim")) > 0.01) then {
		_this setDamage 1;
	} else {
		_this setVariable ["d_eject_check", nil];
	};
};
