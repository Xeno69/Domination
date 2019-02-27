// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_docreatenexttarget.sqf"
#include "..\..\x_setup.sqf"

__TRACE("docreatenexttarget start")

if (isServer && {!isNil "d_HC_CLIENT_OBJ_OWNER"}) exitWith {
	__TRACE("found HC moving")
	remoteExec ["d_fnc_docreatenexttarget", d_HC_CLIENT_OBJ_OWNER];
};

d_delvecsmt = [];
d_delinfsm = [];
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
	
	if (surfaceIsWater _tmppos) then {
		_tmppos = d_cur_tgt_pos;
	};
	
	d_enemyai_respawn_pos set [0, _tmppos];
	_dirn = d_cur_tgt_pos getDir _tmppos;
	_dirn = _dirn + 180;
	d_enemyai_respawn_pos set [2, _dirn];
};

d_enemyai_mt_camp_pos = [d_enemyai_respawn_pos # 0, 600, 400, d_enemyai_respawn_pos # 1] call d_fnc_GetRanPointSquare;
if (d_enemyai_mt_camp_pos isEqualTo []) then {
	private _al = 800;
	private _bl = 600;
	while {true} do {
		d_enemyai_mt_camp_pos = [d_enemyai_respawn_pos # 0, _al, _bl, d_enemyai_respawn_pos # 1] call d_fnc_GetRanPointSquare;
		if !(d_enemyai_mt_camp_pos isEqualTo []) exitWith {};
		_al = _al + 200;
		_bl = _bl + 200;
		sleep 0.2;
	};
};
#endif
#ifdef __GROUPDEBUG__
if (!d_tt_ver) then {
	if (markerType "enemyai_mt_camp_pos" != "") then {deleteMarkerLocal "enemyai_mt_camp_pos"};
	["enemyai_mt_camp_pos", d_enemyai_mt_camp_pos, "ICON", "ColorBlack", [1,1], "enemy camp pos", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
};
#endif

[d_cur_tgt_pos, d_cur_target_radius] spawn d_fnc_createmaintarget;