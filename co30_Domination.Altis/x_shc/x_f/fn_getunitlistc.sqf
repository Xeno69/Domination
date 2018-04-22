// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitlistc.sqf"
#include "..\..\x_setup.sqf"

private _ulist = [];
_ulist resize 11;
(_ulist apply {selectRandom d_civilians_t})
