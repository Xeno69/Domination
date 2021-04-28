// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

sleep 33;

while {!d_mt_radio_down} do {
	sleep 10;
	if (d_mt_radio_down) exitWith {};
	if (d_create_new_paras) then {
		private _start_pos = call d_fnc_GetRanPointOuterAir;
		private _end_pos = [0,0,0];
#ifndef __TT__
		while {_start_pos distance2D D_FLAG_BASE < 1000} do {
			_start_pos = call d_fnc_GetRanPointOuterAir;
		};
		_end_pos = call d_fnc_GetRanPointOuterAir;
		sleep 0.1;
		while {_end_pos distance2D D_FLAG_BASE < 1000} do {
			_end_pos = call d_fnc_GetRanPointOuterAir;
		};
#else
		while {_start_pos distance2D D_WFLAG_BASE < 1000 && {_start_pos distance2D D_EFLAG_BASE < 1000}} do {
			_start_pos = call d_fnc_GetRanPointOuterAir;
		};
		_end_pos = call d_fnc_GetRanPointOuterAir;
		sleep 0.1;
		while {_end_pos distance2D D_WFLAG_BASE < 1000 && {_end_pos distance2D D_EFLAG_BASE < 1000}} do {
			_end_pos = call d_fnc_GetRanPointOuterAir;
		};
#endif
		sleep 0.1;
		private _num_p = call d_fnc_PlayersNumber;
		private _vecs = [(ceil (_num_p * 0.1)) min 3, 1] select (_num_p == 0);
		d_create_new_paras = false;

		private _attack_pos = [d_cur_tgt_pos, 200] call d_fnc_GetRanPointCircleOld;
		private _flytopos = _start_pos getPos [(_start_pos distance2D _attack_pos) + 1500, _start_pos getDir _attack_pos];
		[_start_pos, _attack_pos, _flytopos, _end_pos, _vecs] spawn d_fnc_createpara3x;
	};
};