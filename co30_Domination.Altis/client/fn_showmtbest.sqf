// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _alllist = _this;
__TRACE_1("","_alllist")

d_temp_mt_bestplayers_list = _alllist;
__TRACE_1("","d_temp_mt_bestplayers_list")

"d_mtbestplayers_rsc" cutRsc ["d_mtbestplayers_rsc", "PLAIN"];
