// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_outofbounds.sqf"
#include "..\..\x_setup.sqf"

(getPosWorld _this) params ["_p_x", "_p_y"];
((_p_x < 0 || {_p_x > d_island_x_max}) && {(_p_y < 0 || {_p_y > d_island_y_max})})