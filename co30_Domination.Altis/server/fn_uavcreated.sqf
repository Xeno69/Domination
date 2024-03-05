// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_uav", "_driver", "_gunner"];
_uav setVariable ["d_uav_crew", [_driver, _gunner]];
[_uav, 7] call d_fnc_setekmode;
