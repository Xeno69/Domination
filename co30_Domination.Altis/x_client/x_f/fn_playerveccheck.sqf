// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerveccheck.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

__TRACE_1("","_this")
private _vec = param [0];

if ((assignedVehicleRole player) # 0 == "Cargo" || {!isNil {_vec getVariable "d_vec_type"}}) exitWith {
	d_vec_role_pl = assignedVehicleRole player;
};

(_vec call d_fnc_allowedvec) params ["_not_allowed", "_needed_rank"];

if (_not_allowed) then {
	player action ["getOut", _vec];
	[format [localize "STR_DOM_MISSIONSTRING_308", (rank player) call d_fnc_GetRankString, _needed_rank, [typeOf _vec, "CfgVehicles"] call d_fnc_GetDisplayName], "HQ"] call d_fnc_HintChatMsg;
} else {
	d_vec_role_pl = assignedVehicleRole player;
};
