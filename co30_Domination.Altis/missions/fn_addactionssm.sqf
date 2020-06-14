// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addactionssm.sqf"
#include "..\x_setup.sqf"
__TRACE_1("","_this")

if (!hasInterface) exitWith {};

params ["_obj", "_type"];

if (_type == 0) exitWith {
	_obj addAction [localize "STR_DOM_MISSIONSTRING_2024", {[_this select 0, 3] call BIS_fnc_dataTerminalAnimate}, nil, 1, true, true, "", "_target animationSourcePhase 'Antenna_source' == 0 && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}", 5];

	[
		/* 0 object */						_obj,
		/* 1 action title */				localize "STR_DOM_MISSIONSTRING_1839",
		/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		/* 4 condition to show */			"_target animationSourcePhase 'Antenna_source' == 3 && {!d_data_was_send && {player distance2D _target <= 5 && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}}}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{systemChat (localize "STR_DOM_MISSIONSTRING_1838")},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
#ifdef __TT__
			d_sm_side_caller = side group _caller;
			publicVariable "d_sm_side_caller";
#endif
			d_data_was_send = true;
			publicVariable "d_data_was_send";
			systemChat (localize "STR_DOM_MISSIONSTRING_1843");
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[],
		/* 11 action duration */			12,
		/* 12 priority */					-1,
		/* 13 remove on completion */		true,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd;
};

if (_type == 1) exitWith {
	[
		/* 0 object */						_obj,
		/* 1 action title */				localize "STR_DOM_MISSIONSTRING_2025",
		/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
		/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
		/* 4 condition to show */			"!d_sm_leak_sealed && {player distance2D _target <= 6 && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{systemChat (localize "STR_DOM_MISSIONSTRING_2026")},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
#ifdef __TT__
			d_sm_side_caller = side group _caller;
			publicVariable "d_sm_side_caller";
#endif
			d_sm_leak_sealed = true;
			publicVariable "d_sm_leak_sealed";
			systemChat (localize "STR_DOM_MISSIONSTRING_2027");
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[],
		/* 11 action duration */			12,
		/* 12 priority */					-1,
		/* 13 remove on completion */		true,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd;
};

if (_type == 2) exitWith {
	private _idx = [
		/* 0 object */						_obj,
		/* 1 action title */				localize "STR_DOM_MISSIONSTRING_2031",
		/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
		/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
		/* 4 condition to show */			"!d_sm_farpseized && {player distance2D _target <= 6 && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{systemChat (localize "STR_DOM_MISSIONSTRING_2032")},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
			d_sm_farpseized = true;
			publicVariable "d_sm_farpseized";
			systemChat (localize "STR_DOM_MISSIONSTRING_2030");
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[],
		/* 11 action duration */			12,
		/* 12 priority */					-1,
		/* 13 remove on completion */		true,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd;
	_obj setVariable ["d_sm_holdactionidx", _idx];
};