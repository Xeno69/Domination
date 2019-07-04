// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_casfired.sqf"
#include "..\..\x_setup.sqf"

params ["_vec"];
private _whof = _vec getVariable "d_who_fired";
if (!isNil "_whof") then {
	private _aop = missionNamespace getVariable _whof;
	if (!isNil "_aop" && {!isNull _aop}) then {
		_this # 6 setShotParents [_vec, _aop];
	};
};