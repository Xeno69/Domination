// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("hit","_this")
private _obj = _this # 3;
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