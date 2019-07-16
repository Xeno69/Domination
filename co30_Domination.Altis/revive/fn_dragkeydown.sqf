// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dragkeydown.sqf"
#include "..\x_macros.sqf"

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

if (!(_this select 2) && {!(_this select 3) && {!(_this select 4)}}) then {
	(_this select 1) in xr_drag_keys_ar
}