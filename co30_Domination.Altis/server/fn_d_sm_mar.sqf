// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_d_sm_mar.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")
deleteMarker format ["d_XMISSIONM%1", _this];
if (d_x_sm_type == "convoy" || {d_x_sm_type == "deliver"}) then {deleteMarker format ["d_XMISSIONM2%1", _this]};