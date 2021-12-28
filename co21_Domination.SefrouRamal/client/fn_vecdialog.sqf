// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];

__TRACE_1("","_this")

if (!alive _vec) exitWith {
	__TRACE_1("not alive","_vec")
};

d_curvec_dialog = _vec;
d_curcaller_dialog = _this # 1;

createDialog "d_VecDialog";
