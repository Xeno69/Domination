// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

__TRACE_1("","_this")

params ["_ctrl", "_selIdx"];

if (_selIdx == -1) exitWith {};

private _vec = d_pylon_vec;

if (_selIdx == 0) then {
	{
		__TRACE_1("d_startpylongmags","_x")
		if (_forEachIndex == count (_vec getVariable "d_startpylongmags")) then {break};
		private _octrl = d_pylondialog_ctrls select _forEachIndex;
		for "_i" from 0 to (lbSize _octrl - 1) do {
			if (_octrl lbData _i == _x) then {
				_octrl lbSetCurSel _i;
				break;
			};
		};
	} forEach (_vec getVariable "d_startpylongmags");
} else {
	__TRACE_1("","_ctrl lbData _selIdx")
	__TRACE_1("","d_pylondialog_ctrls")
	private _attachment = getArray((configOf _vec)>>"Components">>"TransportPylonsComponent">>"Presets">>(_ctrl lbData _selIdx)>>"attachment");
	if (_attachment isNotEqualTo []) then {
		{
			__TRACE_2("config Presets","_x","_forEachIndex")
			if (_forEachIndex == count d_pylondialog_ctrls) then {break};
			private _octrl = d_pylondialog_ctrls select _forEachIndex;
			for "_i" from 0 to (lbSize _octrl - 1) do {
				if (_octrl lbData _i == _x) then {
					_octrl lbSetCurSel _i;
					break;
				};
			};
		} forEach _attachment;
	} else {
		{
			_x lbSetCurSel 0;
		} forEach d_pylondialog_ctrls;
	};
};