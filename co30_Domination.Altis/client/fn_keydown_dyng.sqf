// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_keydown_dyng.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if ((_this # 1) in (actionKeys "TeamSwitch") && {!(_this # 2) && {!(_this # 3) && {!(_this # 4) && {d_player_canu}}}}) then {
	[0, _this] call d_fnc_KeyDownCommandingMenu;
	true
} else {
	false
}
