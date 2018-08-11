// by Xeno
#define THIS_FILE "fn_airtaxi.sqf"
#include "..\..\x_setup.sqf"

if (isNil "d_heli_taxi_available") then {d_heli_taxi_available = true};

if (!d_heli_taxi_available) exitWith {[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_139")};

if (d_FLAG_BASE distance2D player < 500) exitWith {[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_140")};

private _exitj = false;
if (d_with_ranked || {d_database_found}) then {
	if (score player < (d_ranked_a # 15)) exitWith {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_1424", score player, d_ranked_a # 15];
		_exitj = true;
	};
	[player, (d_ranked_a # 15) * -1] remoteExecCall ["addScore", 2];
};

if (_exitj) exitWith {};

player sideChat (localize "STR_DOM_MISSIONSTRING_141");

[d_string_player, getPos player] remoteExec ["d_fnc_airtaxiserver", 2];
