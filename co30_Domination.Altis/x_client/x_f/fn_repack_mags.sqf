// by Xeno
#define THIS_FILE "fn_repack_mags.sqf"
#include "..\..\x_setup.sqf"

private _ular = getUnitLoadout player;

private _conf = configFile>>"CfgMagazines";

private _store = d_HeliHEmpty createVehicleLocal [0,0,0];

private _fn_helper = {
	params ["_ele"];
	if ((_ele # 0) isKindOf ["CA_Magazine", _conf] && {getNumber (_conf>>(_ele # 0)>>"count") > 1}) then {
		player sideChat str _ele;
		diag_log _ele;
		
		private _aaa = _store getVariable (_ele # 0);
	};
};

{
	if (_x isEqualType []) then {
		private _idx1 = _forEachIndex;
		{
			if (_x isEqualType [] && {!(_x isEqualTo [])}) then {
				private _idx2 = _forEachIndex;
				if ((_x # 0) isEqualType "") then {
					[_x, _idx1, _idx2, -1] call _fn_helper;
				} else {
					{
						[_x, _idx1, _idx2, _forEachIndex] call _fn_helper;
					} forEach _x;
				};
			};
		} forEach _x;
	};
} forEach _ular;

// "30Rnd_65x39_caseless_mag" isKindOf ["CA_Magazine", configFile>>"CfgMagazines"]