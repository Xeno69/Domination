// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_db_loadsavegame_server.sqf"
#include "..\..\x_setup.sqf"

params ["_sname", "_sender"];

__TRACE_1("","_sname")

#ifndef __TT__
private _dbresult = if (_sender != objNull) then {
	parseSimpleArray ("extdb3" callExtension format ["0:dom:missionGet:%1", toLower (worldName + _sname)]);
} else {
	parseSimpleArray ("extdb3" callExtension format ["0:dom:missionGet2:%1", tolower (worldName + _sname + briefingname)]);
};
#else
private _dbresult = if (_sender != objNull) then {
	parseSimpleArray ("extdb3" callExtension format ["0:dom:missionttGet:%1", tolower (worldName + _sname)]);
} else {
	parseSimpleArray ("extdb3" callExtension format ["0:dom:missionttGet2:%1", tolower (worldName + _sname + briefingname)]);
};
#endif

__TRACE_1("","_dbresult")

if (_dbresult # 0 != 1 || {(_dbresult # 1) isEqualTo []}) exitWith {
	if (!isNull _sender) then {
		[format [localize "STR_DOM_MISSIONSTRING_1752", _sname], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", _sender];
	} else {
		diag_log format [localize "STR_DOM_MISSIONSTRING_1752", _sname];
	};
};

(_dbresult # 1) params ["_ar"];

#ifndef __TT__
d_maintargets = _ar # 0;
publicVariable "d_MainTargets";
d_maintargets_list = _ar # 1;
//d_current_target_index = _ar # 2;
//publicVariable "d_current_target_index";
//d_cur_sm_idx = _ar # 3;
//publicVariable "d_cur_sm_idx";
d_resolved_targets = _ar # 4;
publicVariable "d_resolved_targets";
__TRACE_1("","d_resolved_targets")
d_side_missions_random = _ar # 6;
d_current_mission_counter = _ar # 7;
d_searchintel = _ar # 8;
publicVariable "d_searchintel";
d_bonus_vecs_db = _ar # 9;
{
	private _vec = createVehicle [_x, d_bonus_create_pos, [], 0, "NONE"];
	if (unitIsUAV _vec) then {
		createVehicleCrew _vec;
		_vec allowCrewInImmobile true;
	};
	private ["_endpos", "_dir"];
	if (_vec isKindOf "Air") then {
		_endpos = (d_bonus_air_positions # d_bap_counter) # 0;
		_dir = (d_bonus_air_positions # d_bap_counter) # 1;
		d_bap_counter = d_bap_counter + 1;
		if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
	} else {
		_endpos = (d_bonus_vec_positions # d_bvp_counter) # 0;
		_dir = (d_bonus_vec_positions # d_bvp_counter) # 1;
		d_bvp_counter = d_bvp_counter + 1;
		if (d_bvp_counter > (count d_bonus_vec_positions - 1)) then {d_bvp_counter = 0};
		_vec setVariable ["d_liftit", true, true];
	};

	_vec setDir _dir;
	_vec setVehiclePosition [_endpos, [], 0, "NONE"];

	_vec addMPEventHandler ["MPKilled", {if (isServer) then {_this # 0 setFuel 0; _this call d_fnc_bonusvecfnc}}];
	
	_vec addEventHandler ["getIn", {
		private _ma = (_this select 0) getVariable "d_abandoned_ma";
		if (!isNil "_ma") then {
			deleteMarker _ma;
			(_this select 0) setVariable ["d_abandoned_ma", nil];
		};
	}];

	_vec addEventHandler ["getOut", {
		params ["_vec"];
		if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vec distance2D d_FLAG_BASE > 800}}) then {
			_vec setVariable ["d_abandoned_ma", [format ["%1_ab%2", _vec, time], _vec, "ICON", "ColorBlue", [1,1], format [localize "STR_DOM_MISSIONSTRING_1566", [typeOf _vec, "CfgVehicles"] call d_fnc_GetDisplayName], 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal];
		};
	}];
	d_bonus_vecs_db set [_forEachIndex, _vec];
} forEach d_bonus_vecs_db;
#else
d_maintargets = _ar # 0;
publicVariable "d_maintargets";
d_maintargets_list = _ar # 1;
//d_current_target_index = _ar # 2;
//publicVariable "d_current_target_index";
//d_cur_sm_idx = _ar # 3;
//publicVariable "d_cur_sm_idx";
d_resolved_targets = _ar # 4;
publicVariable "d_resolved_targets";
d_side_missions_random = _ar # 6;
d_current_mission_counter = _ar # 7;
d_searchintel = _ar # 8;
publicVariable "d_searchintel";

_fnc_tt_bonusvec = {
	params ["_vec_type", "_d_bonus_create_pos", "_d_bonus_air_positions", "_d_bap_counter", "_d_bonus_vec_positions", "_d_bvp_counter", "_side"];
	private _vec = createVehicle [_vec_type, _d_bonus_create_pos, [], 0, "NONE"];
	private ["_endpos", "_dir"];
	if (_vec isKindOf "Air") then {
		_endpos = (_d_bonus_air_positions # _d_bap_counter) # 0;
		_dir = (_d_bonus_air_positions # _d_bap_counter) # 1;
		_vec setVariable ["D_VEC_SIDE", _side];
		if (_side == 1) then {
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count _d_bonus_air_positions - 1)) then {d_bap_counter_e = 0};
		} else {
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count _d_bonus_air_positions - 1)) then {d_bap_counter_w = 0};
		};
	} else {
		_endpos = (_d_bonus_vec_positions # _d_bvp_counter) # 0;
		_dir = (_d_bonus_vec_positions # _d_bvp_counter) # 1;
		_vec setVariable ["D_VEC_SIDE", _side];
		if (_side == 1) then {
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_e = 0};
		} else {
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_w = 0};
		};
		_vec setVariable ["d_liftit", true, true];
	};
	_vec setDir _dir;
	_vec setVehiclePosition [_endpos, [], 0, "NONE"];
	_vec setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
	_vec addMPEventHandler ["MPKilled", {if (isServer) then {_this # 0 setFuel 0;_this call d_fnc_bonusvecfnc}}];
	_vec addEventHandler ["getIn", {
		private _ma = (_this select 0) getVariable "d_abandoned_ma";
		if (!isNil "_ma") then {
			deleteMarker _ma;
			(_this select 0) setVariable ["d_abandoned_ma", nil];
		};
	}];

	_vec addEventHandler ["getOut", {
		params ["_vec"];
		private _vside = _vec getVariable "D_VEC_SIDE";
		if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vside == 2 && {_vec distance2D d_WFLAG_BASE > 800} || {_vside == 1 && {_vec distance2D d_EFLAG_BASE > 800}}}}) then {
			_vec setVariable ["d_abandoned_ma", [format ["%1_ab%2", _vec, time], _vec, "ICON", "ColorBlue", [1,1], format [localize "STR_DOM_MISSIONSTRING_1566", [typeOf _vec, "CfgVehicles"] call d_fnc_GetDisplayName], 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal];
			if (_vside == 1) then {
				(_vec getVariable "d_abandoned_ma") remoteExecCall ["deleteMarkerLocal", west];
			} else {
				(_vec getVariable "d_abandoned_ma") remoteExecCall ["deleteMarkerLocal", east];
			};
		};
	}];
	_vec
};

d_bonus_vecs_db_w = _ar # 9;
{
	d_bonus_vecs_db set [_forEachIndex, [_x, d_bonus_create_pos_w, d_bonus_air_positions_w, d_bap_counter_w, d_bonus_vec_positions_w, d_bvp_counter_w, 2] call _fnc_tt_bonusvec];
} forEach d_bonus_vecs_db_w;
d_bonus_vecs_db_e = _ar # 10;
{
	d_bonus_vecs_db set [_forEachIndex, [_x, d_bonus_create_pos_e, d_bonus_air_positions_e, d_bap_counter_e, d_bonus_vec_positions_e, d_bvp_counter_e, 2] call _fnc_tt_bonusvec];
} forEach d_bonus_vecs_db_e;
d_points_blufor = _ar # 11;
d_points_opfor = _ar # 12;
d_kill_points_blufor = _ar # 13;
d_kill_points_opfor = _ar # 14;
d_points_array = _ar # 15;
publicVariable "d_points_array";
#endif

{
#ifndef __TT__
	private _res = _x;
#else
	private _res = _x # 0;
#endif
	
	private _tgt_ar = d_target_names # _res;
	private _mar = format ["d_%1_dommtm", _tgt_ar # 1];
	[_mar, _tgt_ar # 0, "ELLIPSE", "ColorGreen", [ _tgt_ar # 2,  _tgt_ar # 2]] call d_fnc_CreateMarkerGlobal;
	_mar setMarkerAlpha d_e_marker_color_alpha;
} forEach d_resolved_targets;


if (!isNull _sender) then {
	[_sender, ["dDBLoad", [localize "STR_DOM_MISSIONSTRING_1750", "<font face='RobotoCondensed' size=24 color='#ffffff'>" + format [localize "STR_DOM_MISSIONSTRING_1753", _sname] + "</font>"]]] remoteExecCall ["createDiaryRecord", _sender];
};
