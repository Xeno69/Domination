// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_call_cas.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

#ifndef __TT__
if !(d_cas_available) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_1712");
};
#else
if (d_player_side == blufor && {!d_cas_available_w} || {d_player_side == opfor && {!d_cas_available_e}}) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_1712");
};
#endif

if (d_with_ranked || {d_database_found && {score player < d_ranked_a # 22}}) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_1713", score player, d_ranked_a # 22];
};

#ifndef __IFA3LITE__
private _lt = laserTarget player;

__TRACE_1("","_lt")

if (isNil "_lt" || {isNull _lt}) exitWith {
	// laser target not valid
};

private _pos_lt = getPos _lt;
#else
private _pos_lt = screenToWorld [0.5, 0.5];
#endif
__TRACE_1("","_pos_lt")

#ifdef __DEBUG__
_arrow = "Sign_Arrow_Large_F" createVehicleLocal [0,0,0];
_arrow setPos _pos_lt;
#endif

if (player distance2D _pos_lt < 30) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_1529");
};

[_pos_lt, netId player, 2] remoteExec ["d_fnc_moduleCAS", 2];
