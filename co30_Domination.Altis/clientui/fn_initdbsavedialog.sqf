// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

if (isNil "d_db_savegames") exitWith {};

#define CTRL(A) (_disp displayCtrl A)

private _disp = uiNamespace getVariable "D_DBSaveDialog";
private _ctrl = CTRL(102);

{
	_ctrl lbAdd _x;
} forEach d_db_savegames;

