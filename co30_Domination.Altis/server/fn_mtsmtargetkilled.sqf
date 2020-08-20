// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mtsmtargetkilled.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

d_side_main_done = true;
private _type = _this select (count _this - 1);
private _killer = _this # 2;
if (isNull _killer) then {
	if (!d_with_ace) then {
		_killer = (_this # 0) getVariable ["d_last_damager", _killer];
	} else {
		_killer = (_this # 0) getVariable ["ace_medical_lastDamageSource", _killer];
	};
};
#ifdef __TT__
private _si = side (group _killer);
__TRACE_3("","_type","_killer","_si")
if !(_si in [blufor, opfor]) then {_type = "sec_over"};
private _s = _type call d_fnc_GetSMTargetMessage;
private ["_bluformsg", "_opformsg"];
if (_type != "sec_over") then {
	_bluformsg = [localize "STR_DOM_MISSIONSTRING_962", _s] select (_si == blufor);
	_opformsg = [localize "STR_DOM_MISSIONSTRING_962", _s] select (_si == opfor);
} else {
	_bluformsg = _s;
	_opformsg = _s;
};
[40, _bluformsg, _opformsg] call d_fnc_DoKBMsg;
if (!isNull _killer) then {
	[d_tt_points # 3, _killer] call d_fnc_addpoints;
	private _killedby2 = call {
		if (_si == blufor) exitWith {"WEST"};
		if (_si == opfor) exitWith {"EAST"};
		"N"
	};
	if (_killedby2 != "N") then {
		[41, _killedby2] call d_fnc_DoKBMsg;
	};
};
#else
[42, (["sec_over", _type] select (d_side_player getFriend side (group _killer) >= 0.6)) call d_fnc_GetSMTargetMessage] call d_fnc_DoKBMsg;
#endif
if (d_database_found) then {
	if (!isNil "_killer" && {!isNull _killer && {_killer call d_fnc_isplayer}}) then {
		[_killer, 3] call d_fnc_addppoints;
	};
};
d_sec_kind = 0; publicVariable "d_sec_kind";