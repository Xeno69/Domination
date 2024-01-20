// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (_this # 1 != player) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_1565");
};

__TRACE_1("","_this")

if (player != leader (group player)) exitWith {
	[1, localize "STR_DOM_MISSIONSTRING_311"] call d_fnc_sideorsyschat;
};

if (player distance2D (_this # 0) > 50) exitWith {
	[1, localize "STR_DOM_MISSIONSTRING_312"] call d_fnc_sideorsyschat;
};

d_current_ai_num = {alive _x && {!(isPlayer [_x])}} count (units player);

createDialog "d_AIRecruitDialog";