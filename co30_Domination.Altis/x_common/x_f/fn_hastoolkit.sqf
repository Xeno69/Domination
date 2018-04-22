// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hastoolkit.sqf"
#include "..\..\x_setup.sqf"

(items _this) findIf {(toUpper _x) find "TOOLKIT" > -1} > -1