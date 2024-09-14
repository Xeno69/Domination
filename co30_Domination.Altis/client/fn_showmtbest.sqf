// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

d_temp_mt_bestplayers_list = _this;
__TRACE_1("","d_temp_mt_bestplayers_list")

"d_mtbestplayers_rsc" cutRsc ["d_mtbestplayers_rsc", "PLAIN"];
