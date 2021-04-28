// by samatra
//#define __DEBUG__
#define THIS_FILE "fn_iscopilot.sqf"
#include "..\x_setup.sqf"

params ["_vec", "_unit"];

private _trts = (configOf _vec) >> "turrets";
private _ret = false;

for "_i" from 0 to (count _trts - 1) do {
	private _trt = _trts select _i;

	if (getNumber(_trt >> "iscopilot") == 1) exitWith {
		_ret = _vec turretUnit [_i] == _unit;
	};
};

_ret
