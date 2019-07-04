// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pshootatmhq.sqf"
#include "..\..\x_setup.sqf"

private _shooter = _this select 6;
if !(_shooter call d_fnc_isplayer) exitWith {};

params ["_vec"];

if (time >= (_vec getVariable ["d_ncuttoft", 0])) then {
	_vec setVariable ["d_ncuttoft", time + 2];
	
	diag_log format [localize "STR_DOM_MISSIONSTRING_1833", _shooter call d_fnc_getplayername, getPlayerUID _shooter];
	[format [localize "STR_DOM_MISSIONSTRING_1834", _shooter call d_fnc_getplayername], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
	_vec setVariable ["d_ncuttoft", time + 2];
};