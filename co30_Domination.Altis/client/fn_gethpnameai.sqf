// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_u"];
private _n = "";

if (alive _u) then {
	_n = _u getVariable "d_phname";
	if (isNil "_n") then {
		_n = "(AI) " + name _u;
		if (_u getUnitTrait "Medic") then {
			_n = [_n, " ", d_phud_loc884] joinString "";
		};
		_u setVariable ["d_phname", _n];
	};
};
_n
