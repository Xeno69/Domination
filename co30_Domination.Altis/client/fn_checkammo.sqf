// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if ((_this # 4) isEqualTo "") exitWith {true};

private _r = d_misc_sc_hash getOrDefault [_this # 4, -1];
if (_r isEqualType 1) then {
	_r = toLowerANSI getText(configFile>>"CfgAmmo">>(_this # 4)>>"simulation") in ["shotsmoke", "shotilluminating", "shotnvgmarker", "shotcm", "shotsmokex"];
	d_misc_sc_hash set [_this # 4, _ar];
};

__TRACE_1("","_r")

_r
