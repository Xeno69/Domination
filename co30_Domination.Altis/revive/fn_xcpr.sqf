// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

player setVariable ["xr_unconendtime", (player getVariable "xr_unconendtime") + xr_cpr_time_add]
