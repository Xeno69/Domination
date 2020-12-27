// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dbtoppasync.sqf"
#include "..\x_setup.sqf"

while {true} do {
	sleep 600;
	private ["_uid", "_pa", "_ps", "_usc", "_t_ps", "_infkills", "_softveckills", "_armorkills", "_airkills", "_deaths", "_totalscore", "_playtime"];
	{
		if (!isNull _x) then {
			_uid = getPlayerUID _x;
			if (_uid isNotEqualTo []) then {
				_pa = d_player_hash getOrDefault [_uid, []];
				if (_pa isNotEqualTo []) then {
					_ps = getPlayerScores _x;
					//diag_log ["DOM dbtoppasync: player", _x, "getPlayerScores", _ps];
					if !(_ps isEqualTo [] && {_ps isNotEqualTo [0, 0, 0, 0, 0, 0]}) then {
						_usc = _uid + "_scores";
						_t_ps = d_player_hash getOrDefault [_usc, [0, 0, 0, 0, 0, 0]];
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

						__TRACE_1("","_playtime")

						//diag_log ["DOM dbtoppasync: _totalscore", _totalscore];
						if (_totalscore <= 0) exitWith {
							//diag_log ["DOM dbtoppasync _totalscore <= 0"];
						};

#ifndef __INTERCEPTDB__
						"extdb3" callExtension format ["1:dom:updatePlayer:%1:%2:%3:%4:%5:%6:%7:%8:%9", _infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _pa # 14, _uid];
#else
						if (d_interceptdb) then {
							["updatePlayer", [_infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _pa # 14, _uid]] call dsi_fnc_queryconfigasync;
						};
#endif
						_pa set [14, 0];

						__TRACE("extDB3 called")
					};
				};
			};
		};
		sleep 0.3;
	} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});
	sleep 10;
#ifndef __INTERCEPTDB__
	_dbresult = parseSimpleArray ("extdb3" callExtension "2:dom:getTop10Players");
	__TRACE_1("","_dbresult")
	if (_dbresult # 0 == 2) then {
		sleep 3;
		_dbresult = parseSimpleArray ("extdb3" callExtension format ["4:%1", _dbresult # 1]);
		while {_dbresult # 0 == 3} do {sleep 3};
		sleep 0.1;
		if (_dbresult # 0 == 1) then {
			{
				_x set [1, (_x # 1) call d_fnc_convtime];
			} forEach (_dbresult # 1);
			missionNamespace setVariable ["d_top10_db_players", _dbresult # 1, true];
		};
	};
#else
	if (d_interceptdb) then {
		call dsi_fnc_gettopplayers;
	};
#endif
};