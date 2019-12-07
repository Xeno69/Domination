// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cgraa.sqf"
#include "..\x_setup.sqf"

params ["_side", "_type", "_mname"];

private _mlen = count _mname;

{
	private _grp = [_side] call d_fnc_creategroup;
	if (d_with_ai) then {
		_grp setVariable ["d_do_not_delete", true];
	};
	(([1, markerPos _x, _type, _grp, markerDir _x, false, true] call d_fnc_makevgroup) # 0) params ["_av"];
	_grp deleteGroupWhenEmpty true;
	_av lock true;
	if (!isNull (driver _av)) then {
		_av lockDriver true;
		_av deleteVehicleCrew (driver _av);
		_av lock 2;
	};
	_grp call d_fnc_addgrp2hc;
} forEach (allMapMarkers select {_x select [0, _mlen] == _mname});
