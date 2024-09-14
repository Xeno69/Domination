// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

private _ctrl = (uiNamespace getVariable "d_mtbestplayers_rsc") displayCtrl 107;

private _row = ["Pos", "Name", "Score"];

_ctrl lnbAddColumn 0.02;
_ctrl lnbAddColumn 0.05;
_ctrl lnbAddColumn 0.135;

__TRACE_1("","d_temp_mt_bestplayers_list")

private _rowidx = _ctrl lnbAddRow _row;
__TRACE_1("1","_rowidx")

{
	_rowidx = _ctrl lnbAddRow [str (_forEachIndex + 1), _x # 1, str (_x # 0)];
	__TRACE_1("2","_rowidx")
#ifdef __DEBUG__
	private _modulo = _rowidx % 2;
	__TRACE_1("","_modulo")
#endif
	if (_rowidx % 2 == 0) then {
		_ctrl lnbSetColor [[_rowidx, 0], [0.87, 0.87, 0.87, 1]];
		_ctrl lnbSetColor [[_rowidx, 1], [0.87, 0.87, 0.87, 1]];
		_ctrl lnbSetColor [[_rowidx, 2], [0.87, 0.87, 0.87, 1]];
	} else {
		_ctrl lnbSetColor [[_rowidx, 0], [0, 1, 0, 1]];
		_ctrl lnbSetColor [[_rowidx, 1], [0, 1, 0, 1]];
		_ctrl lnbSetColor [[_rowidx, 2], [0, 1, 0, 1]];
	};
} forEach d_temp_mt_bestplayers_list;

d_temp_mt_bestplayers_list = nil;
