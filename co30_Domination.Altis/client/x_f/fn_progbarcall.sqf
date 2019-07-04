// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_progbarcall.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_wf"];
disableSerialization;
private _disp = uiNamespace getVariable "d_ProgressBar";
private _control = _disp displayCtrl 3800;
//private _maxWidth = ctrlPosition (_disp displayCtrl 3600) # 2;
//private _newval = [_maxWidth, ((_maxWidth * (_wf getVariable "d_CURCAPTIME") / (_wf getVariable "d_CAPTIME")) min _maxWidth) max 0.02] select ((_wf getVariable "d_SIDE") != d_own_side);
__TRACE_2("","_maxWidth","_newval")
private _newval = linearConversion [0, _wf getVariable "d_CAPTIME", _wf getVariable "d_CURCAPTIME", 0, ctrlPosition (_disp displayCtrl 3600) # 2];
//progressSetPosition -> Is not as smooth as a ctrl commit
_control ctrlSetPositionW _newval;
_control ctrlSetBackgroundColor ([[1, 1, 0, 0.8], [1 - (_newval * 2.777777), _newval * 2.777777, 0, 0.8]] select !(_wf getVariable "d_STALL"));
_control ctrlCommit 3;