// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_with_sleep"];

private ["_uid", "_pa", "_ps", "_usc", "_t_ps", "_infkills", "_softveckills", "_armorkills", "_airkills", "_deaths", "_totalscore", "_playtime"];
{
	if (!isNull _x) then {
		_uid = getPlayerUID _x;
		__TRACE_1("","_uid")
		if (_uid isNotEqualTo []) then {
			_pa = d_player_hash getOrDefault [_uid, []];
			__TRACE_1("","_pa")
			if (_pa isNotEqualTo []) then {
				_ps = getPlayerScores _x;
				__TRACE_1("","_ps")
				//diag_log ["DOM dbtoppasync: player", _x, "getPlayerScores", _ps];
				if (_ps isNotEqualTo [] && {_ps isNotEqualTo [0, 0, 0, 0, 0, 0]}) then {
					_usc = _uid + "_scores";
					_t_ps = d_player_hash getOrDefault [_usc, [0, 0, 0, 0, 0, 0]];
					__TRACE_1("","_t_ps")
					_infkills = (_ps # 0) - (_t_ps # 0);
					_softveckills = (_ps # 1) - (_t_ps # 1);
					_armorkills = (_ps # 2) - (_t_ps # 2);
					_airkills = (_ps # 3) - (_t_ps # 3);
					_deaths = (_ps # 4) - (_t_ps # 4);
					_totalscore = _ps # 5;
					d_player_hash set [_usc, _ps];

					__TRACE_3("","_infkills","_softveckills","_armorkills")
					__TRACE_3("","_airkills","_deaths","_totalscore")

					_playtime = round (time - (_pa # 1));
					_pa set [1, time];

					__TRACE_1("","_pa")
					__TRACE_1("","_playtime")

					if (_totalscore <= 0) exitWith {
						diag_log ["DOM dbtoppasync, totalscore <= 0, _uid:", _uid, "name:", name _x];
					};

					call {
						if (d_db_type == 0) exitWith {
							"extdb3" callExtension format ["1:dom:updatePlayer:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11", _infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _pa # 14, _pa # 15, _pa # 16, _pa # 17, _uid];
						};
						if (d_db_type == 1) exitWith {
							["updatePlayer", [_infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _pa # 14, _pa # 15, _pa # 16, _pa # 17, _uid]] call d_fnc_queryconfigasync;
						};
						if (d_db_type == 2) exitWith {
							private _tmphash = missionProfileNamespace getVariable "d_player_hashmap";
							if (!isNil "_tmphash") then {
								private _tmpar = _tmphash get _uid;
								if (!isNil "_tmpar") then {
									__TRACE_1("1","_tmpar")
									_tmpar set [2, (_tmpar # 2) + _infkills];
									_tmpar set [3, (_tmpar # 3) + _softveckills];
									_tmpar set [4, (_tmpar # 4) + _armorkills];
									_tmpar set [5, (_tmpar # 5) + _airkills];
									_tmpar set [6, (_tmpar # 6) + _deaths];
									_tmpar set [7, _totalscore];
									_tmpar set [1, _playtime];
									_tmpar set [12, _pa # 14];
									_tmpar set [14, _pa # 15];
									_tmpar set [15, _pa # 16];
									_tmpar set [16, _pa # 17];
									__TRACE_1("2","_tmpar")
								};
							};
						};
					};
					_pa set [14, 0];

					__TRACE("database called")
				} else {
					diag_log ["DOM dbtoppasync, playerscores are empty or zero, _ps:", _ps, "_uid:", _uid, "name:", name _x];
				};
			};
		};
	};
	if (_with_sleep) then {sleep 0.3};
} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x && {!(_x isKindOf "VirtualMan_F")}});
if (d_db_type == 2) then {
	__TRACE("Saving mission profile namespace")
	saveMissionProfileNamespace;
};