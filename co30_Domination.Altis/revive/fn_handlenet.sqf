// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handlenet.sqf"
#include "..\x_macros.sqf"

__TRACE_1("","_this")
call {
	if (_this select 1 == 100) exitWith {
		__TRACE("Die case 100")
		if (local (_this select 0)) then {
			//(_this select 0) playActionNow "Die";
			(_this select 0) switchAction "Die";
			//(_this select 0) switchMove "AinjPpneMstpSnonWrflDnon";
		};
	};
	if (_this select 1 == 101) exitWith {
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
	if (_this select 1 == 102) exitWith {
		params ["_u"];
		_u switchMove "AmovPpneMstpSnonWnonDnon_healed";
		_u playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
		//_u switchMove "AfdsPpneMstpSnonWnonDnon_AfdsPpneMstpSrasWrflDnon"; // not working, player can't walk or run
	};
	if (_this select 1 == 103) exitWith {
		params ["_u"];
		_u switchMove "";
		if (local _u) then {_u moveInCargo (_this select 2)};
	};
	if (_this select 1 == 104) exitWith {
		if (local (_this select 0)) then {unassignVehicle (_this select 0)};
	};
	if (_this select 1 == 105) then {
		(_this select 0) switchMove "";
	};
};
