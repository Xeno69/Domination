// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (_this # 1 != player) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_1565");
};

__TRACE_1("","_this")

private _grpplayer = group player;

if (player != leader _grpplayer) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_311");
};

if (player distance2D (_this # 0) > 50) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_312");
};

d_current_ai_num = {alive _x && {!(_x call d_fnc_isplayer)}} count (units _grpplayer);

createDialog "d_AIRecruitDialog";