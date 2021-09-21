// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

disableSerialization;

private _ctrlmap = (uiNamespace getVariable "XR_SpectDlg") displayCtrl 900;
ctrlMapAnimClear _ctrlmap;

private _end_pos = getPosATL player;

_ctrlmap ctrlMapAnimAdd [0, 1, getPosATL d_FLAG_BASE];
_ctrlmap ctrlMapAnimAdd [1.2, 1, _end_pos];
_ctrlmap ctrlMapAnimAdd [0.8, 0.1, _end_pos];
ctrlMapAnimCommit _ctrlmap;