// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_obj"];

private _origdir = getDir _obj;
private _dir = _origdir;
private _posasl = getPosASL _obj;
_posasl set [2, (_posasl # 2) + 1];

private _c = 1;
while {true} do {
	private _posmodelw = _obj modelToWorld [0, 10, 0];
	_posmodelw = AGLToASL _posmodelw;
	_posmodelw set [2, _posasl # 2];
	if !(lineIntersects [_posasl, _posmodelw, _obj]) exitWith {};
	_c = _c + 1;
	if (_c == 12) exitWith {
		_dir = _origdir;
		_obj setDir _dir;
		_obj setFormDir _dir;
	};
	_dir = _dir + 30;
	_obj setDir _dir;
	_obj setFormDir _dir;
};

