// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_removemhqenemyteletrig.sqf"
#include "..\x_setup.sqf"

private _trig = _this getVariable ["d_enemy_trigger", objNull];
if (!isNull _trig) then {
	deleteVehicle _trig;
};
if (!alive _this) exitWith {};
_this setVariable ["d_enemy_trigger", nil];
_this setVariable ["d_enemy_near", false, true];
