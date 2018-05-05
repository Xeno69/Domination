// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_startclientscripts.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}) exitWith {};
if (!(d_clientScriptsAr # 0) && {(isMultiplayer && {d_pisadminp}) || {!isMultiplayer}}) then {
	d_clientScriptsAr set [0, true];
	//call d_fnc_isAdmin;
	execFSM "fsms\fn_IsAdmin.fsm";
};
if (!(d_clientScriptsAr # 1) && {!isNil "d_player_autokick_time"}) then {
	if (time >= d_player_autokick_time) exitWith {
		d_clientScriptsAr set [1, true];
		d_player_autokick_time = nil;
	};
	private _vec = vehicle player;
	if (_vec != player && {_vec isKindOf "Air"}) then {
		private _type = toUpper (typeOf _vec);
#ifndef __TT__
		if ((_type in d_mt_bonus_vehicle_array || {_type in d_sm_bonus_vehicle_array}) && {player == driver _vec || {player == gunner _vec || {player == commander _vec}}}) then {
#else
		private _numside = if (d_player_side == blufor) then {2} else {1};
		if ((_type in (d_mt_bonus_vehicle_array # _numside) || {_type in (d_sm_bonus_vehicle_array # _numside)}) && {player == driver _vec || {player == gunner _vec || {player == commander _vec}}}) then {
#endif
			player action ["getOut", _vec];
			private _type_name = [_type, "CfgVehicles"] call d_fnc_GetDisplayName;
			private _minutes = round ((d_player_autokick_time - time) / 60) max 1;
			[format [localize "STR_DOM_MISSIONSTRING_1416", _type_name, _minutes], "HQ"] call d_fnc_HintChatMsg;
		};
	};
};