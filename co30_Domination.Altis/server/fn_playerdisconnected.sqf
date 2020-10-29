// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerdisconnected.sqf"
#include "..\x_setup.sqf"
if (!isServer) exitWith{};

diag_log ["DOM playerdisconnected: _this", _this];

params ["", "_uid", "_name"];

__TRACE_1("","_this")

if (_name == "__SERVER__") exitWith {
	diag_log ["DOM playerdisconnected, Server disconnect: _this", _this];
};

private _mname = "_USER_DEFINED #" + (_this # 5);
__TRACE_1("12","_mname")
{
	deleteMarker _x;
} forEach (allMapMarkers select {_x select [0, count _mname] == _mname});

if (_uid isEqualTo "") exitWith {};

if (_name select [0, 9] == "HC_D_UNIT" || {_name select [0, 14] == "headlessclient"}) exitWith {
	diag_log ["DOM playerdisconnected, headless client disconnect: _this", _this];
	0 spawn {
		scriptname "spawn pldisconnected";
		sleep 2;
		d_hc_array = d_hc_array - [objNull, grpNull];
		if !(d_hc_array isEqualTo []) then {
			if (!isNil "d_recreatehcs_handle") then {
				terminate d_recreatehcs_handle;
			};
			d_recreatehcs_handle = 0 spawn d_fnc_recreatehcs;
		};
	};
};

if (_uid in d_virtual_spectators) exitWith {
	d_virtual_spectators = d_virtual_spectators - [_uid];
};

if (!d_database_found) exitWith {};

private _unit = objNull;
(allPlayers - entities "HeadlessClient_F") findIf {
	if (getPlayerUID _x == _uid) then {
		_unit = _x;
		true
	} else {
		false
	};
};

__TRACE_1("","allPlayers")
__TRACE_2("","_uid","_name")
__TRACE_1("1","_unit")

if (isNil "_unit" || {!isNil {_unit getVariable "d_no_side_change"}}) exitWith {
	__TRACE_2("No database update","_unit","_name")
	diag_log ["DOM playerdisconnected: No database update", _this];
};

private _pa = d_player_store getVariable _uid;
private _ps = if (!isNull _unit) then {getPlayerScores _unit} else {_pa # 12};
private _scpl = if (!isNull _unit) then {score _unit} else {-1};
__TRACE_1("","_scpl")
__TRACE_1("","getPlayerScores _unit")
__TRACE_1("","_ps")
diag_log ["DOM playerdisconnected _pa", _pa, " _ps", _ps, " _scpl", _scpl];
if (_ps isEqualTo [] || {_ps isEqualTo [0, 0, 0, 0, 0, 0]}) exitWith {};
//  [infantry kills, soft vehicle kills, armor kills, air kills, deaths, total score]
private _usc = _uid + "_scores";
private _t_ps = d_player_store getVariable [_usc, [0, 0, 0, 0, 0, 0]];
__TRACE_1("","_t_ps")
diag_log ["DOM playerdisconnected: _t_ps", _t_ps];
// only add diff to db
private _infkills = (_ps # 0) - (_t_ps # 0);
private _softveckills = (_ps # 1) - (_t_ps # 1);
private _armorkills = (_ps # 2) - (_t_ps # 2);
private _airkills = (_ps # 3) - (_t_ps # 3);
private _deaths = (_ps # 4) - (_t_ps # 4);
private _totalscore = if (_scpl != -1) then {_scpl} else {_ps # 5};

d_player_store setVariable [_usc, _ps];

__TRACE_3("","_infkills","_softveckills","_armorkills")
__TRACE_3("","_airkills","_deaths","_totalscore")

diag_log ["DOM playerdisconnected: _totalscore", _totalscore];

if (_totalscore <= 0) exitWith {
	diag_log ["DOM playerdisconnected _totalscore <= 0"];
};

private _playtime = if (!isNil "_pa") then {[0, round (time - (_pa # 1))] select (!isNil "_pa")} else {0};

diag_log ["DOM playerdisconnected: _playtime", _playtime];

private _tks = if (!isNil "_pa") then {_pa # 14} else {0};

#ifndef __INTERCEPTDB__
"extdb3" callExtension format ["1:dom:updatePlayer:%1:%2:%3:%4:%5:%6:%7:%8:%9", _infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _tks, _uid];
__TRACE("extDB3 called")
#else
if (d_interceptdb) then {
	["updatePlayer", [_infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _tks, _uid]] call dsi_fnc_queryconfigasync;
};

__TRACE("interceptDB called")
#endif

if (!isNil "_pa") then {
	_pa set [14, 0];
};
