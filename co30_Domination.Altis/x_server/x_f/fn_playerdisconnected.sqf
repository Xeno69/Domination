// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerdisconnected.sqf"
#include "..\..\x_setup.sqf"
if (!isServer || {!d_database_found}) exitWith{};

__TRACE_1("","_this")

params ["", "_uid", "_name"];

__TRACE_2("","_uid","_name")

if (_name == "__SERVER__") exitWith {};

__TRACE_1("","allPlayers")

private _unit = objNull;
(allPlayers - entities "HeadlessClient_F") findIf {
	private _ret = getPlayerUID _x == _uid;
	if (_ret) then {
		_unit = _x;
	};
	_ret
};
__TRACE_1("1","_unit")

private _pa = d_player_store getVariable _uid;
private _ps = if (!isNull _unit) then {getPlayerScores _unit} else {_pa # 12};
__TRACE_1("","_ps")
if (_ps isEqualTo []) exitWith {};
//  [infantry kills, soft vehicle kills, armor kills, air kills, deaths, total score]
private _usc = _uid + "_scores";
private _t_ps = d_player_store getVariable [_usc, [0, 0, 0, 0, 0, 0]];
__TRACE_1("","_t_ps")
if (_ps isEqualTo []) then {
	_ps = [0, 0, 0, 0, 0, 0];
};
// only add diff to db
private _infkills = (_ps # 0) - (_t_ps # 0);
private _softveckills = (_ps # 1) - (_t_ps # 1);
private _armorkills = (_ps # 2) - (_t_ps # 2);
private _airkills = (_ps # 3) - (_t_ps # 3);
private _deaths = (_ps # 4) - (_t_ps # 4);
private _totalscore = (_ps # 5) - (_t_ps # 5);
d_player_store setVariable [_usc, _ps];

__TRACE_3("","_infkills","_softveckills","_armorkills")
__TRACE_3("","_airkills","_deaths","_totalscore")

private _playtime = if (!isNil "_pa") then {[0, round (time - (_pa # 1))] select (!isNil "_pa")} else {0};

__TRACE_1("","_playtime")

"extdb3" callExtension format ["1:dom:updatePlayer:%1:%2:%3:%4:%5:%6:%7:%8", _infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _uid];

__TRACE("extDB3 called")