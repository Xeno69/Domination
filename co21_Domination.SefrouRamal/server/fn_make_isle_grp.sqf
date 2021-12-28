// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Starting _make_isle_grp")
private _dc = 0;
private _start_point = d_with_isledefense call d_fnc_GetRanPointSquare;

private _allplayers = allPlayers - entities "HeadlessClient_F";
private _player_near = false;

#ifndef __TT__
while {(count _start_point < 3 || {_start_point distance2D d_FLAG_BASE < 2000 || {_start_point distance2D d_old_old_start < 500 || {_player_near}}}) && {_dc < 99}} do {
#else
while {(count _start_point < 3 || {_start_point distance2D d_WFLAG_BASE < 2000 || {_start_point distance2D d_EFLAG_BASE < 2000 || {_start_point distance2D d_old_old_start < 500 || {_player_near}}}}) && {_dc < 99}} do {
#endif
	_start_point = d_with_isledefense call d_fnc_GetRanPointSquare;
	sleep 0.1;
	_player_near = _allplayers findIf {_x distance2D _start_point < 2000} > 0;
	sleep 0.353;
	_dc = _dc + 1;
};
_start_point = _start_point call d_fnc_WorldBoundsCheck;
__TRACE_1("","_start_point")
sleep 0.01;
d_old_old_start = _start_point;
private _units = [];
private _vecs = [];
private _agrp = [d_side_enemy] call d_fnc_creategroup;
private _npos = _start_point;
private _var = [];
_var resize (selectRandom [2, 3]);
_var = _var apply {[selectRandom ["jeep_mg", "wheeled_apc", "jeep_gl"], d_enemy_side_short] call d_fnc_getunitlistv};
private _firstdone = false;
{
	if (!_firstdone || {selectRandom [0, 1] > 0}) then {
		private _reta = [1, _npos, _x, _agrp, -1.111, false, false, false, true] call d_fnc_makevgroup;
		__TRACE_1("","_reta")
		_vecs append (_reta # 0);
		_units append (_reta # 1);
		sleep 0.73;
		_npos = ((_reta # 0) # 0) modelToWorld [0, -12, 0];
		if (!_firstdone) then {_firstdone = true};
	};
} forEach _var;
// TODO if tanks show better driving behaviour change it back to mixed list?
//} forEach ([d_enemy_side_short] call d_fnc_getmixedlist);
sleep 0.31;

_agrp setVariable ["d_PATR", true];
_agrp setVariable ["d_PATR_ISLE", true];
_agrp setVariable ["d_is_v_gr", true];
[_agrp, _start_point, [d_with_isledefense # 0, d_with_isledefense # 1, d_with_isledefense # 2, d_with_isledefense # 3]] spawn d_fnc_MakePatrolWPX;
#ifndef __TT__
if (d_searchintel # 5 == 1) then {
	_agrp spawn d_fnc_IsleDefMarkerMove;
};
#endif
{
	_x allowCrewInImmobile true;
	_x setVariable ["d_cur_pos", getPosASL _x];
} forEach _vecs;
_agrp call d_fnc_addgrp2hc;
[_agrp, _units, _vecs]