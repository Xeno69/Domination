// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makteolpmttargets.sqf"
#include "..\x_setup.sqf"

private _list = [];

{
	_list pushBack (_x # 3);
} forEach d_target_names;

_list
