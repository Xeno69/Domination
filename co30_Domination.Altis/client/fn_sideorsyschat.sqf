// by Xeno
#include "..\x_setup.sqf"

params ["_kind", "_txt"];

if (!d_spe && {!d_ifa3}) then {
	call {
		if (_kind == 0) exitWith {
			player sideChat _txt;
		};
		[playerSide, "HQ"] sideChat _txt;
	};
} else {
	systemChat _txt;
};