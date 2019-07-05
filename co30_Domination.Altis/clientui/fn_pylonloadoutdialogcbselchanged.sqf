// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pylonloadoutdialogcbselchanged.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

disableSerialization;
params ["", "_sel"];

if (_selIdx == -1) exitWith {};

if (_sel == 1) then {
	d_pylon_mirrormode = true;
	{
		private _mirror = _x getVariable "d_mirrorctrl";
		if (!isNil "_mirror") then {
			_mirror lbSetCurSel (lbCurSel _x);
			_mirror ctrlEnable false;
		};
	} forEach d_pylondialog_ctrls;
} else {
	d_pylon_mirrormode = false;
	{
		private _mirror = _x getVariable "d_mirrorctrl";
		if (!isNil "_mirror") then {
			_mirror ctrlEnable true;
		};
	} forEach d_pylondialog_ctrls;
};