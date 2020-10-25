// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makemtgmarker.sqf"
#include "..\x_setup.sqf"

[format ["d_%1_dommtm", d_cur_tgt_name], d_cur_tgt_pos, "ELLIPSE", "ColorGreen", [d_cur_target_radius, d_cur_target_radius], "", 0, "", "Solid", 0] call d_fnc_CreateMarkerGlobal;
