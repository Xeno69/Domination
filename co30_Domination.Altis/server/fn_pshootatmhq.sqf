// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pshootatmhq.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

private _shooter = _this select 6;
__TRACE_1("","_shooter")
if (isNull _shooter) exitWith {};
if !(_shooter call d_fnc_isplayer) exitWith {};

params ["_vec"];

__TRACE_1("","_vec")

#ifdef __TT__
if ((_vec getVariable "d_side") != side (group _shooter)) exitWith {};
#endif

if (time >= (_vec getVariable ["d_ncuttoft", 0])) then {
	_vec setVariable ["d_ncuttoft", time + 2];
	
	if (isServer) then {
		[format [localize "STR_DOM_MISSIONSTRING_1834", _shooter call d_fnc_getplayername], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
		diag_log format [localize "STR_DOM_MISSIONSTRING_1833", _shooter call d_fnc_getplayername, getPlayerUID _shooter];
	} else {
		[format [localize "STR_DOM_MISSIONSTRING_1834", _shooter call d_fnc_getplayername], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg"];
	};
	_vec setVariable ["d_ncuttoft", time + 2];
};