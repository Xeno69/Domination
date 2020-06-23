// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addpushaction.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_vec"];

__TRACE_1("","_vec");

if (!isNil {_vec getVariable "d_push_action"}) exitWith {};

_vec setVariable ["d_push_action", [
		/* 0 object */						_vec,
		/* 1 action title */				localize "STR_DOM_MISSIONSTRING_2033",
		/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		/* 4 condition to show */			"isNull objectParent player && {player distance2D _target < 5 && {!(surfaceIsWater (getPosASL player)) && {isNull attachedTo _target}}}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
			// todo, check if there is water in about 2-3 meters away from the pushers direction
			_target setVelocity [(sin (direction _caller)) * 3, (cos (direction _caller)) * 3, 0];
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[],
		/* 11 action duration */			0.5,
		/* 12 priority */					-1,
		/* 13 remove on completion */		false,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd
];
