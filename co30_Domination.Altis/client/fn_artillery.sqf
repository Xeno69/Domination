// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_artillery.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (!alive player || {isNull objectParent player && {(getPos player) # 2 > 10} || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}) exitWith {
	d_commandingMenuIniting = false;
};

disableSerialization;

#ifndef __TT__
if !(d_ari_available) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_145");
	d_commandingMenuIniting = false;
};
#else
if (d_player_side == blufor && {!d_ari_available_w} || {d_player_side == opfor && {!d_ari_available_e}}) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_145");
	d_commandingMenuIniting = false;
};
#endif

if ((d_with_ranked || {d_database_found}) && {score player < (d_ranked_a # 2)}) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_147", score player, d_ranked_a # 2];
	d_commandingMenuIniting = false;
};

#ifndef __TT__
if (d_ari_blocked) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_148");
	d_commandingMenuIniting = false;
};

missionNamespace setVariable ["d_ari_blocked", true, true];
player setVariable ["d_blocks_arty", true, true];
#else
private _dexit = false;
if (d_player_side == blufor) then {
	if (d_ari_blocked_w) exitWith {
		_dexit = true;
	};

	missionNamespace setVariable ["d_ari_blocked_w", true, true];
	player setVariable ["d_blocks_arty_w", true, true];
} else {
	if (d_player_side == opfor) then {
		if (d_ari_blocked_e) exitWith {
			_dexit = true;
		};

		missionNamespace setVariable ["d_ari_blocked_e", true, true];
		player setVariable ["d_blocks_arty_e", true, true];
	};
};
if (_dexit) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_148");
	d_commandingMenuIniting = false;
};
#endif

createDialog "d_ArtilleryDialog2";
d_commandingMenuIniting = false;

0 spawn d_fnc_artywait;
