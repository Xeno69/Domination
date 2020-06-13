// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_docreatenexttarget.sqf"
#include "..\x_setup.sqf"

__TRACE("docreatenexttarget start")

d_mtmissionobj = objNull;
d_mt_done = false;
if (isNil "d_sum_camps") then {d_sum_camps = -91};

#ifndef __TT__
d_enemyai_respawn_pos = [d_FLAG_BASE, d_cur_tgt_pos] call d_fnc_posbehind2; // startpoint for random camp location (if needed) plus direction
if (surfaceIsWater (d_enemyai_respawn_pos # 0)) then {
	__TRACE("Position is in water")
	__TRACE_1("","d_enemyai_respawn_pos")
	d_enemyai_respawn_pos params ["_tmppos", "_dirn", "_dist"];
	if (_dirn < 0) then {_dirn = _dirn + 180};
	private _incdir = [15, -15] select (_dirn <= 90 || {_dirn >= 270});
	__TRACE_3("","_dist","_dirn","_incdir")
	private _foundpos = false;
	private _counter = 0;
	while {_counter < 2} do {
		for "_i" from 1 to 8 do {
			private _ndir = _dirn + (_incdir * _i);
			private _cpos = d_cur_tgt_pos getPos [_dist, _ndir];
			if (!surfaceIsWater _cpos) exitWith {
				_cpos set [2, 0];
				_tmppos = _cpos;
				_foundpos = true;
			};
		};
		if (_foundpos) exitWith {
			__TRACE_1("","_tmppos")
		};
		_counter = _counter + 1;
		_incdir = _incdir * -1;
	};

	if ((_tmppos isEqualTo []) || {surfaceIsWater _tmppos}) then {
		_tmppos = d_cur_tgt_pos;
	};

	d_enemyai_respawn_pos set [0, _tmppos];
	d_enemyai_respawn_pos set [2, (d_cur_tgt_pos getDir _tmppos) + 180];
};
#else
private _rpos = [d_cur_tgt_pos, d_mttarget_radius_patrol + 500, d_mttarget_radius_patrol + 1200, 2, 0, 0.7] call d_fnc_findSafePos;
if (_rpos isEqualTo [] || {surfaceIsWater _rpos}) then {
	private _counter = 0;
	while {_counter < 50} do {
		_rpos = [d_cur_tgt_pos, d_mttarget_radius_patrol + 500, d_mttarget_radius_patrol + 1200, 2, 0, 0.7] call d_fnc_findSafePos;
		if (!(_rpos isEqualTo []) && {!surfaceIsWater _rpos}) exitWith {};
	};
	if (_rpos isEqualTo [] || {surfaceIsWater _rpos}) then {
		_rpos =+ d_cur_tgt_pos;
	};
};
d_enemyai_respawn_pos = [_rpos, d_cur_tgt_pos getDir _rpos];
#endif

[d_cur_tgt_pos, d_cur_target_radius] spawn d_fnc_createmaintarget;