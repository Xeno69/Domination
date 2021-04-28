// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;
private _idx = lbCurSel ((uiNamespace getVariable "d_UnloadDialog") displayCtrl 101115);
if (_idx < 0) exitWith {closeDialog 0};
d_cargo_selected_index = _idx;
closeDialog 0;