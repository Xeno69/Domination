// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handlescore.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_unit", "", "_score"];

if (isNull objectParent _unit && {_score > 0 && {_unit distance2D d_cur_tgt_pos < d_mttarget_radius_patrol}}) then {
	_unit addScore (_score * 2);
};