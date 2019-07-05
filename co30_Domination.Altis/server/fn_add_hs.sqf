// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_add_hs.sqf"
#include "..\x_setup.sqf"

_this addEventhandler ["HandleScore", {_this call d_fnc_handlescore; true}];