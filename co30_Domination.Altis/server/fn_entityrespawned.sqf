// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_pl"];

if (d_MissionType != 2) then {
	_pl addEventhandler ["HandleScore", {call d_fnc_handlescore; true}];
};

#ifndef __TT__
[_pl] call d_fnc_addceo;
#endif

true