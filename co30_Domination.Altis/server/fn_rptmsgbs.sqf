// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_pl", "_pl_name"];
__TRACE_2("","_pl","_pl_name")
call {
	if (_this # 2 == 0) exitWith {
		diag_log format [localize "STR_DOM_MISSIONSTRING_947", _pl_name, getPlayerUID _pl];
	};
	if (_this # 2 == 1) exitWith {
		diag_log format [localize "STR_DOM_MISSIONSTRING_948", _pl_name, getPlayerUID _pl];
	};
	if (_this # 2 == 2) exitWith {
		diag_log format [localize "STR_DOM_MISSIONSTRING_2099", _pl_name, getPlayerUID _pl];
	};
};
