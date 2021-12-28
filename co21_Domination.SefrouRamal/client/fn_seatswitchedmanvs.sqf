// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_switcher", "", "_vec"];

if (_vec isKindOf "Air") then {
	if (!d_with_ace) then {
		if (currentPilot _vec != player) then {
			if (isNil {_vec getVariable "d_rappel_self_action"}) then {
				_vec setVariable ["d_rappel_self_action", [
						/* 0 object */						_vec,
						/* 1 action title */				localize "STR_DOM_MISSIONSTRING_1863",
						/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
						/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
						/* 4 condition to show */			"[player, vehicle player] call AR_fnc_Rappel_From_Heli_Action_Check",
						/* 5 condition for action */		"true",
						/* 6 code executed on start */		{},
						/* 7 code executed per tick */		{},
						/* 8 code executed on completion */	{
							[player, vehicle player] call AR_fnc_Rappel_From_Heli_Action;
						},
						/* 9 code executed on interruption */	{},
						/* 10 arguments */					[],
						/* 11 action duration */			1,
						/* 12 priority */					-1,
						/* 13 remove on completion */		false,
						/* 14 show unconscious */			false
					] call bis_fnc_holdActionAdd
				];
			};
		} else {
			if (!isNil {_vec getVariable "d_rappel_self_action"}) then {
				[_vec, _vec getVariable "d_rappel_self_action"] call bis_fnc_holdActionRemove;
				_vec setVariable ["d_rappel_self_action", nil];
			};
		};
	};
	if (currentPilot _vec != player) then {
		if (!isNil {_vec getVariable "d_plyonloadoutaction"}) then {
			[_vec, _vec getVariable "d_plyonloadoutaction"] call bis_fnc_holdActionRemove;
			_vec setVariable ["d_plyonloadoutaction", nil];
		};
	} else {
		if (d_pylon_lodout == 0 && {!unitIsUAV _vec && {isClass ((configOf _vec)>>"Components">>"TransportPylonsComponent") && {isNil {_vec getVariable "d_disable_pylonloadout"}}}}) then {
			_vec call d_fnc_addpylon_action;
		};
	};
};
