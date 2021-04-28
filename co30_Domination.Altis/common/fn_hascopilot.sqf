// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];

__TRACE_1("","_vec")

if (isNull _vec) exitWith {false};

private _tur = (configOf _vec) >> "turrets";
private _ret = false;

for "_i" from 0 to (count _tur - 1) do {
	private _etur = _tur select _i;

	if (getNumber(_etur >> "iscopilot") == 1) exitWith {
		_ret = true;
	};
};

_ret