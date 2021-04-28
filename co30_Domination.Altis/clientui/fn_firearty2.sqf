// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

private _idx = lbCurSel ((uiNamespace getVariable "d_MarkArtilleryDialog") displayCtrl 889);
__TRACE_1("1","_idx")
if (_idx == -1) exitWith {};
d_ari_salvos = _idx + 1;

private _ctrl = (uiNamespace getVariable "d_MarkArtilleryDialog") displayCtrl 888;
_idx = lbCurSel _ctrl;
__TRACE_1("2","_idx")
if (_idx == -1) exitWith {};
d_ari_type = _ctrl lbData _idx;
