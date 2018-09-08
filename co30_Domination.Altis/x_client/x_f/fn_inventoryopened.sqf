// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_inventoryopened.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

__TRACE_1("","_this")
private _box = _this select 1;

if (_box getVariable ["d_player_ammobox", false]) then {
	_box spawn {
		if (!d_with_ranked) then {
			if (!d_with_ace) then {
				["Open", true] call bis_fnc_arsenal;
			} else {
				[player, player, true] call ace_arsenal_fnc_openBox;
			};
		} else {
			["Open", [nil, player]] call bis_fnc_arsenal;
		};
	};
	true
} else {
	false
};
