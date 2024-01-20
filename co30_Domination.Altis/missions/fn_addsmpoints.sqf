// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!alive (_this # 0)) exitWith {
	(_this # 0) removeAllEventHandlers "handleDamage";
	if (!isNull (_this # 6) && {isPlayer [_this # 6]}) then {
		if (side (group (_this # 6)) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group (_this # 6)) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
};

if (_this # 1 == "" && {!isNull (_this # 6) && {isPlayer [_this # 6]}}) then {
	if (side (group (_this # 6)) == opfor) then {
		d_sm_points_opfor = d_sm_points_opfor + 1;
	} else {
		if (side (group (_this # 6)) == blufor) then {
			d_sm_points_blufor = d_sm_points_blufor + 1;
		};
	};
};
__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")