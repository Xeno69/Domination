// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hdsmtcheck.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj"];
if (!alive _obj) exitWith {
	_obj removeAllEventHandlers "handleDamage";
	nil
};
if (!d_with_ace && {_this select 5 == 0 && {!isNull (_this select 6) && {(_this select 6) call d_fnc_isplayer}}}) then {
	_obj setVariable ["d_last_damager", _this select 6];
};
nil
