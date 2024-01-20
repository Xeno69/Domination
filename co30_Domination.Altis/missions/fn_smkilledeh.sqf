// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("killed","_this")
#ifndef __TT__
d_sm_winner = 2;
#else
private _killer = _this # 2;
if (isNull _killer) then {
	if (!d_with_ace) then {
		_killer = (_this # 0) getVariable ["d_last_damager", _killer];
	} else {
		_killer = (_this # 0) getVariable ["ace_medical_lastDamageSource", _killer];
	};
};
if (!isNull _killer && {isPlayer [_killer]}) then {
	if (side (group _killer) == opfor) then {
		d_sm_points_opfor = d_sm_points_opfor + 1000;
	} else {
		if (side (group _killer) == blufor) then {
			d_sm_points_blufor = d_sm_points_blufor + 1000;
		};
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
(_this # 0) removeAllEventHandlers "hit";
#endif
__TRACE_1("","d_sm_winner")
d_sm_resolved = true;
