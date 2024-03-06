// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {
	d_commandingMenuIniting = false;
};

if (!alive player || {isNull objectParent player && {(getPosATLVisual player) # 2 > 10}}) exitWith {
	d_commandingMenuIniting = false;
};
if !(d_para_available) exitWith {
	[1, localize "STR_DOM_MISSIONSTRING_163"] call d_fnc_sideorsyschat;
	d_commandingMenuIniting = false;
};

if ((d_with_ranked || {d_database_found}) && {score player < (d_ranked_a # 16)}) exitWith {
	[1, format [localize "STR_DOM_MISSIONSTRING_164", score player, d_ranked_a # 16]] call d_fnc_sideorsyschat;
	d_commandingMenuIniting = false;
};

if (!d_no_ai && {!isNil "d_drop_blocked"}) exitWith {
	[1, localize "STR_DOM_MISSIONSTRING_165"] call d_fnc_sideorsyschat;
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

waitUntil {!isNil "d_airdrop_dialog_open" && {d_x_drop_type isNotEqualTo "" || {!d_airdrop_dialog_open || {!d_player_canu}}}};

deleteMarkerLocal "d_drop_marker_1";

if (!d_player_canu) exitWith {
	if (d_airdrop_dialog_open) then {closeDialog 0};
	deleteMarkerLocal "d_drop_zone";
	if (!d_no_ai) then {
		missionNamespace setVariable ["d_drop_blocked", nil, true];
	};
};
if (d_x_drop_type isNotEqualTo "") then {
	private _mpdz =+ markerPos "d_drop_zone";
	deleteMarkerLocal "d_drop_zone";
	if ((getPosWorld player) distance2D _mpdz > d_drop_max_dist) exitWith {
		[1, format [localize "STR_DOM_MISSIONSTRING_166", d_drop_max_dist]] call d_fnc_sideorsyschat;
	};
	private _displayname = "";
	if (d_x_drop_type in d_x_drop_array_custom_types) then {
		_displayname = localize "STR_DOM_MISSIONSTRING_400_EXTRA"; // generic word for custom airdrop
	} else {
		_displayname = [d_x_drop_type, "CfgVehicles"] call d_fnc_GetDisplayName;
	};
	[1, format [localize "STR_DOM_MISSIONSTRING_167", _displayname]] call d_fnc_sideorsyschat;
	if (d_with_ranked || {d_database_found}) then {[player, 4] remoteExecCall ["d_fnc_ascfc", 2]};
	[d_x_drop_type, _mpdz, player, d_player_side] remoteExec ["d_fnc_createdrop", 2];
} else {
	[1, localize "STR_DOM_MISSIONSTRING_168"] call d_fnc_sideorsyschat;
	deleteMarkerLocal "d_drop_zone";
};

if (!d_no_ai) then {
	missionNamespace setVariable ["d_drop_blocked", nil, true];
};