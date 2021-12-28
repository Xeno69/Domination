// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (d_sub_tk_points != 0) then {
	[format [localize "STR_DOM_MISSIONSTRING_504", _this # 0, _this # 1, d_sub_tk_points], "GLOBAL"] call d_fnc_HintChatMsg;
} else {
	[format [localize "STR_DOM_MISSIONSTRING_505", _this # 0, _this # 1], "GLOBAL"] call d_fnc_HintChatMsg;
};