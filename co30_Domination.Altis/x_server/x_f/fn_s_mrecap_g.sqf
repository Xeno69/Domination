// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_s_mrecap_g.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")
private _mtm = format ["d_%1_dommtm", _this select 0];
_mtm setMarkerColor (_this select 1);
_mtm setMarkerBrush (_this select 2);
