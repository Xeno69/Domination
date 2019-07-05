// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_l_v.sqf"
#include "..\x_setup.sqf"

if !((_this select 0) in d_wreck_cur_ar) then {
	if (local (_this select 0)) then {
		(_this select 0) lock (_this select 1);
	} else {
		_this remoteExecCall ["lock", _this select 0];
	};
};