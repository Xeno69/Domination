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
				if (d_db_type == 2) exitWith {
					private _tmpar = missionProfileNamespace getVariable (getPlayerUID _pl);
					if (!isNil "_tmpar") then {
						_tmpar set [8, (_tmpar # 8) + 1];
						missionProfileNamespace setVariable [getPlayerUID _pl, _tmpar];
					};
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
						if (d_db_type == 2) exitWith {
							private _tmpar = missionProfileNamespace getVariable _uid;
							if (!isNil "_tmpar") then {
								_tmpar set [11, (_tmpar # 11) + 1];
								missionProfileNamespace setVariable [_uid, _tmpar];
							};
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
				if (d_db_type == 2) exitWith {
					private _tmpar = missionProfileNamespace getVariable (getPlayerUID _pl);
					if (!isNil "_tmpar") then {
						_tmpar set [9, (_tmpar # 9) + 1];
						missionProfileNamespace setVariable [(getPlayerUID _pl), _tmpar];
					};
				};
			};
			[_pl, 5] call d_fnc_addScore;
		};
	};
};
