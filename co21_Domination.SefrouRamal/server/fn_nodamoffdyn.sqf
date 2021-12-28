// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_unit","_sleepTime"];

_unit allowDamage false;
[_unit, _sleepTime] spawn {
	scriptname "spawn nodamoffdyn";
	params ["_unit", "_sleepTime"];
	sleep _sleepTime;
	_unit allowDamage true;
};
