// by Xeno
#define THIS_FILE "fn_setmatxtloc.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (count _this == 2) then {
	(_this # 0) setMarkerTextLocal (localize (_this # 1));
} else {
	(_this # 0) setMarkerTextLocal format [localize (_this # 1), _this # 2];
};
