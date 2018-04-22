// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_inventoryopened.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

__TRACE_1("","_this")
private _box = param [1];

if (_box getVariable ["d_player_ammobox", false]) then {
	_box spawn {
		if (!d_with_ranked) then {
			["Open", true] call bis_fnc_arsenal;
		} else {
			["Open", [nil, _this]] call bis_fnc_arsenal;
		};
	};
	true
} else {
	false
};
