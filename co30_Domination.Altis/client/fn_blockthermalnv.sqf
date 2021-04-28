// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

sleep 2;

while {true} do {
	waitUntil {sleep 0.1; currentVisionMode player in [1, 2]};
	__TRACE_1("","currentVisionMode player")
	if (currentVisionMode player == 1) then {
		if (d_without_nvg != 1 && {isNull objectParent player || {isTurnedOut player || {alive (getConnectedUAV player) || {(fullCrew [vehicle player, "Turret"]) findIf {_x # 0 == player && {(_x # 4)}} > -1}}}}) then {
			private _curweap = currentWeapon player;
			__TRACE_1("nv","_curweap")
			if (d_without_nvg == 0) then {
				"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2014", "BLACK", 0.1];
				waitUntil {sleep 0.1; currentVisionMode player != 1 || {currentWeapon player != _curweap}};
				"d_t_block" cutText ["", "PLAIN"];
			} else {
				if (getText (configFile>>"CfgWeapons">>_curweap>>"cursor") != "missile") then {
					"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2014", "BLACK", 0.1];
					waitUntil {sleep 0.1; currentVisionMode player != 1 || {currentWeapon player != _curweap}};
					"d_t_block" cutText ["", "PLAIN"];
				} else {
					waitUntil {sleep 0.1; currentVisionMode player != 1 || {currentWeapon player != _curweap}};
				};
			};
		} else {
			waitUntil {sleep 0.1; currentVisionMode player != 1};
		};
	} else {
		if (currentVisionMode player == 2) then {
			if (d_without_ti != 1 && {isNull objectParent player || {isTurnedOut player || {alive (getConnectedUAV player) || {(fullCrew [vehicle player, "Turret"]) findIf {_x # 0 == player && {(_x # 4)}} > -1}}}}) then {
				private _curweap = currentWeapon player;
				__TRACE_1("ti","_curweap")
				__TRACE_1("","d_without_ti")
				if (d_without_ti == 0) then {
					"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2015", "BLACK", 0.1];
					waitUntil {sleep 0.1; currentVisionMode player != 2 || {currentWeapon player != _curweap}};
					"d_t_block" cutText ["", "PLAIN"];
				} else {
					if (getText (configFile>>"CfgWeapons">>_curweap>>"cursor") != "missile") then {
						"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2014", "BLACK", 0.1];
						waitUntil {sleep 0.1; currentVisionMode player != 2 || {currentWeapon player != _curweap}};
						"d_t_block" cutText ["", "PLAIN"];
					} else {
						waitUntil {sleep 0.1; currentVisionMode player != 2 || {currentWeapon player != _curweap}};
					};
				};
			};
		} else {
			waitUntil {sleep 0.1; currentVisionMode player != 2};
		};
	};
	sleep 0.1;
};
