// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setmatxtloc.sqf"
#include "..\x_macros.sqf"

__TRACE_1("","_this")

(_this # 0) setMarkerTextLocal format [localize "STR_DOM_MISSIONSTRING_910", _this # 1];
