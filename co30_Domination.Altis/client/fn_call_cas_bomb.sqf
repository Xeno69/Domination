// by Xeno edited by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

#ifndef __TT__
if !(d_cas_available) exitWith {
	[1, localize "STR_DOM_MISSIONSTRING_1712"] call d_fnc_sideorsyschat;
};
#else
if (d_player_side == blufor && {!d_cas_available_w} || {d_player_side == opfor && {!d_cas_available_e}}) exitWith {
	[1, localize "STR_DOM_MISSIONSTRING_1712"] call d_fnc_sideorsyschat;
};
#endif

if ((d_with_ranked || {d_database_found}) && {score player < (d_ranked_a # 22)}) exitWith {
	[1, format [localize "STR_DOM_MISSIONSTRING_1713", score player, d_ranked_a # 22]] call d_fnc_sideorsyschat;
};

private "_target";
private _do_exit = false;
private _do_cleanup = false;

if (!d_ifa3 && {!d_gmcwg && {!d_unsung && {!d_csla && {!d_vn && {!d_spe}}}}}) then {
	_target = laserTarget player;
	__TRACE_1("","_target")
	if (isNil "_target" || {isNull _target}) exitWith {
		// laser target not valid
		_do_exit = true;
	};
} else {
	_target = d_HeliHEmpty createVehicle [screenToWorld [0.5, 0.5]]; // good but leaves markers around
	_do_cleanup = true;
};
if (_do_exit) exitWith {
	diag_log ["exiting, no valid CAS bomb target"];
};
__TRACE_1("","_target")

#ifdef __DEBUG__
_arrow = "Sign_Arrow_Large_F" createVehicle [10, 10, 10];
_arrow setPos (getPosASL _target);
#endif

if (player distance2D _target < 30) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_1529");
};

if (d_sm_mt_protectionAI > 0 && {_pos_lt call d_fnc_ac_ai_check}) exitWith {};

[_target, netId player, 0] remoteExec ["d_fnc_moduleCAS_bomb", 2];

if (_do_cleanup) then {
	deleteVehicle _target;
};