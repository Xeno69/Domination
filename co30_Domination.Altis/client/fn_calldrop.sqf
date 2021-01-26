// by Xeno
#define THIS_FILE "fn_calldrop.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {
	d_commandingMenuIniting = false;
};

if (!alive player || {isNull objectParent player && {(getPosATLVisual player) # 2 > 10}}) exitWith {
	d_commandingMenuIniting = false;
};
if !(d_para_available) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_163");
	d_commandingMenuIniting = false;
};

if ((d_with_ranked || {d_database_found}) && {score player < (d_ranked_a # 16)}) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_164", score player, d_ranked_a # 16];
	d_commandingMenuIniting = false;
};

if (!d_no_ai && {d_drop_blocked}) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_165");
	d_commandingMenuIniting = false;
};

if (!d_no_ai) then {
	missionNamespace setVariable ["d_drop_blocked", true, true];
};

["d_drop_zone", [0,0,0], "ICON", "ColorBlue", [1,1], localize "STR_DOM_MISSIONSTRING_500", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
["d_drop_marker_1", player, "ELLIPSE", "ColorYellow", [d_drop_max_dist, d_drop_max_dist], "", 0, "", "FDiagonal"] call d_fnc_CreateMarkerLocal;

d_x_drop_type = "";

createDialog "d_AirDropDialog";
d_commandingMenuIniting = false;

waitUntil {!isNil "d_airdrop_dialog_open" && {d_x_drop_type != "" || {!d_airdrop_dialog_open || {!d_player_canu}}}};

deleteMarkerLocal "d_drop_marker_1";

if (!d_player_canu) exitWith {
	if (d_airdrop_dialog_open) then {closeDialog 0};
	deleteMarkerLocal "d_drop_zone";
	if (!d_no_ai) then {
		missionNamespace setVariable ["d_drop_blocked", false, true];
	};
};
if (d_x_drop_type != "") then {
	private _mpdz =+ markerPos "d_drop_zone";
	deleteMarkerLocal "d_drop_zone";
	if ((getPosWorld player) distance2D _mpdz > d_drop_max_dist) exitWith {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_166", d_drop_max_dist];
	};
	player sideChat format [localize "STR_DOM_MISSIONSTRING_167", [d_x_drop_type, "CfgVehicles"] call d_fnc_GetDisplayName];
	if (d_with_ranked || {d_database_found}) then {[player, 4] remoteExecCall ["d_fnc_ascfc", 2]};
	[d_x_drop_type, _mpdz, player, d_player_side] remoteExec ["d_fnc_createdrop", 2];
} else {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_168");
	deleteMarkerLocal "d_drop_zone";
};

if (!d_no_ai) then {
	missionNamespace setVariable ["d_drop_blocked", false, true];
};