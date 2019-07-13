// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hastoolkit.sqf"
#include "..\x_setup.sqf"

(items _this) findIf {
	private _it = toLower _x;
	_it find "toolkit" > -1 || {_it find "repairkit" > -1}
} > -1
