// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframerun.sqf"
#include "..\x_setup.sqf"

private _ef_st = d_ef_hash;
{
	call {
		if (_y # 1 == 0) exitWith {
			call (_y # 0);
			__TRACE_1("1","_y")
		};
		if (diag_frameno >= (_y # 2)) exitWith {
			call (_y # 0);
			_y set [2, diag_frameno + (_y # 1)];
			__TRACE_1("2","_y")
		};
	};
} forEach _ef_st;
