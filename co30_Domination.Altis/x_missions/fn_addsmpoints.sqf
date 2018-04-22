// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addsmpoints.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!alive (param [0])) exitWith {
	(param [0]) removeAllEventHandlers "handleDamage";
	if (!isNull param [6] && {isPlayer param [6]}) then {
		if (side (group param [6]) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group param [6]) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
};

if (param [1] == "" && {!isNull param [6] && {isPlayer param [6]}}) then {
	if (side (group param [6]) == opfor) then {
		d_sm_points_opfor = d_sm_points_opfor + 1;
	} else {
		if (side (group param [6]) == blufor) then {
			d_sm_points_blufor = d_sm_points_blufor + 1;
		};
	};
};
__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")