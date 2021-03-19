// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_blockthermalnv.sqf"
#include "..\x_setup.sqf"

sleep 2;

while {true} do {
	waitUntil {sleep 0.1; currentVisionMode player in [1, 2]};
	__TRACE_1("","currentVisionMode player")
	if (currentVisionMode player == 1) then {
		if (d_without_nvg == 0 && {isNull objectParent player || {isTurnedOut player || {alive (getConnectedUAV player) || {(fullCrew [vehicle player, "Turret"]) findIf {_x # 0 == player && {(_x # 4)}} > -1}}}}) then {
			"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2014", "BLACK", 0.1];
			waitUntil {sleep 0.1; currentVisionMode player != 1};
			"d_t_block" cutText ["", "PLAIN"];
		} else {
			waitUntil {sleep 0.1; currentVisionMode player != 1};
		};
	} else {
		if (currentVisionMode player == 2) then {
			if (d_without_ti == 0 && {isNull objectParent player || {isTurnedOut player || {alive (getConnectedUAV player) || {(fullCrew [vehicle player, "Turret"]) findIf {_x # 0 == player && {(_x # 4)}} > -1}}}}) then {
				"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2015", "BLACK", 0.1];
				waitUntil {sleep 0.1; currentVisionMode player != 2};
				"d_t_block" cutText ["", "PLAIN"];
			};
		} else {
			waitUntil {sleep 0.1; currentVisionMode player != 2};
		};
	};
	sleep 0.1;
};