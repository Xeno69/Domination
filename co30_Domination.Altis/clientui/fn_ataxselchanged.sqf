// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ataxselchanged.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

disableSerialization;

params ["_selection"];

private _selIdx = _selection # 1;
if (_selIdx == -1) exitWith {};

_selection params ["_ctrl"];
d_ataxi_unit_type = _ctrl lbData _selIdx;
