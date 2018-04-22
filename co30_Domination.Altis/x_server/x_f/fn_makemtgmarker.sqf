// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makemtgmarker.sqf"
#include "..\..\x_setup.sqf"

[format ["d_%1_dommtm", d_cur_tgt_name], d_cur_tgt_pos, "ELLIPSE", d_e_marker_color, [d_cur_target_radius, d_cur_target_radius], "", 0, "", "", d_e_marker_color_alpha] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];