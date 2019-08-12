// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_keydown_dyng.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if ((_this select 1) in d_actionkeys_teamswitch && {!(_this select 2) && {!(_this select 3) && {!(_this select 4) && {alive player && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false])}}}}}}) then {
	[0, _this] call d_fnc_KeyDownCommandingMenu;
	true
} else {
	false
}
