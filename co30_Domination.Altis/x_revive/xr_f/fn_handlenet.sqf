// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handlenet.sqf"
#include "..\..\x_macros.sqf"

__TRACE_1("","_this")
switch (param [1]) do {
	case 100: {
		__TRACE("Die case 100")
		if (local (param [0])) then {
			//(param [0]) playActionNow "Die";
			(param [0]) switchAction "Die";
			//(param [0]) switchMove "AinjPpneMstpSnonWrflDnon";
		};
	};
	case 101: {
		params ["_u"];
		_u switchMove "AmovPpneMstpSnonWnonDnon_healed";
		_u playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
		if (local _u) then {
			__TRACE("Die case 101")
			//_u playActionNow "Die";
			_u switchAction "Die";
			//_u switchMove "AinjPpneMstpSnonWrflDnon";
		};
	};
	case 102: {
		params ["_u"];
		_u switchMove "AmovPpneMstpSnonWnonDnon_healed";
		_u playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
	};
	case 103: {
		params ["_u"];
		_u switchMove "";
		if (local _u) then {_u moveInCargo (param [2])};
	};
	case 104: {if (local (param [0])) then {unassignVehicle (param [0])}};
	case 105: {(param [0]) switchMove ""};
};