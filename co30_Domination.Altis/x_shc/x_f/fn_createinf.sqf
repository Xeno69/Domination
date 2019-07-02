// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createinf.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

private _pos_center = _this select 4;
if (isNil "_pos_center") exitWith {
	diag_log "_pos_center in fn_createinf undefined!!!";
	if (!isNil "_fnc_scriptNameParent") then {
		diag_log ["fn_createinf.sqf _fnc_scriptNameParent: ", _fnc_scriptNameParent];
	};
	diag_log ["fn_createinf.sqf _this: ", _this];
};
private _radius = _this select 5;
private _do_patrol = if (_radius < 50) then {false} else {if (count _this == 7) then {_this select 6} else {false}};
private _ret_grps = [];

for "_nr" from 0 to 1 do {
	private _nrg = _this select (1 + (_nr * 2));
	__TRACE_1("","_nrg")
	if (_nrg > 0) then {
		if (d_MissionType == 2) then {_nrg = _nrg + 2};
		if (d_WithLessArmor_side == 1) then {_nrg = _nrg + 2};
		private _typenr = _this select (_nr * 2);
		for "_i" from 1 to _nrg do {
			private _newgroup = [d_side_enemy] call d_fnc_creategroup;
			private "_pos";
			if (_radius > 0) then {
				_pos = [_pos_center, _radius, 0, 0, 0.7, 2] call d_fnc_GetRanPointCircle;
				if (_pos isEqualTo []) then {
					for "_ee" from 0 to 99 do {
						_pos = [_pos_center, _radius, 0, 0, 0.7, 2] call d_fnc_GetRanPointCircle;
						if !(_pos isEqualTo []) exitWith {};
					};
					if (_pos isEqualTo []) then {
						_pos = _pos_center;
					};
				};				
			} else {
				_pos = _pos_center;
			};
			__TRACE("from createinf")
			private _units = [_pos, [_typenr, d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] call d_fnc_makemgroup;
			_newgroup deleteGroupWhenEmpty true;
			_newgroup allowFleeing 0;
			if (!_do_patrol) then {
				_newgroup setCombatMode "YELLOW";
				_newgroup setFormation selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"];
				_newgroup setFormDir (floor random 360);
				_newgroup setSpeedMode "NORMAL";
				_newgroup setVariable ["d_defend", true];
				[_newgroup, _pos_center] spawn d_fnc_taskDefend;
			} else {
				[_newgroup, _pos, [_pos_center, _radius], [5, 15, 30], "", 0] spawn d_fnc_MakePatrolWPX;
			};
			if (d_with_dynsim == 0) then {
				_newgroup spawn {
					scriptName "spawn createinf";
					sleep 15;
					_this enableDynamicSimulation true;
				};
			};
			_ret_grps pushBack _newgroup;
			d_x_sm_rem_ar append _units;
			_newgroup call d_fnc_addgrp2hc;
		};
	};
};
__TRACE_1("","_ret_grps")
_ret_grps