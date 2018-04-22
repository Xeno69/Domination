// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkshc.sqf"
#include "..\..\x_setup.sqf"

if (d_IS_HC_CLIENT || {isServer}) exitWith {true};
false