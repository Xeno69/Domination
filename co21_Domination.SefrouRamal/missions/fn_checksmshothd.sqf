// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];

if (!alive _obj) exitWith {
	_obj removeAllEventHandlers "handleDamage";
	__TRACE_1("not alive","_obj")
};

if ((_this # 4) call d_fnc_checksimminet) then {
#ifdef __TT__
	private _u = _this # 6;
	if (!isNull _u && {_u call d_fnc_isplayer}) then {
		if (side (group _u) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group _u) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
	__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
#endif
	private _r = _this # 2;
	_obj setVariable ["d_damt1", _r];
	__TRACE_1("","_r")
	
	if (!d_with_ace && {_this # 5 == 0 && {!isNull (_this # 6) && {(_this # 6) call d_fnc_isplayer}}}) then {
		_obj setVariable ["d_last_damager", _this # 6];
	};
	_r
} else {
	(_obj getVariable ["d_damt1", 0])
}
