// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeadd.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_name", "_code", ["_delta", 0], ["_type", "seconds"]];

_type = [1, 0] select (_type == "seconds");

if (_delta == 0 || {_type == 1}) then {
	d_ef_store setVariable [_name, [_code, _delta, -1, _type]];

	if (d_ef_running == -1) then {
		d_ef_running = addMissionEventhandler ["EachFrame", {call d_fnc_eachframerun}];
	};
} else {
	private _str_delta = str _delta;
	private _trig = d_ef_trig_store getVariable _str_delta;
	if (isNil "_trig") then {
		_trig = [
			[10, 10, 0],
			[0, 0, 0, false],
			["ANYPLAYER", "PRESENT", true],
			["thisTrigger call d_fnc_triggerrun;false", "", ""],
			_delta
		] call d_fnc_createtriggerlocal;
		_trig setVariable [_name, _code];
		d_ef_trig_store setVariable [_str_delta, _trig];
	} else {
		_trig setVariable [_name, _code];
	};
};