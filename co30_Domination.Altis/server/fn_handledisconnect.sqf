// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledisconnect.sqf"
#include "..\x_setup.sqf"
if (!isServer) exitWith{};
params ["_unit", "", "_uid", "_name"];

__TRACE_1("","_this")

if (isNil "_unit" || {_name == "__SERVER__" || {_name select [0, 9] == "HC_D_UNIT" || {_name select [0, 14] == "headlessclient"}}}) exitWith {false};

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
	_gru spawn {
		scriptName "spawn handledisconnect";
		sleep 2;
		if (!isNil "_this" && {!isNull _this}) then {
			remoteExecCall ["xr_fnc_changeleader", _this];
		};
	};
};

private _pa = d_player_store getVariable _uid;
if (!isNil "_pa") then {
	__TRACE_1("player store before change","_pa")
	_pa set [0, [time - (_pa # 0), -1] select (time - (_pa # 0) < 0)];
	_pa set [9, time];
	private _mname = (_pa # 4) + "_xr_dead";
	__TRACE_1("","_mname")
	if !(markerPos _mname isEqualTo [0,0,0]) then {
		deleteMarker _mname;
	};
	private _amark = _pa # 10;
	__TRACE_1("","_amark")
	if (_amark != "") then {
		if !(markerPos _amark isEqualTo [0,0,0]) then {
			deleteMarker _amark;
		};
		_pa set [10, ""];
	};
	(_pa # 4) call d_fnc_markercheck;
	__TRACE_1("player store after change","_pa")
};

private _jipid = _unit getVariable "xr_dml_jip_id";
__TRACE_1("","_jipid")
if (!isNil "_jipid") then {
	remoteExecCall ["", _jipid];
};

_jipid = _unit getVariable "d_artmark_jip_id";
__TRACE_1("","_jipid")
if (!isNil "_jipid") then {
	remoteExecCall ["", _jipid];
};

private _ar = _unit getVariable ["d_all_p_vecs_s", []];
if !(_ar isEqualTo []) then {
	{
		_x setVariable ["d_end_time", time + 600];
		d_player_created pushBack _vec;
	} forEach _ar;
};

removeAllOwnedMines _unit;

_unit spawn {
	scriptName "spawn handledisconnect2";
	params ["_unit"];
	sleep 10;
	if (isNull objectParent _unit) then {
		deleteVehicle _unit;
	} else {
		(vehicle _unit) deleteVehicleCrew _unit;
	};
};

false