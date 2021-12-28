// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
__TRACE_1("","_this")

private _posione = _this;
while {d_sm_running} do {
	if (player distance2D _posione < (d_ranked_a # 12)) exitWith {
		d_was_at_sm = true;
		d_sm_running = false;
	};
	sleep 3.012 + random 3;
};