// by Xeno
// #define __DEBUG__
#define THIS_FILE "fn_addselfhealaction.sqf"
#include "..\..\x_macros.sqf"

player setVariable ["xr_selfh_ac_id", [
		/* 0 object */						player,
		/* 1 action title */				format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1867"],
		/* 2 idle icon */					"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
		/* 3 progress icon */				"A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_reviveMedic_ca.paa",
		/* 4 condition to show */			"alive _target &&  {!(_target getVariable 'xr_pluncon') && {!(_target getVariable 'xr_pisinaction') && {damage _target >= xr_selfheals_minmaxdam # 0 && {damage _target <= xr_selfheals_minmaxdam # 1 && {_target getVariable 'xr_numheals' > 0}}}}}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{player setVariable ["xr_pisinaction", true]},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
			if (alive player && {!(player getVariable "xr_pluncon")}) then {
				player setDamage 0;
				player setVariable ["xr_numheals", (player getVariable "xr_numheals") - 1];
			};
			player setVariable ["xr_pisinaction", false];
		},
		/* 9 code executed on interruption*/{player setVariable ["xr_pisinaction", false]},
		/* 10 arguments */					[],
		/* 11 action duration */			6,
		/* 12 priority */					-1,
		/* 13 remove on completion */		false,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd
];