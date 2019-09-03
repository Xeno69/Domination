// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_disglobalsim.sqf"
#include "..\x_setup.sqf"

params ["_obj", ["_ti", 5]];

sleep _ti;

if (!isNull _obj) then {
	_obj enableSimulationGlobal false;
};
