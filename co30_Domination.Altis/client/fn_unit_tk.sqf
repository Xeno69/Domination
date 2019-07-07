// by Xeno
#define THIS_FILE "fn_unit_tk.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (d_sub_tk_points != 0) then {
	[format [localize "STR_DOM_MISSIONSTRING_502", _this select 0, _this select 1, d_sub_tk_points], "GLOBAL"] call d_fnc_HintChatMsg;
} else {
	[format [localize "STR_DOM_MISSIONSTRING_503", _this select 0, _this select 1], "GLOBAL"] call d_fnc_HintChatMsg;
};