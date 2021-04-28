// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_pl", "_kind", ["_obj", objNull]];

// 1 = radio tower, 2 = camp captured

if (_kind in [1, 2, 3]) then {
	call {
		if (_kind == 1) exitWith {
			call {
				if (d_db_type == 0) exitWith {
					"extdb3" callExtension format ["1:dom:radiotAdd:%1", getPlayerUID _pl];
				};
				if (d_db_type == 1) exitWith {
					["radiotAdd", [getPlayerUID _pl]] call d_fnc_queryconfigasync;
				};
			};
			[_pl, 3] call d_fnc_addScore;
		};
		if (_kind == 2) exitWith {
			if (!isNull _obj) then {
				private _uid = getPlayerUID _pl;
				private _last = _obj getVariable [_uid, -1];
				if (time - _last > 30) then {
					call {
						if (d_db_type == 0) exitWith {
							"extdb3" callExtension format ["1:dom:campAdd:%1", _uid];
						};
						if (d_db_type == 1) exitWith {
							["campAdd", [_uid]] call d_fnc_queryconfigasync;
						};
					};
					[_pl, 4] call d_fnc_addScore;
					_obj setVariable [_uid, time];
				};
			};
		};
		if (_kind == 3) exitWith {
			call {
				if (d_db_type == 0) exitWith {
					"extdb3" callExtension format ["1:dom:mtsmAdd:%1", getPlayerUID _pl];
				};
				if (d_db_type == 1) exitWith {
					["mtsmAdd", [getPlayerUID _pl]] call d_fnc_queryconfigasync;
				};
			};
			[_pl, 5] call d_fnc_addScore;
		};
	};
};
