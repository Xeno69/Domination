// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addppoints.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_kind"];

// 1 = radio tower, 2 = camp captured

if (_kind in [1, 2, 3]) then {
#ifndef __INTERCEPTDB__
	call {
		if (_kind == 1) exitWith {
			"extdb3" callExtension format ["1:dom:radiotAdd:%1", getPlayerUID _pl];
		};
		if (_kind == 2) exitWith {
			"extdb3" callExtension format ["1:dom:campAdd:%1", getPlayerUID _pl];
		};
		if (_kind == 3) exitWith {
			"extdb3" callExtension format ["1:dom:mtsmAdd:%1", getPlayerUID _pl];
		};
	};
#else
	if (d_interceptdb) then {
		if (_kind == 1) exitWith {
			["radiotAdd", [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
		};
		if (_kind == 2) exitWith {
			["campAdd", [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
		};
		if (_kind == 3) exitWith {
			["mtsmAdd", [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
		};
	};
#endif
	_pl addScore 5;
};