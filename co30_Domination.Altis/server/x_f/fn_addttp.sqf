// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addttp.sqf"
#include "..\..\x_setup.sqf"

if ((_this # 0) == 1) then {
	d_kill_points_blufor = d_kill_points_blufor + (_this # 1);
} else {
	d_kill_points_opfor = d_kill_points_opfor + (_this # 1);
};