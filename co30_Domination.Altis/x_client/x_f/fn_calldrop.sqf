// by Xeno
#define THIS_FILE "fn_calldrop.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {
	d_commandingMenuIniting = false;
};

if (!alive player || {isNull objectParent player && {(getPosATLVisual player) # 2 > 10}}) exitWith {
	d_commandingMenuIniting = false;
};
if !(d_para_available) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_163");
	d_commandingMenuIniting = false;
};

if (d_with_ranked || {d_database_found && {score player < (d_ranked_a # 16)}}) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_164", score player, d_ranked_a # 16];
	d_commandingMenuIniting = false;
};

if (!d_no_ai && {d_drop_blocked}) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_165");
	d_commandingMenuIniting = false;
};

if (!d_no_ai) then {
	d_drop_blocked = true;
	publicVariable "d_drop_blocked";
};

["d_drop_zone", [0,0,0], "ICON", "ColorBlue", [1,1], localize "STR_DOM_MISSIONSTRING_500", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
["d_drop_marker_1", player, "ELLIPSE", "ColorYellow", [d_drop_max_dist, d_drop_max_dist], "", 0, "", "FDiagonal"] call d_fnc_CreateMarkerLocal;

d_x_drop_type = "";

createDialog "d_AirDropDialog";
d_commandingMenuIniting = false;

waitUntil {!isNil "d_airdrop_dialog_open" && {d_x_drop_type != "" || {!d_airdrop_dialog_open || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}}}};

deleteMarkerLocal "d_drop_marker_1";

if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {
	if (d_airdrop_dialog_open) then {closeDialog 0};
	deleteMarkerLocal "d_drop_zone";
	if (!d_no_ai) then {
		d_drop_blocked = false; publicVariable "d_drop_blocked";
	};
};
if (d_x_drop_type != "") then {
	private _mpdz =+ markerPos "d_drop_zone";
	deleteMarkerLocal "d_drop_zone";
	if ((getPosWorld player) distance2D _mpdz > d_drop_max_dist) exitWith {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_166", d_drop_max_dist];
	};
	player sideChat format [localize "STR_DOM_MISSIONSTRING_167", [d_x_drop_type, "CfgVehicles"] call d_fnc_GetDisplayName];
	if (d_with_ranked || {d_database_found}) then {[player, (d_ranked_a # 16) * -1] remoteExecCall ["addScore", 2]};
	[d_x_drop_type, _mpdz, player] remoteExec ["d_fnc_createdrop", 2];
} else {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_168");
	deleteMarkerLocal "d_drop_zone";
};

if (!d_no_ai) then {
	d_drop_blocked = false;
	publicVariable "d_drop_blocked";
};