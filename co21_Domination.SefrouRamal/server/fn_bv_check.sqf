// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_obj", "", "_insti"];

#ifndef __TT__
if !(vehicle _insti inArea d_base_array && {_obj inArea d_base_array}) exitWith {};
#else
private _c1 = vehicle _insti inArea (d_base_array # 0) && {_obj inArea (d_base_array # 0)};
private _c2 = vehicle _insti inArea (d_base_array # 1) && {_obj inArea (d_base_array # 1)};
if (!_c1 && !_c2) exitWith {};
#endif

if (isNil {_obj getVariable "d_gvecs"}) then {
	private _bks = _insti getVariable ["d_ba_ki", []];
	__TRACE_1("","_bks")
	if (_bks isEqualTo []) then {
		_insti setVariable ["d_ba_ki", [1, time, 0]];
	} else {
		private _nsecs = time - (_bks # 1) + (_bks # 2);
		__TRACE_1("","_nsecs")
		if (_nsecs > 180) then {
			_insti setVariable ["d_ba_ki", [1, time, 0]];
			__TRACE("Reset")
		} else {
			private _nval = (_bks # 0) + 1;
			__TRACE_1("","_nval")
			if (_nval == 2) then {
				__TRACE("Kick")
				[_insti, name _insti, 99] call d_fnc_kickplayerbs;
			} else {
				_insti setVariable ["d_ba_ki", [_nval, time, _nsecs]];
				__TRACE("Add")
			};
		};
	};
};
