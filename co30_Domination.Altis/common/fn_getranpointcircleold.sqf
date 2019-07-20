// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcircleold.sqf"
#include "..\x_setup.sqf"

// no slope check, for patrolling
params ["_center", "_radius"];
private _ret_val = [];
for "_co" from 0 to 99 do {
	private _npos = _center getPos [_radius * sqrt random 1, random 360];
	if !(surfaceIswater _npos) exitWith {_npos set [2, 0]; _ret_val = _npos};
};
if (_ret_val isEqualTo []) then {_ret_val = _center};
_ret_val