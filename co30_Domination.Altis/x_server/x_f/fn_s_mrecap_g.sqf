// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_s_mrecap_g.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")
private _mtm = format ["d_%1_dommtm", param [0]];
_mtm setMarkerColor (param [1]);
_mtm setMarkerBrush (param [2]);
