// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_unit", "", "_uid", "_name"];

#ifdef __DEBUG__
diag_log ["DOM handledisconnect _this:", _this];
#endif

__TRACE_1("","_this")

if (isNil "_unit" || {isNull _unit}) exitWith {
#ifdef __DEBUG__
	diag_log "DOM handledisconnect, _unit is either nil or null!";
#endif
	false
};

private _plid = getPlayerID _unit;

if (_plid getUserInfo 1 == 2) exitWith {
#ifdef __DEBUG__
	diag_log "DOM handledisconnect, _unit is server!";
#endif
	if (d_db_type == 2) then {
		saveMissionProfileNamespace;
	};
	false
};

if (_unit isKindOf "VirtualSpectator_F" || {(_uid isEqualTo "") || {_plid getUserInfo 7}}) exitWith {
#ifdef __DEBUG__
	diag_log "DOM handledisconnect, _unit is either kind of VirtualSpectator or _uid is empty or is HC!";
#endif
	false
};

#ifndef __TT__
private _abl = _unit getVariable "d_blocks_arty";
__TRACE_1("","_abl")
if (!isNil "_abl") then {
	missionNamespace setVariable ["d_ari_blocked", nil, true];
};
#else
private _abl = _unit getVariable "d_blocks_arty_w";
if (!isNil "_abl") then {
	missionNamespace setVariable ["d_ari_blocked_w", nil, true];
};
private _abl = _unit getVariable "d_blocks_arty_e";
if (!isNil "_abl") then {
	missionNamespace setVariable ["d_ari_blocked_e", nil, true];
};
#endif

private _gru = group _unit;
__TRACE_1("","_gru")
if (!isNil "_gru" && {!isNull _gru}) then {
	_gru spawn d_fnc_hdsellead;
};

private _pa = d_player_hash getOrDefault [_uid, []];
if (_pa isNotEqualTo []) then {
#ifdef __DEBUG__
	diag_log ["DOM handledisconnect player hash:", _pa];
#endif
	_pa set [0, [time - (_pa # 0), -1] select (time - (_pa # 0) < 0)];
	if ((_pa # 9) # 0 == 0) then {
		_pa set [9, [time, (_pa # 9) # 1]];
	};
#ifdef __TT__
	if ((_pa # 9) # 1 == 0) then {
		_pa set [9, [(_pa # 9) # 0, time]];
	};
	__TRACE_1("TT","_pa")
	deleteMarker format ["xr_opf_dead_%1", _pa # 18];
	deleteMarker format ["xr_blu_dead_%1", _pa # 18];
#else
	deleteMarker format ["xr_dead_%1", _pa # 18];
#endif
	private _amark = _pa # 10;
	__TRACE_1("","_amark")
	if (_amark != "") then {
		deleteMarker _amark;
		_pa set [10, ""];
	};
	__TRACE("Calling markercheck")
	[_uid, _pa # 18] spawn d_fnc_markercheck;
	
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
} else {
#ifdef __DEBUG__
	diag_log "DOM handledisconnect no player hash found!!!";
#endif
};

remoteExecCall ["", _unit];

private _ar = _unit getVariable ["d_all_p_vecs_s", []];
#ifdef __DEBUG__
diag_log ["DOM handledisconnect d_all_p_vecs_s:", _ar];
#endif
if (_ar isNotEqualTo []) then {
	{
		_x setVariable ["d_end_time", time + 600];
		d_player_created pushBack _vec;
	} forEach _ar;
};

removeAllOwnedMines _unit;

_unit spawn d_fnc_hddelu;

#ifdef __DEBUG__
diag_log "DOM handledisconnect exiting";
#endif

false