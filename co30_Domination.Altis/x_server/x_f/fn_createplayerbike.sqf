// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createplayerbike.sqf"
#include "..\..\x_setup.sqf"

params ["_unit", "_vtype", "_b_mode"];
private _pos = getPosATL _unit;
private _vec = createVehicle [_vtype, _pos, [], 0, "NONE"];
_vec setDir direction _unit;
//_vec setPos _pos;
_vec remoteExecCall ["d_fnc_stocbike", _unit];
if (_b_mode != 1) then {
	//_vec setVariable ["d_end_time", param [3]];
	_vec setVariable ["d_end_time", time + 1200];
	d_player_created pushBack _vec;
} else {
	private _ar = _unit getVariable ["d_all_p_vecs_s", []];
	if !(_ar isEqualTo []) then {
		_ar = _ar - [objNull];
	};
	_ar pushBack _vec;
	_unit getVariable ["d_all_p_vecs_s", _ar];
};
addToRemainsCollector [_vec];