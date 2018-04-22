// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pshootatarti.sqf"
#include "..\..\x_setup.sqf"

private _shooter = param [6];
if (!isPlayer _shooter) exitWith {};

params ["_vec"];

if (time >= (_vec getVariable ["d_ncuttoft", 0])) then {
	diag_log format [localize "STR_DOM_MISSIONSTRING_1461", _shooter call d_fnc_getplayername, getPlayerUID _shooter];
	[format [localize "STR_DOM_MISSIONSTRING_1462", _shooter call d_fnc_getplayername], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
	_vec setVariable ["d_ncuttoft", time + 1];
};