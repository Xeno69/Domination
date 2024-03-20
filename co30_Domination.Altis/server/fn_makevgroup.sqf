// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_numvecs", "_pos", "_vname", "_grp", "_dir", ["_is_static", false], ["_nolift", false], ["_dyna", false], ["_nocargo", false]];
private _the_vecs = [];
private _crews = [];
private _npos = _pos;

__TRACE_1("","_this")

_the_vecs resize _numvecs;
private _nnvnum = _numvecs - 1;
for "_n" from 0 to _nnvnum do {
	__TRACE_1("","_npos")
	private _nnpos = _npos findEmptyPosition [0, 70, _vname];
	if (_nnpos isNotEqualTo []) then {_npos = _nnpos};
	private _vec_ar = [_npos, [floor random 360, _dir] select (_dir != -1.111), _vname, _grp, true, _nocargo] call d_fnc_spawnVehicle;
	_vec_ar params ["_vec"];
	_crews append (_vec_ar # 1);
	
	_the_vecs set [_n, _vec];
	if (_n < _nnvnum) then {
		_npos = _vec modelToWorld [0, -12, 0];
	};
	
	[_vec, 5] call d_fnc_setekmode;
	if (d_ai_persistent_corpses != 0) then {
		addToRemainsCollector [_vec];
	};
	
	if (_dyna && {d_with_dynsim == 0 && {!unitIsUAV _vec}}) then {
		[_vec] spawn d_fnc_enabledynsim;
	};
	
	private _is_locked = false;
	if (_vec isKindOf "Tank") then {
		if (d_LockArmored == 0) then {
			_vec lock true;
			_is_locked = true;
		};
	} else {
		if (_vec isKindOf "Wheeled_APC" || {_vec isKindOf "Wheeled_APC_F" || {_vec isKindOf "Car"}}) then {
			if (d_LockCars == 0) then {
				_vec lock true;
				_is_locked = true;
			};
		} else {
			if (_vec isKindOf "Air") then {
				if (d_LockAir == 0) then {
					_vec lock true;
				};
				_is_locked = true; // always set to true as air vehicles can't be lifted
			};
		};
	};
	if (!_is_locked && {!_is_static && {d_enemy_vecs_lift == 0 && {!_nolift}}}) then {
		_vec setVariable ["d_liftit", true, true];
	};
};
[_the_vecs, _crews]