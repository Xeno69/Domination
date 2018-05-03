// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankpic.sqf"
#include "..\..\x_setup.sqf"

private _r = _this getVariable "d_player_old_rank";
if (isNil "_r") then {
	_r = (rank _this) call d_fnc_getrankindex;
};
getText(configFile>>"CfgRanks">>str _r>>"texture")
