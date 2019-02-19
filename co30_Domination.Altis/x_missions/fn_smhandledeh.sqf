// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_smhandledeh.sqf"
#include "..\x_setup.sqf"

__TRACE_1("handleDamage","_this")
private _obj = _this select 6;
if (!isNull _obj && {_this select 5 == 0 && {_obj call d_fnc_isplayer}}) then {
	if (!d_with_ace) then {
		(_this select 0) setVariable ["d_last_damager", _obj];
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