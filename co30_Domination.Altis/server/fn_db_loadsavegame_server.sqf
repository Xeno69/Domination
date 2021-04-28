// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_sname", "_sender"];

diag_log ["DOM db loadsavegame _this:", _this];

__TRACE_1("","_sname")

private _dbresult = [];

if (!d_tt_ver) then {
	call {
		if (d_db_type == 0) exitWith {
			_dbresult = if (_sender != objNull) then {
				parseSimpleArray ("extdb3" callExtension format ["0:dom:missionGet:%1", toLower (worldName + _sname)]);
			} else {
				__TRACE("Before")
				_res = parseSimpleArray ("extdb3" callExtension format ["0:dom:missionGet2:%1", tolower (worldName + _sname + briefingname)]);
				__TRACE_1("","_res")
				_res
			};
			if (_dbresult # 0 == 1) then {
				_dbresult = _dbresult # 1;
			} else {
				_dbresult = [];
			};
		};
		if (d_db_type == 1) exitWith {
			if (_sender != objNull) then {
				_dbresult = ["missionGet", [toLower (worldName + _sname)]] call d_fnc_queryconfig;
			} else {
				_dbresult = ["missionGet2", [toLower (worldName + _sname + briefingname)]] call d_fnc_queryconfig;
			};
		};
	};
} else {
	call {
		if (d_db_type == 0) exitWith {
			_dbresult = if (_sender != objNull) then {
				parseSimpleArray ("extdb3" callExtension format ["0:dom:missionttGet:%1", tolower (worldName + _sname)]);
			} else {
				parseSimpleArray ("extdb3" callExtension format ["0:dom:missionttGet2:%1", tolower (worldName + _sname + briefingname)]);
			};
			if (_dbresult # 0 == 1) then {
				_dbresult = _dbresult # 1;
			} else {
				_dbresult = [];
			};
		};
		if (d_db_type == 1) exitWith {
			if (_sender != objNull) then {
				_dbresult = ["missionttGet", [toLower (worldName + _sname)]] call d_fnc_queryconfig;
			} else {
				_dbresult = ["missionttGet2", [toLower (worldName + _sname + briefingname)]] call d_fnc_queryconfig;
			};
		};
	};
};

__TRACE_1("","_dbresult")

