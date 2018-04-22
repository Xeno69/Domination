// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handleheal.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_healed", "_healer"];
if (alive _healed && {alive _healer && {_healed != _healer && {!(_healed getVariable ["xr_pluncon", false]) && {!(_healer getVariable ["xr_pluncon", false])}}}}) then {
	[_healed, _healer] spawn {
		scriptName "spawn_handleheal";
		params ["_healed", "_healer"];
		sleep 3;
		if (alive _healed && {alive _healer && {_healed != _healer && {!(_healed getVariable ["xr_pluncon", false]) && {!(_healer getVariable ["xr_pluncon", false])}}}}) then {
			[_healer, d_ranked_a # 17] remoteExecCall ["addScore", 2];
			if (isMultiplayer) then {
				[[playerSide, "HQ"], format [localize "STR_DOM_MISSIONSTRING_288", d_ranked_a # 17]] remoteExecCall ["sideChat", _healer];
			} else {
				[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_288", d_ranked_a # 17];
			};
		};
	};
};
false