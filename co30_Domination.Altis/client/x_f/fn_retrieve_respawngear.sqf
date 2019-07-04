// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_retrieve_respawngear.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _lg = player getVariable "d_respawngear";
if (!isNil "_lg") then {
	player setUnitLoadout [_lg, false];
};
