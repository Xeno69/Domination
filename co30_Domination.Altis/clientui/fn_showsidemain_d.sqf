// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_showsidemain_d.sqf"
#include "..\x_setup.sqf"

params ["_which"];

if (_which == 1 && {d_current_target_index == -1} || {_which == 0 && {d_all_sm_res || {d_cur_sm_idx == -1}}}) exitWith {};

private _exit_it = false;

private ["_end_pos", "_markername"];
switch (_which) do {
	case 0: {
		_markername = format ["d_XMISSIONM%1", d_cur_sm_idx + 1];
		if (markerPos _markername isEqualTo [0,0,0]) then {_exit_it = true};
		_end_pos = markerPos _markername;
	};
	case 1: {
		_end_pos = markerPos "d_dummy_marker";
		_markername = format ["d_%1_dommtm", d_cur_tgt_name];
	};
};

if (_exit_it) exitWith {};

disableSerialization;
private _ctrlmap = (uiNamespace getVariable "d_StatusDialog") displayCtrl 11010;
ctrlMapAnimClear _ctrlmap;

private _dsmd = player getVariable ["d_sidemain_m_do", []];
if !(_markername in _dsmd) then {
	_dsmd pushBack _markername;
	player setVariable ["d_sidemain_m_do", _dsmd];
	_markername spawn {
		scriptName "spawn_d_fnc_showsidemain_d_marker";
		private _m = _this; private _a = 1; private _aas = -0.06;
		while {d_showstatus_dialog_open && {d_player_canu}} do {
			_m setMarkerAlphaLocal _a;
			_a = _a + _aas;
			if (_a < 0.3) then {_a = 0.3; _aas = _aas * -1};
			if (_a > 1.3) then {_a = 1.3; _aas = _aas * -1};
			sleep .1;
		};
		_m setMarkerAlphaLocal 1;
		player setVariable ["d_sidemain_m_do",[]];
	};
};

#ifndef __TT__
private _start_pos = getPosAsl d_FLAG_BASE;
#else
private _start_pos = [getPosAsl d_EFLAG_BASE, getPosAsl d_WFLAG_BASE] select (d_player_side == blufor);
#endif
_ctrlmap ctrlMapAnimAdd [0.0, 1.00, _start_pos];
_ctrlmap ctrlMapAnimAdd [1.2, 1.00, _end_pos];
_ctrlmap ctrlMapAnimAdd [0.5, 0.30, _end_pos];
ctrlMapAnimCommit _ctrlmap;