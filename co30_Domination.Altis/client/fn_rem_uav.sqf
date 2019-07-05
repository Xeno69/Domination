// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rem_uav.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

d_marker_vecs = d_marker_vecs - [_this, objNull];
