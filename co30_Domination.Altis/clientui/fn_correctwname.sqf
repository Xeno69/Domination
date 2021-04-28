// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _cname = d_weap_hash getOrDefault [_this, ""];
__TRACE_1("1","_cname")

if (_cname isEqualTo "") then {
	private _ar = _this splitString "_";
	__TRACE_1("_ar 1","_ar")

	private ["_i", "_s"];
	{
		_s = _x;
		_i = _ar findIf {_x == _s};
		if (_i > -1) then {
			_ar deleteAt _i;
		};
	} forEach ["pointer", "Hamr", "bipod", "arco", "snds", "holo", "Holo", "fl", "ACO", "SOS", "RCO", "DMS", "ARCO", "MRCO", "pointg", "Nstalker", "Loaded", "grip", "grip1", "grip2", "grip3", "grip4", "afg", "npz"];

	__TRACE_1("_ar 2","_ar")

	_cname = _ar joinString "_";
	d_weap_hash set [_this, _cname];
};

__TRACE_1("2","_cname")

_cname