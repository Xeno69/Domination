// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createarmor.sqf"
#include "..\x_setup.sqf"

if (d_WithLessArmor_side == 2) exitWith {[]};

__TRACE_1("","_this")

private _pos_center = _this # 6;
if (isNil "_pos_center") exitWith {
	diag_log "_pos_center in fn_createarmor.sqf undefined!!!";
	if (!isNil "_fnc_scriptNameParent") then {
		diag_log ["fn_createarmor.sqf _fnc_scriptNameParent: ", _fnc_scriptNameParent];
	};
	diag_log ["fn_createarmor.sqf _this: ", _this];
};
private _radius = _this # 8;
private _do_patrol = if (_radius < 50) then {false} else {if (count _this == 10) then {_this # 9} else {false}};
__TRACE_3("","_pos_center","_radius","_do_patrol")
private _ret_grps = [];

_with_less_armor_side = if (d_WithLessArmor_side == -1) then {
	selectRandom [0, 1, 2];
} else {
	d_WithLessArmor_side;
};

for "_nr" from 0 to 2 do {
	private _nrg = [_this # (1 + (_nr * 2)), selectRandom [0, 1]] select (_with_less_armor_side == 1);
	__TRACE_1("","_nrg")
	if (_nrg > 0) then {
		if (d_MissionType == 2) then {_nrg = _nrg + 2};
		private _typenr = _this select (_nr * 2);
		private _istatatic = _typenr in ["stat_mg", "stat_gl"];
		__TRACE_1("","_typenr")
		for "_i" from 1 to _nrg do {
			private _newgroup = [d_side_enemy] call d_fnc_creategroup;
			__TRACE_1("","_newgroup")
			private "_pos";
			if (_radius > 0) then {
				_pos = [_pos_center, _radius, 2] call d_fnc_GetRanPointCircle;
				if (_pos isEqualTo []) then {
					for "_ee" from 0 to 99 do {
						_pos = [_pos_center, _radius, 2] call d_fnc_GetRanPointCircle;
						if (_istatatic && {isOnRoad _pos}) then {
							_pos = [];
						};
						if (_pos isNotEqualTo []) exitWith {};
					};
					if (_pos isEqualTo []) then {
						_pos = _pos_center;
					};
				};
			} else {
				_pos = _pos_center;
			};
			__TRACE_1("","_pos")
			private _vdir = -1.111;
			if (_istatatic) then {
				_vdir = _pos_center getDir _pos;
			};
			private _reta = [_this # 7, _pos, [_typenr, d_enemy_side_short] call d_fnc_getunitlistv, _newgroup, _vdir, true, true, true] call d_fnc_makevgroup;
			_newgroup deleteGroupWhenEmpty true;
			__TRACE_1("","_reta")
			d_x_sm_vec_rem_ar append (_reta # 0);
			if (random 100 < 80) then {{_x allowCrewInImmobile true} forEach (_reta # 0)};
			d_x_sm_rem_ar append (_reta # 1);
			
			_newgroup allowFleeing 0;
			if (!_do_patrol) then {
				_newgroup setCombatMode "YELLOW";
				_newgroup setFormation selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"];
				if (!_istatatic) then {
					_newgroup setFormDir (floor random 360);
				} else {
					{
						[_x] call d_fnc_checkintersects;
					} forEach (_reta # 0);
				};
				_newgroup setSpeedMode "NORMAL";
			} else {
				_newgroup setVariable ["d_is_v_gr", true];
				[_newgroup, _pos, [_pos_center, _radius], [5, 15, 30]] spawn d_fnc_MakePatrolWPX;
			};
			_ret_grps pushBack _newgroup;
			if (_istatatic && {d_b_small_static_high isNotEqualTo ""}) then {
				d_x_sm_rem_ar append ((_reta # 0) call d_fnc_highbunker);
			};
			[_newgroup, 15] spawn {
				scriptName "spawn createarmor";
				sleep (_this # 1);
				(_this # 0) call d_fnc_addgrp2hc;
				if (d_with_dynsim == 0) then {
					(_this # 0) enableDynamicSimulation true;
				};
			};
		};
	};
};
__TRACE_1("","_ret_grps")
_ret_grps