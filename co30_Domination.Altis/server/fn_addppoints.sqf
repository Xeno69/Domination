// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addppoints.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_kind"];

// 1 = radio tower, 2 = camp captured

private _which = call {
	if (_kind == 1) exitWith {"radiotAdd"};
	if (_kind == 2) exitWith {"campAdd"};
	if (_kind == 3) exitWith {"mtsmAdd"};
	""
};

if (_which != "") then {
#ifndef __INTERCEPTDB__
	"extdb3" callExtension format ["1:dom:%1:%2", _which, getPlayerUID _pl];
#else
	if (d_interceptdb) then {
		[_which, [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
	};
#endif
	_pl addScore 5;
};