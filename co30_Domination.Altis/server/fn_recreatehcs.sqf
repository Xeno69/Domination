// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

sleep 5;

d_hc_array = d_hc_array - [objNull, grpNull];

if (d_hc_array isEqualTo []) exitWith {};

{	
	__TRACE_1("","_x")
	if (count d_hc_array == 1) then {
		_x setGroupOwner (owner (d_hc_array # 0));
#ifdef __TT__
	if (d_with_ace && {!isNil {_x getVariable "d_ktypett"}}) then {
		_x remoteExecCall ["d_fnc_addgrhcace", owner (d_hc_array # 0)];
	};
#endif
	} else {
		if (d_hc_counter >= count d_hc_array) then {
			d_hc_counter = 0;
		};
		
		_x setGroupOwner (owner (d_hc_array # d_hc_counter));
#ifdef __TT__
		if (d_with_ace && {!isNil {_x getVariable "d_ktypett"}}) then {
			_x remoteExecCall ["d_fnc_addgrhcace", owner (d_hc_array # d_hc_counter)];
		};
#endif
		
		d_hc_counter = d_hc_counter + 1;
	};
	__TRACE_1("","groupOwner _x")
	sleep 0.5;
	if (d_hc_array isEqualTo []) exitWith {};
} forEach (allGroups select {!isNil {_x getVariable "d_can_move2hc"}});

d_recreatehcs_handle = nil;