// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_unit", "_obj", "_score"];

private _d_vec = _obj getVariable "d_vec";
#ifndef __TT__
if (!isNil "_d_vec") exitWith {
	__TRACE_1("_d_vec nicht nil","_score")
	false
};
if (isPlayer _obj) exitWith {
	__TRACE_2("Another player","_obj","_score")
	false
};
#else
if (!isNil "_d_vec" && {side (group _unit) == blufor && {_d_vec < 1000} || {side (group _unit) == opfor && {_d_vec >= 1000}}}) exitWith {
	__TRACE_1("_d_vec nicht nil","_score")
	false
};
#endif
if (_obj isKindOf "ParachuteBase") exitWith {
	__TRACE_1("No score - killed unit was parachute","_score")
	false
};

private _ret = true;
if (_score > 0 && {_unit distance2D d_cur_tgt_pos < d_mttarget_radius_patrol}) then {
	if (isNull objectParent _unit) then {
		_unit addScore (_score * 2);
	} else {
		if (random 100 > 50) then {
			_ret = false;
		};
	};
};

_ret
