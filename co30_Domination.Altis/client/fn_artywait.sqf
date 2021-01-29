// by Xeno
#define THIS_FILE "fn_artywait.sqf"
#include "..\x_setup.sqf"

waitUntil {!isNil "d_arti_dialog_open" && {!isNil "d_arti_did_fire" || {!d_arti_dialog_open || {!d_player_canu}}}};

if (!d_player_canu) exitWith {
	if (d_arti_dialog_open) then {closeDialog 0};
#ifndef __TT__
	missionNamespace setVariable ["d_ari_blocked", false, true];
	player setVariable ["d_blocks_arty", nil, true];
#else
	if (d_player_side == blufor) then {
		missionNamespace setVariable ["d_ari_blocked_w", false, true];
		player setVariable ["d_blocks_arty_w", nil, true];
	} else {
		if (d_player_side == opfor) then {
			missionNamespace setVariable ["d_ari_blocked_e", false, true];
			player setVariable ["d_blocks_arty_e", nil, true];
		};
	};
#endif
};

if (isNil "d_arti_did_fire") then {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_152");
} else {
	d_arti_did_fire = nil;
};

#ifndef __TT__
missionNamespace setVariable ["d_ari_blocked", false, true];
player setVariable ["d_blocks_arty", nil, true];
#else
if (d_player_side == blufor) then {
	missionNamespace setVariable ["d_ari_blocked_w", false, true];
	player setVariable ["d_blocks_arty_w", nil, true];
} else {
	if (d_player_side == opfor) then {
		missionNamespace setVariable ["d_ari_blocked_e", false, true];
		player setVariable ["d_blocks_arty_e", nil, true];
	};
};
#endif