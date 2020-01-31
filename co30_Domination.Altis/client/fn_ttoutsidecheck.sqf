// by Xeno
#define THIS_FILE "fn_ttoutsidecheck.sqf"
#include "..\x_setup.sqf"

sleep 5;

private _warning_level = 0;
private _next_warning = -1;

while {true} do {
	if (!isNil "d_tt_pcheck_curtrig") then {
		if (vehicle player in (list d_tt_pcheck_curtrig)) then {
			call {
				if (_warning_level == 0) exitWith {
					[localize "STR_DOM_MISSIONSTRING_1993", "SIDE", true] call d_fnc_HintChatMsg;
					_warning_level = 1;
					_next_warning = time + 10;
				};
				if (_warning_level == 1 && {time >= _next_warning}) exitWith {
					[localize "STR_DOM_MISSIONSTRING_1994", "SIDE", true] call d_fnc_HintChatMsg;
					_warning_level = 2;
					_next_warning = time + 10;
				};
				if (_warning_level == 2 && {time >= _next_warning}) exitWith {
					{
						_x setDamage 1;
					} forEach crew (vehicle player);
					_warning_level = 3;
				};
			};
		} else {
			if (_warning_level != 0) then {_warning_level = 0};
			d_tt_pcheck_curtrig = nil;
		};
	};
	sleep 1;
};