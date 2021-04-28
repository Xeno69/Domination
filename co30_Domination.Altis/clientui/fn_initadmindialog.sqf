// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

private _ctrl = (uiNamespace getVariable "d_AdminDialog") displayCtrl 1001;

lbClear _ctrl;
{
	private _index = _ctrl lbAdd (name _x);
	_ctrl lbSetData [_index, str _x];
} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});

_ctrl lbSetCurSel 0;
ctrlSetFocus ((uiNamespace getVariable "d_AdminDialog") displayCtrl 1212);