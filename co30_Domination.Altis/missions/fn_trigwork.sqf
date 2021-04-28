// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_trig", "_mode"];

private _objs = _trig getVariable "d_objs";

if (isNil "_objs") exitWith {};

if (_mode == 0) then {
	{
		if (alive _x) then {
			_x setDamage 0;
		};
		_x allowDamage true;
	} forEach _objs;
} else {
	{
		if (alive _x) then {
			_x allowDamage false;
		};
	} forEach _objs;
};
