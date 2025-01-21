// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

_this setVariable ["d_can_move2hc", true];

if (d_hc_array isEqualTo []) exitWith {};

d_hc_array = d_hc_array - [objNull, grpNull];

__TRACE_1("","d_hc_array")

if (d_hc_array isEqualTo []) exitWith {};

if (count d_hc_array == 1) then {
	_this setGroupOwner (owner (d_hc_array # 0));
#ifdef __DEBUG__
	_this spawn {
		sleep 5;
		diag_log ["group move:", _this, "groupOwner  :", groupOwner _this, "local:", local _this];
	};
#endif
#ifdef __TT__
	if (d_with_ace && {!isNil {_this getVariable "d_ktypett"}}) then {
		_this remoteExecCall ["d_fnc_addgrhcace", owner (d_hc_array # 0)];
	};
#endif
	__TRACE_1("d_hc_array = 1","groupOwner _this")
} else {
	if (d_hc_counter >= count d_hc_array) then {
		d_hc_counter = 0;
	};
	
	_this setGroupOwner (owner (d_hc_array # d_hc_counter));
	#ifdef __DEBUG__
	_this spawn {
		sleep 5;
		diag_log ["group move:", _this, "groupOwner  :", groupOwner _this, "local:", local _this];
	};
#endif
#ifdef __TT__
	if (d_with_ace && {!isNil {_this getVariable "d_ktypett"}}) then {
		_this remoteExecCall ["d_fnc_addgrhcace", owner (d_hc_array # d_hc_counter)];
	};
#endif
	
	d_hc_counter = d_hc_counter + 1;
	
	__TRACE_1("d_hc_array > 1","groupOwner _this")
};
