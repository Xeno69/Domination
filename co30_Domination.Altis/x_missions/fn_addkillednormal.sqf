// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkillednormal.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;

_this addEventhandler ["handleDamage", {
	__TRACE_1("handleDamage","_this")
	private _obj = param [6];
	if (!isNull _obj && {param [5] == 0 && {_obj call d_fnc_isplayer}}) then {
		if (!d_with_ace) then {
			(param [0]) setVariable ["d_last_damager", _obj];
		};
		if (side (group _obj) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group _obj) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
	__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
}];

_this addEventHandler ["hit", {
	__TRACE_1("hit","_this")
	private _obj = param [3];
	if (!isNull _obj && {_obj call d_fnc_isplayer}) then {
		if (side (group _obj) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group _obj) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
	__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
}];
#endif

_this addEventhandler ["killed", {_this call d_fnc_KilledSMTargetNormal}];