#ifdef __DEBUG__
{
	diag_log _x;
} forEach (_dbresult # 0);
#endif

if (_dbresult isEqualTo []) exitWith {
	diag_log ["DOM db loadsavegame _dbresult is []:", _this];
	if (!isNull _sender) then {
		[7, _sname] remoteExecCall ["d_fnc_csidechat", _sender];
	} else {
		diag_log format [localize "STR_DOM_MISSIONSTRING_1752", _sname];
	};
};

_dbresult params ["_ar"];

__TRACE_1("","_ar")

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
if (d_with_targetselect_count > 0) then {
	d_mttargets_ar = [];
	{
		if !((_x # 3) in d_resolved_targets) then {
			d_mttargets_ar pushBack _x;
		};
	} forEach d_target_names;
};
__TRACE_1("","d_resolved_targets")
d_side_missions_random = _ar # 6;
d_current_mission_counter = _ar # 7;
d_searchintel = _ar # 8;
publicVariable "d_searchintel";
d_bonus_vecs_db = _ar # 9;
{
	private _isar = false;
	private _vtype = if (_x isEqualType []) then {
		_isar = true;
		_x # 0
	} else {
		_x
	};
	private _vec = createVehicle [_vtype, d_bonus_create_pos, [], 0, "NONE"];
	_vec allowDamage false;
	if (unitIsUAV _vec) then {
		private _uavgrp = createVehicleCrew _vec;
		_uavgrp deleteGroupWhenEmpty true;
		_vec allowCrewInImmobile true;
		[_vec, 7] call d_fnc_setekmode;
		if (d_pylon_lodout == 0 && {isClass ((configOf _vec)>>"Components">>"TransportPylonsComponent")}) then {
			_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
		};
	};
	_vec setVariable ["d_isspecialvec", true, true];
	private ["_endpos", "_dir"];
	if (_vec isKindOf "Air") then {
		if (d_bonus_air_positions_carrier isEqualTo []) then {
			_endpos = (d_bonus_air_positions # d_bap_counter) # 0;
			_dir = (d_bonus_air_positions # d_bap_counter) # 1;
			d_bap_counter = d_bap_counter + 1;
			if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
		} else {
			if (getNumber((configOf _vec) >> "tailHook") != 1) then {
				_endpos = (d_bonus_air_positions # d_bap_counter) # 0;
				_dir = (d_bonus_air_positions # d_bap_counter) # 1;
				d_bap_counter = d_bap_counter + 1;
				if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
			} else {
				_endpos = (d_bonus_air_positions_carrier # d_bacp_counter) # 0;
				private _aslheight = d_the_carrier getVariable "d_asl_height";
				if (isNil "_aslheight") then {
					_aslheight = (getPosASL d_FLAG_BASE) # 2;
				};
				_endpos set [2, _aslheight];
				_dir = (d_bonus_air_positions_carrier # d_bacp_counter) # 1;
				_vec setVariable ["d_oncarrier", true];
				d_bacp_counter = d_bacp_counter + 1;
				if (d_bacp_counter > (count d_bonus_air_positions_carrier - 1)) then {d_bacp_counter = 0};
			};
		};
	} else {
		_endpos = (d_bonus_vec_positions # d_bvp_counter) # 0;
		_dir = (d_bonus_vec_positions # d_bvp_counter) # 1;
		d_bvp_counter = d_bvp_counter + 1;
		if (d_bvp_counter > (count d_bonus_vec_positions - 1)) then {d_bvp_counter = 0};
		_vec setVariable ["d_liftit", true, true];
	};

	if (!_isar) then {
		_vec setDir _dir;
		_vec setVehiclePosition [_endpos, [], 0, "NONE"];
		[_vec, _endpos] spawn {
			sleep 0.2;
			(_this # 0) setVehiclePosition [(_this # 1), [], 1, "NONE"];
			sleep 0.2;
			(_this # 0) setVectorUp [0, 0, 1];
			sleep 0.5;
			(_this # 0) setDamage 0;
			(_this # 0) allowDamage true;
		};
	} else {
		_vec setDir (_x # 2);
		_vec setVehiclePosition [_x # 1, [], 0, "NONE"];
		[_vec, _x # 1] spawn {
			sleep 0.2;
			(_this # 0) setVehiclePosition [(_this # 1), [], 1, "NONE"];
			sleep 0.2;
			(_this # 0) setVectorUp [0, 0, 1];
			sleep 0.5;
			(_this # 0) setDamage 0;
			(_this # 0) allowDamage true;
		};
	};

	[_vec, 11] call d_fnc_setekmode;

	_vec addEventHandler ["getIn", {call d_fnc_sgetinvec}];
	
	_vec addEventHandler ["getOut", {call d_fnc_sgetoutvec}];
	
	if (_vec isKindOf "Air" && {getNumber ((configOf _vec) >> "EjectionSystem" >> "EjectionSeatEnabled") == 1}) then {
		_vec addEventHandler ["getOut", {call d_fnc_aftereject}];
	};
	
	d_bonus_vecs_db set [_forEachIndex, _vec];
} forEach d_bonus_vecs_db;

d_retaken_farpspos = if (count _ar >= 12) then {
	_ar # 11
} else {
	[]
};
__TRACE_1("","d_retaken_farpspos")
if (d_retaken_farpspos isEqualType [] && {d_retaken_farpspos isNotEqualTo []}) then {
	private _allflags = (allMissionObjects "FlagCarrierCore") select {(str _x) select [0, 9] isEqualTo "d_flag_bb"};
	{
		private _poss = _x;
		private _flag = objNull;
		private _idx = _allflags findIf {
			private _ret = _x distance2D _poss < 50;
			if (_ret) then {
				_flag = _x;
			};
			_ret
		};
		__TRACE_3("","_poss","_idx","_flag")
		if (_idx != -1) then {
			private _box = [_flag getVariable "d_farp_aboxmarker"] call d_fnc_aboxcreate;
			[_flag, _box] remoteExecCall ["d_fnc_ccreateboxfarp", [0, -2] select isDedicated];
			d_player_ammoboxes pushBack _box;
			publicVariable "d_player_ammoboxes";

			private _ma = _flag getVariable "d_farp_marker";
			if (!isNil "_ma") then {
				_ma setMarkerAlpha 1;
			};
			_flag setVariable ["d_farptaken", true, true];
		};
	} forEach d_retaken_farpspos;
};

if (count _ar >= 13 && {(_ar # 12) isEqualType []}) then {
	__TRACE_1("","d_vrespawn2_ar")
	{
		__TRACE_1("","_x")
		private _mvr2 = _x;
		_mvr2 params ["_num_v"];
		{
			if (_num_v == (_x # 1)) then {
				private _vec = _x # 0;
				_vec setDir (_mvr2 # 2);
				_vec setVehiclePosition [_mvr2 # 1, [], 0, "CAN_COLLIDE"];
				if ((_mvr2 # 3) > 0) then {
					if ((_mvr2 # 3) == 1) then {
						_vec setVariable ["d_ammobox", true, true];
					} else {
						private _boxpos = _vec modelToWorldVisual [4,0,0];
						__TRACE_1("","_boxpos")
						(boundingBoxReal _vec) params ["_p1", "_p2"];
						private _maxHeight = abs ((_p2 # 2) - (_p1 # 2)) / 2;
						__TRACE_1("","_maxHeight")
						_boxpos set [2, ((_vec distance (getPos _vec)) - _maxHeight) max 0];
						__TRACE_1("","_boxpos")
						[_boxpos, _vec] call d_fnc_CreateDroppedBox;
					};
				};
				if (count _mvr2 == 5 && {(_mvr2 # 4)}) then {
					if (d_with_mhq_camo == 0 && {!(_vec isKindOf "Air") && {!(_vec isKindOf "Ship")}}) then {
						_vec call d_fnc_mhq_net;
					};
					_vec setVariable ["d_MHQ_Deployed", true, true];
					[_vec, true] call d_fnc_mhqdepls;
					_vec setVariable ["d_MHQ_Depltime", time + 10, true]
				};
			};
		} forEach d_vrespawn2_ar;
	} forEach (_ar # 12);
};
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

private _fnc_tt_bonusvec = {
	params ["_vec_type", "_d_bonus_create_pos", "_d_bonus_air_positions", "_d_bap_counter", "_d_bonus_vec_positions", "_d_bvp_counter", "_side"];
	private _vec = createVehicle [_vec_type, _d_bonus_create_pos, [], 0, "NONE"];
	_vec allowDamage false;
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
	[_vec, _endpos] spawn {
		sleep 0.2;
		(_this # 0) setVehiclePosition [(_this # 1), [], 1, "NONE"];
		sleep 0.2;
		(_this # 0) setVectorUp [0, 0, 1];
		sleep 0.5;
		(_this # 0) setDamage 0;
		(_this # 0) allowDamage true;
	};
	_vec setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
	_vec setVariable ["d_isspecialvec", true, true];
	[_vec, 11] call d_fnc_setekmode;
	_vec addEventHandler ["getIn", {call d_fnc_sgetinvec}];

	_vec addEventHandler ["getOut", {call d_fnc_sgetoutvec}];

	if (_vec isKindOf "Air" && {getNumber((configOf _vec) >> "EjectionSystem" >> "EjectionSeatEnabled") == 1}) then {
		_vec addEventHandler ["getOut", {call d_fnc_aftereject}];
	};
	
	_vec
};

d_bonus_vecs_db_w = _ar # 9;
if (!isNil "d_bonus_vecs_db_w") then {
	{
		d_bonus_vecs_db_w set [_forEachIndex, [_x, d_bonus_create_pos_w, d_bonus_air_positions_w, d_bap_counter_w, d_bonus_vec_positions_w, d_bvp_counter_w, 2] call _fnc_tt_bonusvec];
	} forEach d_bonus_vecs_db_w;
} else {
	d_bonus_vecs_db_w = [];
};
d_bonus_vecs_db_e = _ar # 10;
if (!isNil "d_bonus_vecs_db_e") then {
	{
		d_bonus_vecs_db_e set [_forEachIndex, [_x, d_bonus_create_pos_e, d_bonus_air_positions_e, d_bap_counter_e, d_bonus_vec_positions_e, d_bvp_counter_e, 2] call _fnc_tt_bonusvec];
	} forEach d_bonus_vecs_db_e;
} else {
	d_bonus_vecs_db_e = [];
};
d_points_blufor = _ar # 11;
d_points_opfor = _ar # 12;
d_kill_points_blufor = _ar # 13;
d_kill_points_opfor = _ar # 14;
d_points_array = _ar # 15;
publicVariable "d_points_array";
#endif

#ifdef __DEBUG__
	{
		__TRACE_2("","_forEachIndex","_x")
	} forEach d_target_names;
#endif

{
#ifndef __TT__
	private _res = _x;
#else
	private _res = _x # 0;
#endif

	if (_res < count d_target_names) then {
		private _tgt_ar = d_target_names # _res;
		private _mar = format ["d_%1_dommtm", _tgt_ar # 1];
		__TRACE_3("","_res","_tgt_ar","_mar")
		[_mar, _tgt_ar # 0, "ELLIPSE", "ColorGreen", [ _tgt_ar # 2,  _tgt_ar # 2], "", 0, "", "", d_e_marker_color_alpha] call d_fnc_CreateMarkerGlobal;
	} else {
		diag_log format ["ATTENTION!!!, save %1 has more targets than are available in the mission (d_target_x)", _sname];
		diag_log ["_res", _res];
	};
} forEach d_resolved_targets;


if (!isNull _sender) then {
	[8, _sname] remoteExecCall ["d_fnc_csidechat", _sender];
};

diag_log format [localize "STR_DOM_MISSIONSTRING_1753", _sname];
