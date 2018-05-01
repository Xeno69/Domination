// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkilledehsm.sqf"
#include "..\x_setup.sqf"
__TRACE_1("","_this")

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
#endif

_this addEventHandler ["killed", {
	__TRACE_1("killed","_this")
#ifndef __TT__
	d_sm_winner = 2;
#else
	if (side (group (param [2])) == opfor) then {
		d_sm_points_opfor = d_sm_points_opfor + 1000;
	} else {
		if (side (group (param [2])) == blufor) then {
			d_sm_points_blufor = d_sm_points_blufor + 1000;
		};
	};
	d_sm_winner = if (d_sm_points_blufor > d_sm_points_opfor) then {
		2
	} else {
		if (d_sm_points_opfor > d_sm_points_blufor) then {
			1
		} else {
			-1
		};
	};
	__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
	(param [0]) removeAllEventHandlers "hit";
#endif
	__TRACE_1("","d_sm_winner")
	d_sm_resolved = true;
	if (d_IS_HC_CLIENT) then {
		[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
		[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
	};
}];
_this addEventHandler ["handleDamage", {_this call d_fnc_CheckSMShotHD}];
#ifdef __TT__
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
d_x_sm_vec_rem_ar pushBack _this;