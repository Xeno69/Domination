// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerServer.sqf"
#include "x_setup.sqf"
#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerServer.sqf"];
#endif
__TRACE_1("","_this")

params ["_pl"];

if (str _pl == "HC_D_UNIT") exitWith {
	d_HC_CLIENT_OBJ_OWNER = owner HC_D_UNIT;
	__TRACE_1("","d_HC_CLIENT_OBJ_OWNER")
};

private _name = (name _pl) splitString """'" joinString "";
_pl setVariable ["d_plname", _name, true];

private _uid = getPlayerUID _pl;

private _p = d_player_store getVariable _uid;
private _f_c = false;
if (isNil "_p") then {
	_p = [d_AutoKickTime, time, "", 0, str _pl, sideUnknown, _name, 0, [-2, xr_max_lives] select (xr_max_lives != -1), 0, "", [], []];
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
	_p set [1, time];
	_p set [4, str _pl];
	_p set [6, _name];
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
			if (d_set_pl_score_db && {_f_c && {isNil {d_player_store getVariable (_uid + "_scores")}}}) then {
				__TRACE("Adding score");
				__TRACE_1("","((_dbresult select 1) select 0) select 0")
				__TRACE_1("","score _pl")
				d_player_store setVariable [_uid + "_scores", [0, 0, 0, 0, 0, ((_dbresult # 1) # 0) # 0]];
				[_pl, ((_dbresult # 1) # 0) # 0] spawn {
					params ["_pl", "_tsp"];
					sleep 5;
					_pl addScore (_tsp - score _pl);
				};
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

_pl spawn {
	sleep 1;
	[_this] call d_fnc_addceo;
};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerServer.sqf processed"];
#endif