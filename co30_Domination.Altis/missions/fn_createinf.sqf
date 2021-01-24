// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createinf.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

// parameters:
// 0. first type of infantry ie-- "specops"
// 1. _nrg number of groups for first type (+2 added if parameters set to "no enemy armor") 
// 2. _typenr second type of infantry ie-- "allmen" 
// 3. _nrg number of groups for second type (+2 added if parameters set to "no enemy armor")
// 4. _pos_center
// 5. _radius
// 6. _do_patrol
// 7. _isArmorAdjustmentDisabled (optional, default: false) if true do not modify the specified number of groups regardless of "no enemy armor" setting
// 8. _unitsPerGroup (optional) if defined then this number sets the number of units created per group (will not be randomized)

private _pos_center = _this select 4;
if (isNil "_pos_center") exitWith {
	diag_log "_pos_center in fn_createinf undefined!!!";
	if (!isNil "_fnc_scriptNameParent") then {
		diag_log ["fn_createinf.sqf _fnc_scriptNameParent: ", _fnc_scriptNameParent];
	};
	diag_log ["fn_createinf.sqf _this: ", _this];
};
private _radius = _this select 5;
private _do_patrol = if (_radius < 50) then {false} else {if (count _this > 6) then {_this select 6} else {false}};
private _ret_grps = [];
private _isArmorAdjustmentDisabled = if (count _this > 7) then {_this select 7} else {false};
private _unitsPerGroup = if (count _this > 8) then {_this select 8} else {-1};

_with_less_armor_side = if (d_WithLessArmor_side == -1) then {
	selectRandom [0, 1, 2];
} else {
	d_WithLessArmor_side;
};

for "_nr" from 0 to 1 do {
	private _nrg = _this select (1 + (_nr * 2));
	__TRACE_1("","_nrg")
	if (_nrg > 0) then {
		if (d_MissionType == 2 && {!_isArmorAdjustmentDisabled}) then {_nrg = _nrg + 2};
		if (_with_less_armor_side == 2 && {!_isArmorAdjustmentDisabled}) then {_nrg = _nrg + 2};
		private _typenr = _this select (_nr * 2);
		for "_i" from 1 to _nrg do {
			private _newgroup = [d_side_enemy] call d_fnc_creategroup;
			private "_pos";
			if (_radius > 0) then {
				_pos = [_pos_center, _radius] call d_fnc_GetRanPointCircle;
				if (_pos isEqualTo []) then {
					for "_ee" from 0 to 99 do {
						_pos = [_pos_center, _radius] call d_fnc_GetRanPointCircle;
						if (_pos isNotEqualTo []) exitWith {};
					};
					if (_pos isEqualTo []) then {
						_pos = _pos_center;
					};
				};				
			} else {
				_pos = _pos_center;
			};
			__TRACE("from createinf")
			private _units = [_pos, [_typenr, d_enemy_side_short] call d_fnc_getunitlistm, _newgroup, true, true, _unitsPerGroup] call d_fnc_makemgroup;
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
			_ret_grps pushBack _newgroup;
			d_x_sm_rem_ar append _units;
			[_newgroup, 30] spawn {
				scriptName "spawn createinf";
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