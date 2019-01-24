// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_fillunload.sqf"
#include "..\..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

disableSerialization;
private _control = (uiNamespace getVariable "d_UnloadDialog") displayCtrl 101115;
lbClear _control;

{
	private _idx = _control lbAdd ([_x, "CfgVehicles"] call d_fnc_GetDisplayName);
	_control lbSetPicture [_idx, getText (configFile>>"cfgVehicles">>_x>>"picture")];
	_control lbSetColor [_idx, [1, 1, 0, 0.8]];
} forEach d_current_truck_cargo_array;

_control lbSetCurSel 0;