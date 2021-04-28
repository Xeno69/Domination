// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if ((_this # 1) in d_ak_teamswitch && {d_player_canu && {!(_this # 2) && {!(_this # 3) && {!(_this # 4)}}}}) then {
	[0, _this] call d_fnc_KeyDownCommandingMenu;
	true
} else {
	!d_player_canu
}
