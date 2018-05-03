// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getrankstring.sqf"
#include "..\..\x_setup.sqf"

private _r = call {
	if (_this isEqualType "") exitWith {
		_this call d_fnc_getrankindex
	};
	if (_this isEqualType 1) exitWith {
		_this
	};
	private _tr = _this getVariable "d_player_old_rank";
	if (isNil "_tr") then {
		_tr = (_rank _this) call d_fnc_getrankindex;
	};
	_tr
};
getText(configFile>>"CfgRanks">>str _r>>"displayName")
