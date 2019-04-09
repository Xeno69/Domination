// by Xeno

params ["_cname", ["_params", []]];

private "_query";

if (_params isEqualTo []) then {
	_query = dbPrepareQueryConfig _cname;
} else {
	_query = dbPrepareQueryConfig [_cname, _params];
};
private _res = D_DB_CON dbExecuteAsync _query;

