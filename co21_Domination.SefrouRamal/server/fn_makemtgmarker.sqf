// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifndef __TT__
[format ["d_%1_dommtm", d_cur_tgt_name], d_cur_tgt_pos, "ELLIPSE", "ColorGreen", [d_cur_target_radius, d_cur_target_radius], "", 0, "", "Solid", 0] call d_fnc_CreateMarkerGlobal;
#else
[format ["d_%1_dommtm", d_cur_tgt_name], d_cur_tgt_pos, "ELLIPSE", "ColorYellow", [d_cur_target_radius + 150, d_cur_target_radius + 150], "", 0, "", "Solid"] call d_fnc_CreateMarkerGlobal;
#endif
