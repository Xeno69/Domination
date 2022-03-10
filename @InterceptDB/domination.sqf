// by Xeno

d_interceptdb = isClass (configFile>>"Intercept">>"Dedmen">>"intercept_database");

d_fnc_createdbconn = compileFinal "
	D_DB_CON = dbCreateConnection 'domination';
";

d_fnc_queryconfig = compileFinal "
	params ['_cname', ['_params', []]];
	
	private '_query';

	if (_params isEqualTo []) then {
		_query = dbPrepareQueryConfig _cname;
	} else {
		_query = dbPrepareQueryConfig [_cname, _params];
	};
	private _res = D_DB_CON dbExecute _query;
	(dbResultToParsedArray _res)
";

d_fnc_queryconfigasync = compileFinal "
	params ['_cname', ['_params', []]];
	
	private '_query';

	if (_params isEqualTo []) then {
		_query = dbPrepareQueryConfig _cname;
	} else {
		_query = dbPrepareQueryConfig [_cname, _params];
	};
	private _res = D_DB_CON dbExecuteAsync _query;
";

d_fnc_gettoppplayers = compileFinal "
	private _query = dbPrepareQueryConfig 'getTop10Players';
	private _res = D_DB_CON dbExecuteAsync _query;
	_res dbBindCallback [{
		params ['_result'];
		
		private _dbresult = dbResultToParsedArray _result;
		if !(_dbresult isEqualTo []) then {
			{
				_x set [1, (_x # 1) call d_fnc_convtime];
			} forEach _dbresult;
			d_top10_db_players_serv = _dbresult;
			objNull spawn d_fnc_sendtopplayers;
		};
	}];
";

diag_log "Dom InterceptDB domination.sqf loaded and compiled";
