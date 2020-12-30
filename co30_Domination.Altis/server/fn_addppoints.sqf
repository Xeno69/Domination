// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addppoints.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_kind", ["_obj", objNull]];

// 1 = radio tower, 2 = camp captured

if (_kind in [1, 2, 3]) then {
#ifndef __INTERCEPTDB__
	call {
		if (_kind == 1) exitWith {
			"extdb3" callExtension format ["1:dom:radiotAdd:%1", getPlayerUID _pl];
			[_pl, 3] call d_fnc_addScore;
		};
		if (_kind == 2) exitWith {
			if (!isNull _obj) then {
				private _uid = getPlayerUID _pl;
				private _last = _obj getVariable [_uid, -1];
				if (time - _last > 30) then {
					"extdb3" callExtension format ["1:dom:campAdd:%1", _uid];
					[_pl, 4] call d_fnc_addScore;
					_obj setVariable [_uid, time];
				};
			};
		};
		if (_kind == 3) exitWith {
			"extdb3" callExtension format ["1:dom:mtsmAdd:%1", getPlayerUID _pl];
			[_pl, 5] call d_fnc_addScore;
		};
	};
#else
	if (d_interceptdb) then {
		if (_kind == 1) exitWith {
			["radiotAdd", [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
			[_pl, 3] call d_fnc_addScore;
		};
		if (_kind == 2) exitWith {
			if (!isNull _obj) then {
				private _uid = getPlayerUID _pl;
				private _last = _obj getVariable [_uid, -1];
				if (time - _last > 30) then {
				["campAdd", [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
				[_pl, 4] call d_fnc_addScore;
				_obj setVariable [_uid, time];
			};
		};
		if (_kind == 3) exitWith {
			["mtsmAdd", [getPlayerUID _pl]] call dsi_fnc_queryconfigasync;
			[_pl, 5] call d_fnc_addScore;
		};
	};
#endif
};