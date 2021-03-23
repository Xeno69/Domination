// by Xeno
#define THIS_FILE "fn_gimmick.sqf"
#include "..\x_setup.sqf"

#ifdef __OWN_SIDE_BLUFOR__
	
private _objs = (allMissionObjects "HBarrier_base_F") select {"d_bar_x_" in (str _x)};

if (_objs isEqualTo []) exitWith {};

sleep 1;

private _cnames = ("getNumber (_x >> 'scope') >= 2 && {getText (_x >> 'vehicleClass') in ['Armored', 'Car', 'Air']}" configClasses (configFile >> "CfgVehicles")) apply {configName _x};
	
private _objsar = [];
	
while {true} do {
	private _cnamesew =+ _cnames;
	{deleteVehicle _x} forEach _objsar;
	_objsar = [];
	{
		private _curname = selectRandom _cnamesew;
		private _obj = createSimpleObject [_curname, [0,0,0], true];
		(0 boundingBoxReal _obj) params ["_p1", "_p2"];
		private _z = (abs ((_p2 # 2) - (_p1 # 2)) / 2) * 0.1;
		_obj attachTo [_x, [0.5, 0, 0.62 + _z]];
		_obj setObjectScale 0.1;
		_cnamesew = _cnamesew - [_curname];
		_objsar pushBack _obj;
	} forEach _objs;
	
	sleep 600;
};

#endif
