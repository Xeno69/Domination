// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerServer.sqf"
#include "x_setup.sqf"
#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerServer.sqf"];
#endif
__TRACE_1("","_this")

params ["_pl"];

if ((str _pl) select [0, 9] == "HC_D_UNIT") exitWith {
	d_HC_CLIENT_OBJ_OWNER = owner _pl;
	__TRACE_1("","d_HC_CLIENT_OBJ_OWNER")
};

private _name = (name _pl) splitString """'" joinString "";
_pl setVariable ["d_plname", _name, true];

private _uid = getPlayerUID _pl;

private _p = d_player_store getVariable _uid;
private _f_c = false;
__TRACE_1("","side (group _pl)")
private _sidepl = side (group _pl);
if (isNil "_p") then {
	_p = [time + d_AutoKickTime, time, "", 0, str _pl, _sidepl, _name, 0, [-2, xr_max_lives] select (xr_max_lives != -1), 0, "", [], []];
	d_player_store setVariable [_uid, _p];
	_f_c = true;
	__TRACE_3("Player not found","_uid","_name","_p")
} else {
	__TRACE_1("player store before change","_p")
	if (_name != _p # 6) then {
		[format [localize "STR_DOM_MISSIONSTRING_506", _name, _p # 6], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
		diag_log format [localize "STR_DOM_MISSIONSTRING_942", _name, _p # 6, _uid];
	};
	if (time - (_p # 9) > 600) then {
		_p set [8, xr_max_lives];
	};
	if (_p # 0 > -1) then {
		_p set [0, time + (_p # 0)];
	};
	_p set [1, time];
	_p set [4, str _pl];
	_p set [6, _name];
	if (_sidepl != _p # 5) then {
		_p set [5, _sidepl];
		_f_c = true;
		d_player_store setVariable [_uid + "_scores", nil];
		_p set [11, []];
		_p set [12, []];
	};
	__TRACE_1("player store after change","_p")
};

_p remoteExecCall ["d_fnc_player_stuff", owner _pl];

if (d_database_found) then {
	private _dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:playerGetTS:%1", _uid]);
	__TRACE_1("","_dbresult")
	if (_dbresult # 0 == 1) then {
		if (_dbresult # 1 isEqualTo []) then {
			// create new database entry for UID
			__TRACE("creating new db entry");
			"extdb3" callExtension format ["1:dom:playerInsert:%1:%2", _uid, _name];
		} else {
			__TRACE("adding nums played for player in db");
			"extdb3" callExtension format ["1:dom:numplayedAdd:%1:%2", _name, _uid];
			__TRACE_1("","_f_c")
#ifdef __DEBUG__
			_uidscores = isNil {d_player_store getVariable (_uid + "_scores")};
			__TRACE_1("","_uidscores")
#endif
			if (d_set_pl_score_db && {_f_c && {isNil {d_player_store getVariable (_uid + "_scores")}}}) then {
				__TRACE("Adding score");
				__TRACE_1("","((_dbresult select 1) select 0) select 0")
				__TRACE_1("","score _pl")
				d_player_store setVariable [_uid + "_scores", [((_dbresult # 1) # 0) # 1, ((_dbresult # 1) # 0) # 2, ((_dbresult # 1) # 0) # 3, ((_dbresult # 1) # 0) # 4, ((_dbresult # 1) # 0) # 5, ((_dbresult # 1) # 0) # 0]];
				[_pl, (_dbresult # 1) # 0] spawn {
					params ["_pl", "_ar"];
					sleep 10;
					private _plsar = getPlayerScores _pl;
					__TRACE_1("","_plsar")
					_pl addPlayerScores [(_ar # 1) - (_plsar # 0), _ar # 2 - (_plsar # 1), _ar # 3 - (_plsar # 2), _ar # 4 - (_plsar # 3), _ar # 5 - (_plsar # 4)];
					__TRACE_1("","getPlayerScores _pl")
					__TRACE_1("","score _pl")
					sleep 1;
					__TRACE_1("1","getPlayerScores _pl")
					__TRACE_1("1","score _pl")
					__TRACE_2("Adding score","_pl","_ar")
					if (_ar # 0 != score _pl) then {
						if (score _pl > 0) then {
							_pl addScore -(score _pl);
						};
						_pl addScore ((_ar # 0) - score _pl);
					};
					__TRACE_1("2","getPlayerScores _pl")
					__TRACE_1("2","score _pl")
				};
			};
			_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:playerGet:%1", _uid]);
			__TRACE_1("","_dbresult")
			if (_dbresult # 0 == 1) then {
				(_dbresult # 1) params ["_pres"];
				if !(_pres isEqualTo []) then {
					_pres set [1, (_pres # 1) call d_fnc_convtime];
					[missionNamespace, ["d_pl_db_mstart", _pres]] remoteExecCall ["setVariable", _pl];
				};
			};
		};
	};
};

_pl spawn {
	sleep 1;
	[_this] call d_fnc_addceo;
};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerServer.sqf processed"];
#endif

_pl addEventhandler ["HandleScore", {_this call d_fnc_handlescore}];
