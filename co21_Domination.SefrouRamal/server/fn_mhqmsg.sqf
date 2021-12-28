// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _mhqmsg = _this getVariable "d_vec_is_mhq";

if (!isNil "_mhqmsg") then {
#ifndef __TT_
	[47, _mhqmsg # 0] call d_fnc_DoKBMsg;
#else
	if (_mhqmsg # 1 < 1000) then {
		[48, _mhqmsg # 0] call d_fnc_DoKBMsg;
	} else {
		[49, _mhqmsg # 0] call d_fnc_DoKBMsg;
	};
#endif
};