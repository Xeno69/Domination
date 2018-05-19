// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addsmpoints.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!alive (_this select 0)) exitWith {
	(_this select 0) removeAllEventHandlers "handleDamage";
	if (!isNull (_this select 6) && {(_this select 6) call d_fnc_isplayer}) then {
		if (side (group (_this select 6)) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			if (side (group (_this select 6)) == blufor) then {
				d_sm_points_blufor = d_sm_points_blufor + 1;
			};
		};
	};
};

if (_this select 1 == "" && {!isNull (_this select 6) && {(_this select 6) call d_fnc_isplayer}}) then {
	if (side (group (_this select 6)) == opfor) then {
		d_sm_points_opfor = d_sm_points_opfor + 1;
	} else {
		if (side (group (_this select 6)) == blufor) then {
			d_sm_points_blufor = d_sm_points_blufor + 1;
		};
	};
};
__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")