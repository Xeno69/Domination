//by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
if (!hasInterface || {!d_player_canu}) exitWith {};

private _exitj = false;
if (d_with_ranked || {d_database_found}) then {
	if (score player < (d_ranked_a # 19)) then {
		[1, format [localize "STR_DOM_MISSIONSTRING_76", score player, d_ranked_a # 19]] call d_fnc_sideorsyschat;
		_exitj = true;
	} else {
		[player, 9] remoteExecCall ["d_fnc_ascfc", 2];
	};
};
if (_exitj) exitWith {};

__TRACE_1("","_this")

[(_this # 0) ctrlMapScreenToWorld [_this # 2, _this # 3], "", 500, 200, 360, 0, 0] spawn d_fnc_establishingShot;
