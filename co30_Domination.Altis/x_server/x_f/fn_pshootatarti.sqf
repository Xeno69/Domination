// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pshootatarti.sqf"
#include "..\..\x_setup.sqf"

private _shooter = _this select 6;
if !(_shooter call d_fnc_isplayer) exitWith {};

params ["_vec"];

if (time >= (_vec getVariable ["d_ncuttoft", 0])) then {
	private _whof = _vec getVariable "d_who_fired";
	private _aop = objNull;
	if (!isNil "_whof") then {
		_aop = missionNamespace getVariable _whof;
		if (isNil "_aop") then {
			_aop = objNull;
		};
	};
	if (!isNull _aop && {_shooter == _aop}) exitWith {
		_vec setVariable ["d_ncuttoft", time + 2];
	};
	diag_log format [localize "STR_DOM_MISSIONSTRING_1461", _shooter call d_fnc_getplayername, getPlayerUID _shooter];
	[format [localize "STR_DOM_MISSIONSTRING_1462", _shooter call d_fnc_getplayername], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
	_vec setVariable ["d_ncuttoft", time + 2];
};