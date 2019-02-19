// by Xeno
#define THIS_FILE "fn_cmchanged.sqf"
#include "..\..\x_setup.sqf"

params ["_isHighCommand"];
if (_isHighCommand) then {
	if (isNull d_hchelperrunning) then {
		d_hchelperhandle = 0 spawn d_fnc_hchelper;
	};
} else {
	if (!isNull d_hchelperhandle) then {
		terminate d_hchelperhandle;
	};
};