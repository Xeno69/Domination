// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_removemhqenemyteletrig.sqf"
#include "..\x_setup.sqf"

params ["_mhq", "_alive"];

private _trig = _mhq getVariable ["d_enemy_trigger", objNull];
if (!isNull _trig) then {
	deleteVehicle _trig;
};
if (_alive == 1) exitWith {};
_mhq setVariable ["d_enemy_trigger", nil];
_mhq setVariable ["d_enemy_near", false, true];
