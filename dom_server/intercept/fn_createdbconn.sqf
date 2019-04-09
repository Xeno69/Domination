diag_log ["Dom InterceptDB Database"];

D_DB_CON = dbCreateConnection "domination";
d_database_found = true;
/*if (dbPing D_DB_CON) then {
	diag_log ["Dom InterceptDB connected!!!"];
	d_database_found = true;
} else {
	d_interceptdb = false;
};*/
// dbIsConnected D_DB_CON does not work immediately after createConnection as the connection is only really available after a query (which dbPing provides)
/*if (dbIsConnected D_DB_CON) then {
	diag_log ["InterceptDB connected!!!"];
	if (dbPing D_DB_CON) exitWith {
		diag_log ["InterceptDB Domination DB found!!!"];
	};
	d_interceptdb = false;
} else {
	d_interceptdb = false;
	diag_log ["InterceptDB NOT connected!!!"];
};*/
