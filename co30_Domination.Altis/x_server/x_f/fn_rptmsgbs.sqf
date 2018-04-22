// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rptmsgbs.sqf"
#include "..\..\x_setup.sqf"

params ["_pl", "_pl_name"];
__TRACE_2("","_pl","_pl_name")
switch (param [2]) do {
	case 0: {
		diag_log format [localize "STR_DOM_MISSIONSTRING_947", _pl_name, getPlayerUID _pl];
	};
	case 1: {
		diag_log format [localize "STR_DOM_MISSIONSTRING_948", _pl_name, getPlayerUID _pl];
	};
};