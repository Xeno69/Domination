// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_markername.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

private _strthis = str _this;
[_strthis, _strthis select [0, _strthis find "#"]] select ("#" in _strthis)
