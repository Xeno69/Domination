// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledisconnect.sqf"
#include "..\x_setup.sqf"

params ["_unit", "", "_uid", "_name"];

__TRACE_1("","_this")

if (isNil "_unit" || {_unit isKindOf "VirtualSpectator_F" || {(_uid isEqualTo "") || {_name == "__SERVER__" || {_name select [0, 9] == "HC_D_UNIT" || {_name select [0, 14] == "headlessclient"}}}}}) exitWith {false};

#ifndef __TT__
private _abl = _unit getVariable "d_blocks_arty";
__TRACE_1("","_abl")
if (!isNil "_abl") then {
	missionNamespace setVariable ["d_ari_blocked", false, true];
};
#else
private _abl = _unit getVariable "d_blocks_arty_w";
if (!isNil "_abl") then {
	missionNamespace setVariable ["d_ari_blocked_w", false, true];
};
private _abl = _unit getVariable "d_blocks_arty_e";
if (!isNil "_abl") then {
	missionNamespace setVariable ["d_ari_blocked_e", false, true];
};
#endif

private _gru = group _unit;
__TRACE_1("","_gru")
if (!isNil "_gru" && {!isNull _gru}) then {
	_gru spawn d_fnc_hdsellead;
};

private _pa = d_player_hash getOrDefault [_uid, []];
if (_pa isNotEqualTo []) then {
	__TRACE_1("player store before change","_pa")
	_pa set [0, [time - (_pa # 0), -1] select (time - (_pa # 0) < 0)];
	if ((_pa # 9) # 0 == 0) then {
		_pa set [9, [time, (_pa # 9) # 1]];
	};
#ifdef __TT__
	if ((_pa # 9) # 1 == 0) then {
		_pa set [9, [(_pa # 9) # 0, time]];
	};
#endif
	deleteMarker format ["xr_dead_%1", getPlayerID _unit];
	private _amark = _pa # 10;
	__TRACE_1("","_amark")
	if (_amark != "") then {
		deleteMarker _amark;
		_pa set [10, ""];
	};
	__TRACE("Calling markercheck")
	[_uid, getPlayerID _unit] spawn d_fnc_markercheck;
	
	private _jar = _unit getVariable "d_jailar";
	__TRACE_1("","_jar")
	if (!isNil "_jar") then {
		private _dif = serverTime - (_jar # 0);
		if (_dif >= (_jar # 1)) then {
			_pa set [13, 0];
		} else {
			_pa set [13, (_jar # 1) - (round _dif)];
		};
		
	} else {
		_pa set [13, 0];
	};
	__TRACE_1("player store after change","_pa")
};

remoteExecCall ["", _unit];

private _ar = _unit getVariable ["d_all_p_vecs_s", []];
__TRACE_1("","_ar")
if (_ar isNotEqualTo []) then {
	{
		_x setVariable ["d_end_time", time + 600];
		d_player_created pushBack _vec;
	} forEach _ar;
};

removeAllOwnedMines _unit;

_unit spawn d_fnc_hddelu;

false