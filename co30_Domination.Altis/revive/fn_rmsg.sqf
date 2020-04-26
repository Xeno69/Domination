// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rmsg.sqf"
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

if (_this select 1 != xr_name_player && {_this select 0 != xr_name_player}) then {
	systemChat format [localize "STR_DOM_MISSIONSTRING_913", _this select 1, _this select 0];
};
if (_this select 1 == xr_name_player) then {
	_this spawn {
		scriptName "spawn xr msg";
		sleep 2.7;
		systemChat (format [localize "STR_DOM_MISSIONSTRING_914", _this select 0]);
	};
};
if (count _this > 2) then {
	private _np = (_this # 2) getVariable "d_plname";
	if (!isNil "_np" && {_np isEqualTo "Error: No unit"}) then {
		(_this # 2) setVariable ["d_plname", _this # 1];
	};
};