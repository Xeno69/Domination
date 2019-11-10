// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankpic.sqf"
#include "..\x_setup.sqf"

private _xm = _this getVariable "d_isxman";
if (isNil "_xm") then {
	private _r = _this getVariable "d_player_old_rank";
	if (isNil "_r") then {
		_r = (rank _this) call d_fnc_getrankindex;
	};
	getText(configFile>>"CfgRanks">>str _r>>"texture")
} else {
	private _r = _this getVariable "d_2star";
	if (isNil "_r") then {
		_r = getMissionPath "pics\2star.paa";
		_this setVariable ["d_2star", _r];
	};
	_r
};
