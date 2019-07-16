// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_doslope.sqf"
#include "..\x_macros.sqf"

params ["_pos", "_sl", "_unit"];
private _rad = 0; private _found = false;
while {_sl >= 0.78} do {
	_rad = _rad + 10;
	for "_ang" from 0 to 345 step 15 do {
		private _npos = _pos getPos [_rad, _ang];
		_npos set [2, 0];
		_sl = [_npos, 1] call d_fnc_GetSlope;
		if (_sl < 0.78) exitWith {
			_pos = _npos;
			_found = true;		
		};
	};
	if (_found) exitWith {};
};
if (_found) then {_unit setPos [_pos # 0, _pos # 1, _unit distance _pos]};