// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_unit", "_vtype", "_b_mode"];
private _pos = getPosATL _unit;
private _npos = _pos findEmptyPosition [0, 50, _vtype];
if (_npos isNotEqualTo []) then {_pos = _npos};
private _vec = createVehicle [_vtype, _pos, [], 0, "NONE"];
_vec setDir direction _unit;
_vec remoteExecCall ["d_fnc_stocbike", _unit];
if (d_with_dynsim == 0) then {
	[_vec, 5] spawn d_fnc_enabledynsim;
};
if (_b_mode != 1) then {
	_vec setVariable ["d_end_time", time + 1200];
	d_player_created pushBack _vec;
} else {
	private _ar = _unit getVariable ["d_all_p_vecs_s", []];
	if (_ar isNotEqualTo []) then {
		_ar = _ar - [objNull];
	};
	_ar pushBack _vec;
	_unit setVariable ["d_all_p_vecs_s", _ar];
};
if (isNil {_vec getVariable "d_cwcg_inited"}) then {
	if (d_with_ranked) then {
		clearWeaponCargoGlobal _vec;
	};
	clearBackpackCargoGlobal _vec;
};
addToRemainsCollector [_vec];