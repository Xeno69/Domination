// by Xeno
#include "..\x_setup.sqf"

params ["_kind", "_txt"];

#ifndef __VN__
if ("ItemRadio" in assignedItems player) then {
#else
if ("vn_b_item_radio_urc1" in assignedItems player) then {
#endif
	call {
		if (_kind == 0) exitWith {
			player sideChat _txt;
		};
		[playerSide, "HQ"] sideChat _txt;
	};
} else {
	systemChat _txt;
};