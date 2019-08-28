// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hasfak.sqf"
#include "..\x_macros.sqf"

((items _this) findIf {_x == "FirstAidKit" || {_x == "Medikit"}} > -1)
