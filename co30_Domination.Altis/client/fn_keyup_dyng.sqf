// by Xeno
#define THIS_FILE "fn_keyup_dyng.sqf"
#include "..\x_setup.sqf"

if ((_this # 1) in d_ak_teamswitch && {!(_this # 2) && {!(_this # 3) && {!(_this # 4)}}}) then {
	[1, _this] call d_fnc_KeyDownCommandingMenu;
	true
} else {
	false
}
