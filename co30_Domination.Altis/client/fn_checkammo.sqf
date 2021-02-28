// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkammo.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if ((_this # 0) isEqualTo "") exitWith {true};

private _ar = d_misc_sc_hash getOrDefault [_this # 0, -1];
if (_ar isEqualType 1) then {
	_ar = [
		toLowerANSI getText(configFile>>"CfgAmmo">>(_this # 0)>>"simulation") in ["shotpipebomb", "shottimebomb", "shotdirectionalbomb", "shotmine", "shotboundingmine"],
		toLowerANSI getText(configFile>>"CfgAmmo">>(_this # 0)>>"simulation") in ["shotsmoke", "shotilluminating", "shotnvgmarker", "shotcm", "shotsmokex"]
	];
	d_misc_sc_hash set [_this # 0, _ar];
};

__TRACE_1("","_ar")

_ar # (_this # 1)
