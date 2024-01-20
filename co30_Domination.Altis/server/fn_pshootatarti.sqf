// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _shooter = _this # 6;
if !(isPlayer [_shooter]) exitWith {};

params ["_vec"];

if (time >= (_vec getVariable ["d_ncuttoft", 0])) then {
	private _whof = _vec getVariable "d_who_fired";
	private _aop = objNull;
	if (!isNil "_whof") then {
		_aop = objectFromNetId _whof;
		if (isNil "_aop") then {
			_aop = objNull;
		};
	};
	if (!isNull _aop && {_shooter == _aop}) exitWith {
		_vec setVariable ["d_ncuttoft", time + 2];
	};
	diag_log format [localize "STR_DOM_MISSIONSTRING_1461", name _shooter, getPlayerUID _shooter];
	[15, name _shooter] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
	_vec setVariable ["d_ncuttoft", time + 2];
};
