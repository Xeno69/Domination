// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframerun.sqf"
#include "..\..\x_setup.sqf"

private "_e";
{
	_e = d_ef_store getVariable _x;
	if (!isNil "_e") then {
		if (_e # 1 == 0) then {
			call (_e # 0);
			__TRACE_1("1","_e")
		} else {
			if ((_e # 3) == 0 && {time >= (_e # 2)}) then {
				call (_e # 0);
				_e set [2, time + (_e # 1)];
				__TRACE_1("2","_e")
			} else {
				if ((_e # 3) == 1 && {diag_frameno >= (_e # 2)}) then {
					call (_e # 0);
					_e set [2, diag_frameno + (_e # 1)];
					__TRACE_1("3","_e")
				};
			};
		};
		
		
	};
} forEach d_ef_events;