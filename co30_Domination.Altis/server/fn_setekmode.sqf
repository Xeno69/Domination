// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setekmode.sqf"
#include "..\x_setup.sqf"

params ["_obj", "_mode", ["_type", true], ["_public", false]];

_obj setVariable [_mode, _type, _public];
_obj setVariable ["d_hkx", true, _public];