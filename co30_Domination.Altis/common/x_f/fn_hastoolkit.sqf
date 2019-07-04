// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hastoolkit.sqf"
#include "..\..\x_setup.sqf"

(items _this) findIf {
	private _it = toUpper _x;
	_it find "TOOLKIT" > -1 || {_it find "REPAIRKIT" > -1}
} > -1
