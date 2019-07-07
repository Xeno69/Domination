// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addactionstd.sqf"
#include "..\x_setup.sqf"
__TRACE_1("","_this")

if (!hasInterface) exitWith {};

_this addAction ["Open Terminal", {[_this select 0, 3] call BIS_fnc_dataTerminalAnimate}, nil, 1, true, true, "", "_target animationSourcePhase 'Antenna_source' == 0&& {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}", 5];

[
	/* 0 object */						_this,
	/* 1 action title */				localize "STR_DOM_MISSIONSTRING_1839",
	/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	/* 4 condition to show */			"_target animationSourcePhase 'Antenna_source' == 3 && {!d_data_was_send && {player distance2D _target <= 5 && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}}",
	/* 5 condition for action */		"true",
	/* 6 code executed on start */		{systemChat (localize "STR_DOM_MISSIONSTRING_1838")},
	/* 7 code executed per tick */		{},
	/* 8 code executed on completion */	{d_data_was_send = true; publicVariable "d_data_was_send";},
	/* 9 code executed on interruption */	{systemChat (localize "STR_DOM_MISSIONSTRING_1843")},
	/* 10 arguments */					[],
	/* 11 action duration */			12,
	/* 12 priority */					-1,
	/* 13 remove on completion */		true,
	/* 14 show unconscious */			false
] call bis_fnc_holdActionAdd;