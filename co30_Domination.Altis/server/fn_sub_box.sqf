// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sub_box.sqf"
#include "..\x_setup.sqf"

params ["_box"];

__TRACE_1("","_this")

if (isNull _box) exitWith {};

private _perc = _box getVariable "d_abox_perc";
if (!isNil "_perc") then {
	_perc = _perc - 1;
	if (_perc < 0) then {
		_box spawn {
			scriptname "spawn sub_box";
			[_this] remoteExecCall ["d_fnc_RemABoxC"];
			sleep 0.5;
			[_this, objNull] call d_fnc_RemABox;
		};
	} else {
		_box setVariable ["d_abox_perc", _perc, true];
	};
};