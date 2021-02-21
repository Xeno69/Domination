// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tanoafix.sqf"
#include "..\x_setup.sqf"

params ["_pos"];

if (_pos inArea [[5379.374, 10022.091, 0], 90, 30, 0, true]) then {
	[]
} else {
	_pos
};