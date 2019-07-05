// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_fuelCheck.sqf"
#include "..\x_setup.sqf"

params ["_vec"];
_vec setVariable ["d_fuel", (fuel _vec) max 0.1];
_vec removeAllMPEventHandlers "MPKilled";