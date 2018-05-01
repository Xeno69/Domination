// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mtsmtargetkilled.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

d_side_main_done = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_side_main_done", true]] remoteExecCall ["setVariable", 2];
};
private _type = param [count _this - 1];
#ifdef __TT__
private _killer = param [2];
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
[40, _bluformsg, _opformsg] remoteExecCall ["d_fnc_DoKBMsg", 2];
if (!isNull _killer) then {
	[d_tt_points # 3, _killer] remoteExecCall ["d_fnc_addpoints", 2];
	private _killedby2 = call {
		if (_si == blufor) exitWith {"WEST"};
		if (_si == opfor) exitWith {"EAST"};
		"N"
	};
	if (_killedby2 != "N") then {
		[41, _killedby2] remoteExecCall ["d_fnc_DoKBMsg", 2];
	};
};
#else
[42, (["sec_over", _type] select (side (group (param [1])) == d_side_player)) call d_fnc_GetSMTargetMessage] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
if (d_database_found) then {
#ifndef __TT__
	private _killer = param [2];
#endif
	if (!isNil "_killer" && {!isNull _killer && {_killer call d_fnc_isplayer}}) then {
		[_killer, 3] remoteExecCall ["d_fnc_addppoints", 2];
	};
};
d_sec_kind = 0; publicVariable "d_sec_kind";