// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dragkeydown.sqf"
#include "..\..\x_macros.sqf"

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

if (!(param [2]) && {!(param [3]) && {!(param [4])}}) then {
	(param [1]) in xr_drag_keys_ar
}