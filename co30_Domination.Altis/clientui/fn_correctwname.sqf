// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

d_weap_hash getOrDefaultCall [_this, {
	private _ar = _this splitString "_";
	//__TRACE_1("_ar 1","_ar")

	private ["_i", "_s"];
	{
		_s = _x;
		_i = _ar findIf {_x == _s};
		if (_i > -1) then {
			_ar deleteAt _i;
		};
	} forEach ["pointer", "Hamr", "bipod", "arco", "snds", "holo", "Holo", "fl", "ACO", "SOS", "RCO", "DMS", "ARCO", "MRCO", "pointg", "Nstalker", "Loaded", "grip", "grip1", "grip2", "grip3", "grip4", "afg", "npz", "bayo"];

	//__TRACE_1("_ar 2","_ar")

	_ar joinString "_";
}, true];
