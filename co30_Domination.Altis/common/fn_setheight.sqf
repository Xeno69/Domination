// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// set only height of an object
// parameters: object, height
// example: [unit1, 30] call d_fnc_SetHeight;
private _p = getPosWorld (_this # 0);(_this # 0) setPos [_p # 0, _p # 1, _this # 1]
