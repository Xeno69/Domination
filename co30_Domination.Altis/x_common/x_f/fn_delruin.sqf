// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_delruin.sqf"
#include "..\..\x_setup.sqf"

private _ruin = nearestObject [_this, "Ruins"];
if (!isNull _ruin) then {deleteVehicle _ruin}