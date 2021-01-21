// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addpylon_action.sqf"
#include "..\x_setup.sqf"

if (!hasInterface || {!isNil {_this getVariable "d_plyonloadoutaction"}}) exitWith {};

private _condstr = if (!unitIsUAV _this) then {
	"speed _target == 0 && {!isEngineOn _target && {d_player_canu && {player == driver _target && {d_add_resp_points_pos findIf {_x distance2D _target < 700} > -1}}}}"
} else {
	"speed _target == 0 && {!isEngineOn _target && {d_add_resp_points_pos findIf {_x distance2D _target < 700} > -1 && {isNil {_target getVariable 'd_pylon_blocked'} && {d_player_canu}}}}"
}; 

_this setVariable ["d_plyonloadoutaction", [
		/* 0 object */						_this,
		/* 1 action title */				localize "STR_DOM_MISSIONSTRING_1862",
		/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		/* 4 condition to show */			_condstr,
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
			d_pylon_vec = _this select 0;
			private _do_exit = false;
			if (unitIsUAV d_pylon_vec) then {
				if (d_pylon_vec getVariable ["d_pylon_blocked", false]) exitWith {
					_do_exit = true;
				};
				d_pylon_vec setVariable ["d_pylon_blocked", true, true];
			};
			if (!_do_exit) then {
				createDialog "D_PylonLoadoutDialog";
			};
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[],
		/* 11 action duration */			1,
		/* 12 priority */					-1,
		/* 13 remove on completion */		false,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd
];