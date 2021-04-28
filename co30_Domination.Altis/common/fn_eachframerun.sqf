// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Eachframerun")

private _ef_st = d_ef_hash;
__TRACE_1("","_ef_st")
{
	if (diag_frameno >= (_y # 2)) then {
		call (_y # 0);
		_y set [2, diag_frameno + (_y # 1)];
		__TRACE_1("2","_y")
	};
} forEach _ef_st;
