// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")

params ["_jumpobj"];
private _mode = _this # 3;

if (player distance2D _jumpobj > 15) exitWith {};

private _do_exit = false;
if (d_with_ranked || {d_database_found}) then {
	if (score player < (d_ranked_a # 4)) then {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_64", score player, d_ranked_a # 4];
		_do_exit = true;
	};
};

if (_do_exit) exitWith {};

if (isNil "d_next_jump_time") then {d_next_jump_time = -1};

if (d_HALOWaitTime > 0 && {_mode == 0 && {player distance2D _jumpobj < 15 && {d_next_jump_time > time}}}) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_65", floor ((d_next_jump_time - time) / 60), round (d_next_jump_time - time) mod 60];
};

d_global_jump_pos = [];
createDialog "d_ParajumpDialog";

waitUntil {!isNil "d_parajump_dialog_open" && {!d_parajump_dialog_open || {!d_player_canu}}};
if (d_player_canu) then {
	if (d_global_jump_pos isNotEqualTo []) then {
#ifndef __TT__
		[[d_global_jump_pos, 200, d_HALOJumpHeight] call d_fnc_GetRanJumpPoint] spawn d_fnc_pjump;
		if (d_with_ranked || {d_database_found}) then {
			[player, 8] remoteExecCall ["d_fnc_ascfc", 2];
		};
#else
		if (d_player_side == blufor) then {
			if (d_global_jump_pos inArea d_opfor_b_trig) exitWith {
				systemChat localize "STR_DOM_MISSIONSTRING_1707";
			};
			[[d_global_jump_pos, 200, d_HALOJumpHeight] call d_fnc_GetRanJumpPoint] spawn d_fnc_pjump;
			if (d_with_ranked || {d_database_found}) then {
				[player, 8] remoteExecCall ["d_fnc_ascfc", 2];
			};
		} else {
			if (d_player_side == opfor) then {
				if (d_global_jump_pos inArea d_blufor_b_trig) exitWith {
					systemChat localize "STR_DOM_MISSIONSTRING_1707";
				};
				[[d_global_jump_pos, 200, d_HALOJumpHeight] call d_fnc_GetRanJumpPoint] spawn d_fnc_pjump;
				if (d_with_ranked || {d_database_found}) then {
					[player, 8] remoteExecCall ["d_fnc_ascfc", 2];
				};
			};
		};
#endif
	};
} else {
	if (d_parajump_dialog_open) then {closeDialog 0};
};
