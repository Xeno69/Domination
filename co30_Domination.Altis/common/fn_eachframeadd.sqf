// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeadd.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_name", "_code", ["_delta", 0], ["_type", "seconds"]];

_type = [1, 0] select (_type == "seconds");

if (_delta == 0 || {_type == 1}) then {
	if (isNil "d_ef_hash") then {
		d_ef_hash = createHashMap;
	};
	__TRACE("First")
	d_ef_hash set [_name, [_code, _delta, -1, _type]];

	if (d_ef_running == -1) then {
		d_ef_running = addMissionEventhandler ["EachFrame", {call d_fnc_eachframerun}];
	};
} else {
	if (isNil "d_ef_trig_hash") then {
		d_ef_trig_hash = createHashMap;
	};
	__TRACE("Second")
	if !(_delta in d_ef_trig_hash) then {
		private _trig = [
			[10, 10, 0],
			[0, 0, 0, false],
			["ANYPLAYER", "PRESENT", true],
			["thisTrigger call d_fnc_triggerrun;false", "", ""],
			_delta
		] call d_fnc_createtriggerlocal;
		_trig setVariable [_name, _code];
		d_ef_trig_hash set [_delta, _trig];
		__TRACE_1("1","_trig")
	} else {
		private _trig = d_ef_trig_hash get _delta;
		_trig setVariable [_name, _code];
		__TRACE_1("2","_trig")
	};
};
