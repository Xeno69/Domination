// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframerun.sqf"
#include "..\x_setup.sqf"

private "_e";
private _ef_st = d_ef_hash;
{
	_e = _y;
	if (!isNil "_e") then {
		if (_e # 1 == 0) exitWith {
			call (_e # 0);
			__TRACE_1("1","_e")
		};
		if (diag_frameno >= (_e # 2)) then {
			call (_e # 0);
			_e set [2, diag_frameno + (_e # 1)];
			__TRACE_1("3","_e")
		};
	};
} forEach _ef_st;
