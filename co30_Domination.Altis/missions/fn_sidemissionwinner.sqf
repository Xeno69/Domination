// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_d_sm_winner", "_bonus_vecn"];

__TRACE_1("","_this")

sleep 1;

if (!isNil "d_sm_curptrigger") then {
	deleteVehicle d_sm_curptrigger;
	d_sm_curptrigger = nil;
};
if (!isNil "d_sm_curptrig_script") then {
	terminate d_sm_curptrig_script;
	d_sm_curptrig_script = nil;
};

d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_712";

if (_d_sm_winner != 0 && {_bonus_vecn != ""}) then {
	if (d_with_ranked || {d_database_found}) then {
		private _get_points = false;
		if (d_player_canu) then {
			if (isNil "d_sm_p_pos") then {
				if (player distance2D (d_x_sm_pos # 0) < d_ranked_a # 12) then {_get_points = true};
			} else {
				if (d_was_at_sm && {d_x_sm_type != "convoy" && {player distance2D d_sm_p_pos < d_ranked_a # 12}}) then {
					_get_points = true;
				};
			};
		};
		if (_get_points) then {
			0 spawn {
				scriptName "spawn_sidemissionwinner";
				sleep (0.5 + random 2);
				[player, 8] remoteExecCall ["d_fnc_addscore", 2];
			};
		};
		d_sm_p_pos = nil;
	};

	if (d_MissionType != 2) then {
		private _bonus_string = "";
		if (_bonus_vecn != "FAKE_VEC") then {
			_bonus_string = format [localize "STR_DOM_MISSIONSTRING_714", [_bonus_vecn, "CfgVehicles"] call d_fnc_GetDisplayName];
		};
#ifdef __TT__
		if (_d_sm_winner == 1 && {d_player_side == opfor} || {_d_sm_winner == 2 && {d_player_side == blufor} || {_d_sm_winner == 123}}) then {
#endif
		hint composeText[
			parseText("<t color='#00ff00' size='1.5'>" + localize "STR_DOM_MISSIONSTRING_1708" + "</t>"), lineBreak,lineBreak,
			parseText("<t color='#00ff00' size='1.3'>" + localize "STR_DOM_MISSIONSTRING_572" + "</t>"), lineBreak,lineBreak,
			parseText("<t color='#ffffffff' size='1.1'>" + d_current_mission_resolved_text + "</t>"), lineBreak, lineBreak,
			parseText("<t color='#ffffffff' size='1.1'>" + _bonus_string + "</t>")
		];
#ifdef __TT__
		} else {
			hint composeText[
				parseText("<t color='#ffffffff' size='1.5'>" + localize "STR_DOM_MISSIONSTRING_725" + "</t>"), lineBreak,lineBreak,
				localize "STR_DOM_MISSIONSTRING_1710"
			];
		};
#endif
	} else {
		hint composeText[
			parseText("<t color='#00ff00' size='1.5'>" + localize "STR_DOM_MISSIONSTRING_1708" + "</t>"), lineBreak,lineBreak,
			parseText("<t color='#00ff00' size='1.3'>" + localize "STR_DOM_MISSIONSTRING_572" + "</t>"), lineBreak,lineBreak,
			parseText("<t color='#ffffffff' size='1.1'>" + d_current_mission_resolved_text + "</t>")
		];
	};
} else {
	private _s = switch (_d_sm_winner) do {
		case -1: {localize "STR_DOM_MISSIONSTRING_716"};
		case -2: {localize "STR_DOM_MISSIONSTRING_717"};
		case -300: {localize "STR_DOM_MISSIONSTRING_718"};
		case -400: {localize "STR_DOM_MISSIONSTRING_719"};
		case -500: {localize "STR_DOM_MISSIONSTRING_720"};
		case -600: {localize "STR_DOM_MISSIONSTRING_721"};
		case -700: {localize "STR_DOM_MISSIONSTRING_722"};
		case -878: {localize "STR_DOM_MISSIONSTRING_723"};
		case -900: {localize "STR_DOM_MISSIONSTRING_724a"};
		case -1000: {localize "STR_DOM_MISSIONSTRING_1840"};
		case -1100: {localize "STR_DOM_MISSIONSTRING_1848"};
		case -1200: {localize "STR_DOM_MISSIONSTRING_1851"};
		default {""};
	};
	if (_s != "") then {
		hint composeText[
			parseText("<t color='#ffffffff' size='1.5'>" + (localize "STR_DOM_MISSIONSTRING_725") + "</t>"), lineBreak,lineBreak,
			_s
		];
	};
};

["d_sm_task"] call BIS_fnc_deleteTask;
