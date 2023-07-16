// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private "_pos_lt";
private _do_exit = false;

if (!d_ifa3 && {!d_gmcwg && {!d_unsung && {!d_csla && {!d_vn && {!d_spe}}}}}) then {
	private _lt = laserTarget player;

	__TRACE_1("","_lt")

	if (isNil "_lt" || {isNull _lt}) exitWith {
		// laser target not valid
		_do_exit = true;
	};

	_pos_lt = getPos _lt;
	_pos_lt set [2, 0];

	__TRACE_1("","_pos_lt")
} else {
	_pos_lt = screenToWorld [0.5, 0.5];
};
if (_do_exit) exitWith {};
__TRACE_1("","_pos_lt")

#ifdef __DEBUG__
_arrow = "Sign_Arrow_Large_F" createVehicle [0,0,0];
_arrow setPos _pos_lt;
#endif

if (player distance2D _pos_lt < 10 && {!isStreamFriendlyUIEnabled}) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_1529");
};

["d_temp_mark_arty_marker", _pos_lt, "ICON", d_color_m_marker, [1, 1], d_name_pl, 0, d_arty_m_marker] call d_fnc_CreateMarkerLocal;

d_ari_type = "";
d_ari_salvos = 1;
createDialog "d_MarkArtilleryDialog";

waitUntil {!isNil "d_markarti_dialog_open" && {d_ari_type != "" || {!d_markarti_dialog_open || {!d_player_canu}}}};

deleteMarkerLocal "d_temp_mark_arty_marker";
if (!d_player_canu) exitWith {
	if (d_markarti_dialog_open) then {closeDialog 0};
};

__TRACE_2("","d_ari_type","d_ari_salvos")

if (d_ari_type != "") then {
	[netId player, _pos_lt, d_name_pl, d_ari_type, d_ari_salvos] remoteExecCall ["d_fnc_at_serv", 2];
	if (!isStreamFriendlyUIEnabled) then {
		systemChat format [localize "STR_DOM_MISSIONSTRING_1523", mapGridPosition _pos_lt];
	};
} else {
	if (!isStreamFriendlyUIEnabled) then {
		[1, localize "STR_DOM_MISSIONSTRING_1525"] call d_fnc_sideorsyschat;
	};
};
