// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

private _ctrl = (uiNamespace getVariable "d_AdminDialog") displayCtrl 1001;

lbClear _ctrl;
{
	private _index = _ctrl lbAdd (name _x);
	_ctrl lbSetData [_index, str _x];
} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x && {!(_x isKindOf "VirtualMan_F")}});

_ctrl lbSetCurSel 0;
ctrlSetFocus ((uiNamespace getVariable "d_AdminDialog") displayCtrl 1212);

if (!d_database_found) then {
	((uiNamespace getVariable "d_AdminDialog") displayCtrl 1014) ctrlShow false;
	((uiNamespace getVariable "d_AdminDialog") displayCtrl 1015) ctrlShow false;
	((uiNamespace getVariable "d_AdminDialog") displayCtrl 1016) ctrlShow false;
} else {
	d_a_d_selscore = 100;
};
