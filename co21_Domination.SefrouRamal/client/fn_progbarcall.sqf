// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_wf"];
disableSerialization;
private _disp = uiNamespace getVariable "d_ProgressBar";
private _ctrl = _disp displayCtrl 3800;
private _newval = linearConversion [0, _wf getVariable "d_CAPTIME", _wf getVariable "d_CURCAPTIME", 0, 0.38, true];
__TRACE_1("","_newval")
//progressSetPosition -> Is not as smooth as a ctrl commit
_ctrl ctrlSetPositionW _newval;
_ctrl ctrlSetBackgroundColor ([[1, 1, 0, 0.8], [1 - (_newval * 2.777777), _newval * 2.777777, 0, 0.8]] select !(_wf getVariable "d_STALL"));
_ctrl ctrlCommit 3;
_ctrl = _disp displayCtrl 3900;
if !(_wf getVariable "d_STALL") then {
	if (ctrlText _ctrl == localize "STR_DOM_MISSIONSTRING_1967") then {
		_ctrl ctrlSetText (localize "STR_DOM_MISSIONSTRING_1272");
	};
} else {
	if (ctrlText _ctrl == localize "STR_DOM_MISSIONSTRING_1272") then {
		_ctrl ctrlSetText (localize "STR_DOM_MISSIONSTRING_1967");
	};
};