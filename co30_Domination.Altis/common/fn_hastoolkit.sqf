// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hastoolkit.sqf"
#include "..\x_setup.sqf"

(items _this) findIf {
	private _it = toLowerANSI _x;
	"toolkit" in _it || {"repairkit" in _it}
} > -1
