// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankpic.sqf"
#include "..\x_setup.sqf"

private _xm = _this getVariable "d_isxman";
if (isNil "_xm") then {
	private _r = _this getVariable "d_player_old_rank";
	if (!isNil "_r") then {
		if (_r <= 6) exitWith {
			[getText(configFile>>"CfgRanks">>str _r>>"texture"), 0.4]
		};
		if (_r > 6 && {score _this > d_points_needed_16}) exitWith {
			[getMissionPath "pics\mstar.paa", 0.6]
		};
		if (_r > 6 && {score _this > d_points_needed_15}) exitWith {
			[getMissionPath "pics\5star.paa", 1.6]
		};
		[getText(configFile>>"CfgRanks">>str _r>>"texture"), 0.4]
	} else {
		[getText(configFile>>"CfgRanks">>str ((rank _this) call d_fnc_getrankindex)>>"texture"), 0.4]
	};
} else {
	private _r = _this getVariable "d_mstar";
	if (isNil "_r") then {
		_r = getMissionPath "pics\mstar.paa";
		_this setVariable ["d_mstar", _r];
	};
	[_r, 1.6]
};
