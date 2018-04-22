// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_l_v.sqf"
#include "..\..\x_setup.sqf"

if !((param [0]) in d_wreck_cur_ar) then {
	if (local (param [0])) then {
		(param [0]) lock (param [1]);
	} else {
		_this remoteExecCall ["lock", param [0]];
	};
};