// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checksmshothd.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!alive (param [0])) exitWith {
	(param [0]) removeAllEventHandlers "handleDamage";
};

if ((param [4]) call d_fnc_checksimminet) then {
#ifdef __TT__
	private _obj = param [6];
	if (!isNull _obj && {isPlayer _obj}) then {
		if (side (group _obj) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group _obj) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
	__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
#endif
	param [2]
} else {
	0
}
