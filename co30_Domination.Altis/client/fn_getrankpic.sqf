// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankpic.sqf"
#include "..\x_setup.sqf"

private _xm = _this getVariable "d_isxman";
if (isNil "_xm") then {
	private _c = _this getVariable "d_pl_ra_pi";
	if (isNil "_c" || {_c isEqualType ""}) then {
		private _r = _this getVariable "d_player_old_rank";
		if (!isNil "_r") then {
			if (_r <= 6) exitWith {
				_c = [getText(configFile>>"CfgRanks">>str _r>>"texture"), 0.4];
			};
			if (_r > 6 && {score _this > d_points_needed_16}) exitWith {
				_c = [getMissionPath "pics\6star.paa", 0.7];
			};
			if (_r > 6 && {score _this > d_points_needed_15}) exitWith {
				_c = [getMissionPath "pics\5star.paa", 0.7];
			};
			_c = [getText(configFile>>"CfgRanks">>str _r>>"texture"), 0.4];
		} else {
			_c = [getText(configFile>>"CfgRanks">>str ((rank _this) call d_fnc_getrankindex)>>"texture"), 0.4];
		};
		_this setVariable ["d_pl_ra_pi", _c];
	} else {
		private _h = _this getVariable "d_pl_ra_cc";
		if (isNil "_h") then {_h = 0};
		_h = _h + 1;
		if (_h >= diag_fps) then {
			_this setVariable ["d_pl_ra_cc", 0];
			_this setVariable ["d_pl_ra_pi", nil];
		} else {
			_this setVariable ["d_pl_ra_cc", _h];
		};
	};
	_c
} else {
	private _r = _this getVariable "d_6star";
	if (isNil "_r") then {
		_r = [getMissionPath "pics\6star.paa", 0.7];
		_this setVariable ["d_6star", _r];
	};
	_r
};
