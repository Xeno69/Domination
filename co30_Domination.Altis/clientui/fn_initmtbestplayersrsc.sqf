// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

private _ctrl = (uiNamespace getVariable "d_mtbestplayers_rsc") displayCtrl 107;

private _row = ["Pos", "Name", "Score"];

_ctrl lnbAddColumn 0.02;
_ctrl lnbAddColumn 0.05;
_ctrl lnbAddColumn 0.2;

private _rowidx = _ctrl lnbAddRow _row;

{
	_rowidx = _ctrl lnbAddRow [str (_forEachIndex + 1), _x # 1, str (_x # 0)];
	if (_rowidx == 1) then {
		_ctrl lnbSetColor [[_rowidx, 0], [0, 1, 0, 1]];
		_ctrl lnbSetColor [[_rowidx, 1], [0, 1, 0, 1]];
		_ctrl lnbSetColor [[_rowidx, 2], [0, 1, 0, 1]];
	} else {
		if (_rowidx % 2 == 0) then {
			_ctrl lnbSetColor [[_rowidx, 0], [0.87, 0.87, 0.87, 1]];
			_ctrl lnbSetColor [[_rowidx, 1], [0.87, 0.87, 0.87, 1]];
			_ctrl lnbSetColor [[_rowidx, 2], [0.87, 0.87, 0.87, 1]];
		};
	};
} forEach d_temp_mt_bestplayers_list;

d_temp_mt_bestplayers_list = nil;
