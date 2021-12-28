// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _list = [];

{
	_list pushBack (_x # 3);
} forEach d_target_names;

_list
