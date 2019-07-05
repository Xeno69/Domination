// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gethpname.sqf"
#include "..\x_setup.sqf"

params ["_u"];
private _n = "";

if (alive _u) then {
	_n = _u getVariable "d_phname";
	if (isNil "_n") then {
		_n = _u call d_fnc_getplayername;
		if (_n == "") exitWith {};
		if (d_no_ai && {_u getUnitTrait "Medic"}) then {
			_n = _n + d_phud_loc884;
		};
		_u setVariable ["d_phname", _n];
		_u setVariable ["d_phname_d", format ["%1 %2", _n, d_phud_loc493]];
	};
} else {
	_n = _u getVariable "d_phname_d";
	if (isNil "_n") then {
		_n = _u call d_fnc_getplayername;
		if (_n == "") exitWith {};
		if (d_no_ai && {_u getUnitTrait "Medic"}) then {
			_n = _n + d_phud_loc884;
		};
		_u setVariable ["d_phname", _n];
		_n = format ["%1 %2", _n, d_phud_loc493];
		_u setVariable ["d_phname_d", _n];
	};
};
_n
