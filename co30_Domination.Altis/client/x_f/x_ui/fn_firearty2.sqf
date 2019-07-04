// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_firearty2.sqf"
#include "..\..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

disableSerialization;

private _idx = lbCurSel ((uiNamespace getVariable "d_MarkArtilleryDialog") displayCtrl 889);
if (_idx == -1) exitWith {};
d_ari_salvos = _idx + 1;

private _ctrl = (uiNamespace getVariable "d_MarkArtilleryDialog") displayCtrl 888;
_idx = lbCurSel _ctrl;
if (_idx == -1) exitWith {};
d_ari_type = _ctrl lbData _idx;
