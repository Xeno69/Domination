// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rmsg.sqf"
#include "..\..\x_macros.sqf"

if (param [1] != xr_name_player && {param [0] != xr_name_player}) then {
	systemChat format [localize "STR_DOM_MISSIONSTRING_913", param [1], param [0]];
};
if (param [1] == xr_name_player) then {
	_this spawn {
		sleep 2.7;
		systemChat (format [localize "STR_DOM_MISSIONSTRING_914", param [0]]);
	};
};