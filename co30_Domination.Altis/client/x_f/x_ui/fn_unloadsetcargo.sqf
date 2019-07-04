// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_unloadsetcargo.sqf"
#include "..\..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

disableSerialization;
private _idx = lbCurSel ((uiNamespace getVariable "d_UnloadDialog") displayCtrl 101115);
if (_idx < 0) exitWith {closeDialog 0};
d_cargo_selected_index = _idx;
closeDialog 0;