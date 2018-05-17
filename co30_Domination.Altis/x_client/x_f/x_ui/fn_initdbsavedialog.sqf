// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initdbsavedialog.sqf"
#include "..\..\..\x_setup.sqf"

disableSerialization;

#define CTRL(A) (_disp displayCtrl A)

private _disp = uiNamespace getVariable "D_DBSaveDialog";
private _ctrl = CTRL(102);

{
	_ctrl lbAdd _x;
} forEach d_db_savegames;

