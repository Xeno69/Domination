// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

if (!(_this # 2) && {!(_this # 3) && {!(_this # 4)}}) then {
	(_this # 1) in xr_drag_keys_ar
}