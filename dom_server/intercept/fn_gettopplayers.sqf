// by Xeno

private _query = dbPrepareQueryConfig "getTop10Players";
private _res = D_DB_CON dbExecuteAsync _query;
_res dbBindCallback [{
	params ["_result"];
	
	private _dbresult = dbResultToParsedArray _result;
	if !(_dbresult isEqualTo []) then {
		{
			_x set [1, (_x # 1) call d_fnc_convtime];
		} forEach _dbresult;
		missionNamespace setVariable ["d_top10_db_players", _dbresult, true];
	};
}];