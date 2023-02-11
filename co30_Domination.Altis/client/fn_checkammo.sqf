// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

//__TRACE_1("","_this")

if ((_this # 4) isEqualTo "") exitWith {true};

d_misc_sc_hash getOrDefaultCall [_this # 4, {toLowerANSI getText(configFile>>"CfgAmmo">>(_this # 4)>>"simulation") in ["shotsmoke", "shotilluminating", "shotnvgmarker", "shotcm", "shotsmokex"]}, true];
