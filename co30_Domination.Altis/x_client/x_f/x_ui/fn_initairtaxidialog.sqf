// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initairtaxidialog.sqf"
#include "..\..\..\x_setup.sqf"

#define CTRL(A) (_disp displayCtrl A)

if (!hasInterface) exitWith {};

disableSerialization;

params ["_disp"];

private _ctrl = CTRL(1000);

{
	private _idx = _ctrl lbAdd ([_x, "CfgVehicles"] call d_fnc_GetDisplayName);
	_ctrl lbSetData [_idx, _x];
	_ctrl lbSetPicture [_idx, getText(configFile>>"cfgVehicles">>_x>>"picture")];
	_ctrl lbSetPictureColor [_idx, [1,1,1,1]];
} forEach d_taxi_aircrafts;

_ctrl lbSetCurSel 0;
