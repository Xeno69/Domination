// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_wa_ace_vec.sqf"
#include "..\x_setup.sqf"

sleep 1;

while {alive _this} do {
	sleep 1;
};
if (!isNull _this) then {
	isNil {
		_this setVariable ["d_dead", true];
		_this call d_fnc_onerespukilled;
		_this call d_fnc_handleDeadVec;
	};
};
