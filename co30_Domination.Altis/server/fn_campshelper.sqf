// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
	sleep 5;
	if (!isNil "d_sum_camps" && {d_sum_camps > 0 && {d_campscaptured > d_sum_camps}}) then {
		d_campscaptured = d_sum_camps;
		publicVariable "d_campscaptured";
	};
};
