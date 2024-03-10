// by Xeno
#include "..\x_setup.sqf"

params ["_kind", "_txt"];

if ("ItemRadio" in assignedItems player) then {
	call {
		if (_kind == 0) exitWith {
			player sideChat _txt;
		};
		[playerSide, "HQ"] sideChat _txt;
	};
} else {
	systemChat _txt;
};