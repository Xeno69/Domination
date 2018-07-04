//by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_satellitedo.sqf"
#include "..\..\x_setup.sqf"
if (isDedicated || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}) exitWith {};

private _exitj = false;
if (d_with_ranked || {d_database_found}) then {
	if (score player < (d_ranked_a # 19)) then {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_76", score player, d_ranked_a # 19];
		_exitj = true;
	} else {
		[player, (d_ranked_a # 19) * -1] remoteExecCall ["addScore", 2];
	};
};
if (_exitj) exitWith {};

__TRACE_1("","_this")

[(_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3],"", 500, 200, 360, 0, 0] spawn d_fnc_establishingShot;
