// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankpic.sqf"
#include "..\x_setup.sqf"

private _xm = _this getVariable "d_isxman";
if (isNil "_xm") then {
	private _r = _this getVariable "d_player_old_rank";
	if (!isNil "_r") then {
		if (_r > 6 && {score _this > d_points_needed_15}) exitWith {
			getMissionPath "pics\5star.paa"
		};
		getText(configFile>>"CfgRanks">>str _r>>"texture")
	} else {
		getText(configFile>>"CfgRanks">>str ((rank _this) call d_fnc_getrankindex)>>"texture")
	};
} else {
	private _r = _this getVariable "d_5star";
	if (isNil "_r") then {
		_r = getMissionPath "pics\5star.paa";
		_this setVariable ["d_5star", _r];
	};
	_r
};
