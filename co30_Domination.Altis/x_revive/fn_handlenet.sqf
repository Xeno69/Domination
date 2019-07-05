// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handlenet.sqf"
#include "..\x_macros.sqf"

__TRACE_1("","_this")
switch (_this select 1) do {
	case 100: {
		__TRACE("Die case 100")
		if (local (_this select 0)) then {
			//(_this select 0) playActionNow "Die";
			(_this select 0) switchAction "Die";
			//(_this select 0) switchMove "AinjPpneMstpSnonWrflDnon";
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
		//_u switchMove "AfdsPpneMstpSnonWnonDnon_AfdsPpneMstpSrasWrflDnon"; // not working, player can't walk or run
	};
	case 103: {
		params ["_u"];
		_u switchMove "";
		if (local _u) then {_u moveInCargo (_this select 2)};
	};
	case 104: {if (local (_this select 0)) then {unassignVehicle (_this select 0)}};
	case 105: {(_this select 0) switchMove ""};
};