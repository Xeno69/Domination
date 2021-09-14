// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

if (isNil "d_db_savegames") exitWith {};

private _disp = uiNamespace getVariable "D_DBSaveDialog";
private _ctrl = _disp displayCtrl 102;

{
	_ctrl lbAdd _x;
} forEach d_db_savegames;

