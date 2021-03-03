// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makegroup.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_grptype", "_wp_array", "_target_pos", "_numvecs", "_type", "_side", "_grp_in", "_vec_dir", ["_add_to_ar_type", 0], "_center_rad", ["_mchelper", true]];

__TRACE_1("","_this")
private _vecs = [];
private _uinf = [];

private _grp = [_grp_in, [_side] call d_fnc_creategroup] select (_grp_in isEqualType 0);
private _pos = selectRandom _wp_array;

__TRACE_1("","_grp")

_grptype = toLowerANSI _grptype;

private _istatatic = _grptype in ["stat_mg", "stat_gl", "arty"];
private _ismen = _grptype in ["allmen", "specops"];

private _msize = 0;
if (_numvecs > 0) then {
	if (!_istatatic) then {
		_grp setVariable ["d_is_v_gr", true];
		private _vecar = [_numvecs, _pos, [_grptype, _side] call d_fnc_getunitlistv, _grp, _vec_dir, false, false, true] call d_fnc_makevgroup;
		_vecs = _vecar # 0;
		_uinf = _vecar # 1;
	} else {
		if (isOnRoad _pos) then {
			private _cc = 0;
			while {true} do {
				private _npos = selectRandom _wp_array;
				if !(isOnRoad _npos) exitWith {
					_pos = _npos;
				};
				_cc = _cc + 1;
				if (_cc == 50) exitWith {};
			};
		};
		_vec_dir = (_center_rad # 0) getDir _pos;
		private _vecar = [_numvecs, _pos, [_grptype, _side] call d_fnc_getunitlistv, _grp, _vec_dir, true] call d_fnc_makevgroup;
		_vecs = _vecar # 0;
		_uinf = _vecar # 1;
		{
			_x enableWeaponDisassembly false;
		} forEach _vecs;
	};
	_grp setSpeedMode "LIMITED";
	_msize = 2;
} else {
	__TRACE("from makegroup")
#ifndef __TT__
	_uinf = [_pos, [_grptype, _side] call d_fnc_getunitlistm, _grp, _mchelper, true, -1, d_side_player] call d_fnc_makemgroup;
#else
	_uinf = [_pos, [_grptype, _side] call d_fnc_getunitlistm, _grp, _mchelper, true] call d_fnc_makemgroup;
#endif
	__TRACE_1("","_uinf")
};

_grp deleteGroupWhenEmpty true;

if (_add_to_ar_type > 0) then {
	if (d_mt_respawngroups == 0) then {
		if (!_istatatic && {_grptype != "uav"}) then { // don't add static weapons or UAVs !!!!, respawn doesn't make sense, they can't travel from the respawn camp to another location
			if (!_ismen) then {
				{
					[_x, 3] call d_fnc_setekmode;
					_x setVariable ["d_respawninfo", [_grptype, [], _target_pos, _numvecs, "patrol2", _side, 0, _vec_dir, _add_to_ar_type, _center_rad, false, d_enemyai_respawn_pos]];
					_x setVariable ["d_thevecs", _vecs];
					if (d_with_ace) then {
						_x spawn d_fnc_wa_ace_vec;
					};
				} forEach _vecs;
			} else {
				{
					[_x, 3] call d_fnc_setekmode;
				} forEach _uinf;
				_grp setVariable ["d_respawninfo", [_grptype, [], _target_pos, _numvecs, selectRandom ["patrol", "patrol2"], _side, 0, _vec_dir, _add_to_ar_type, _center_rad, false, []]];
			};
		};
	};
	if (_vecs isNotEqualTo []) then {
		d_delvecsmt append _vecs;
	};
	if (_uinf isNotEqualTo []) then {
		d_delinfsm append _uinf;
	};
};

_grp allowFleeing (((floor random 3) + 1) / 10);

private _sleepti = [15, 30] select _ismen;

private _wpstatements = "";
//private _wpstatements = if (d_house_patrol == 0 && {_ismen && {_type in ["patrol", "patrol2mt"]}}) then {
//	"if (random 100 < 50) then {0 = [thisList] spawn d_fnc_dohousepatrol}"
//	""
//} else {
//	""
//};

call {
	if (_type == "patrol") exitWith {
		_grp setVariable ["d_PATR", true];
		private _min = 1 + random 15;
		private _max = _min + (1 + random 15);
		private _mid = _min + (random (_max - _min));	
		[_grp, _pos, _center_rad, [_min, _mid, _max], _wpstatements, _msize] spawn d_fnc_MakePatrolWPX;
	};
	if (_type == "patrol2mt") exitWith {
		_grp setVariable ["d_PATR", true];
		private _min = 1 + random 15;
		private _max = _min + (1 + random 15);
		private _mid = _min + (random (_max - _min));
		[_grp, _pos, _center_rad, [_min, _mid, _max], _wpstatements, _msize] spawn d_fnc_MakePatrolWPX;
	};
	if (_type == "patrol2") exitWith {
		_grp setVariable ["d_PATR", true];
		private _min = 1 + random 15;
		private _max = _min + (1 + random 15);
		private _mid = _min + (random (_max - _min));
		[_grp, _pos, _center_rad, [_min, _mid, _max], "", _msize, true] spawn d_fnc_MakePatrolWPX;
	};
	if (_type == "guard") exitWith {
		if (_ismen) then {
			_grp setVariable ["d_defend", true];
			[_grp, _pos] spawn d_fnc_taskDefend;
		} else {
			_grp setCombatMode "YELLOW";
			_grp setFormation selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];
			_grp setFormDir (floor random 360);
			_grp setSpeedMode "NORMAL";
			_grp setBehaviour "SAFE";
		};
	};
	if (_type == "guardstatic") exitWith {
		if (_ismen) then {
			_grp setVariable ["d_defend", true];
			[_grp, _pos] spawn d_fnc_taskDefend;
		} else {
			_grp setCombatMode "YELLOW";
			_grp setFormation selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];
			_grp setFormDir (floor random 360);
			_grp setSpeedMode "NORMAL";
			_grp setBehaviour "SAFE";
		};
	};
	if (_type == "guardstatic2") exitWith {
		(_vecs # 0) setDir (floor random 360);
	};
	if (_type == "attack") then {
		_grp setBehaviour "AWARE";
		private _gwp = _grp addWaypoint [_target_pos, 30];
		_gwp setWaypointtype "SAD";
		_gwp setWaypointCombatMode "YELLOW";
		_gwp setWaypointSpeed "FULL";
	};
};

if (_istatatic) then {
	{
		[_x] call d_fnc_checkintersects;
	} forEach _vecs;
	if (d_b_small_static_high isNotEqualTo "") then {
		d_delvecsmt append (_vecs call d_fnc_highbunker);
	};
};

[_grp, _sleepti] spawn {
	scriptName "spawn makegroup";
	sleep (_this # 1);
	(_this # 0) call d_fnc_addgrp2hc;
	if (d_with_dynsim == 0) then {
		(_this # 0) enableDynamicSimulation true;
	};
};

[_grp, _uinf, _vecs]
