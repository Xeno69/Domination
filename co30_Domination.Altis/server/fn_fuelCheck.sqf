// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];
_vec setVariable ["d_fuel", (fuel _vec) max 0.1];