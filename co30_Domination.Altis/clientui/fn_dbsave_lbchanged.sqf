// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dbsave_lbchanged.sqf"
#include "..\x_setup.sqf"

disableSerialization;

__TRACE_1("","_this")

private _disp = uiNamespace getVariable "D_DBSaveDialog";

private _selIdx = _this select 1;
if (_selIdx == -1) exitWith {};

private _lbctrl = _this select 0;

(_disp displayCtrl 100) ctrlSetText (_lbctrl lbText _selIdx);
(_disp displayCtrl 101) ctrlEnable true;
