// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_recreatehcs.sqf"
#include "..\..\x_setup.sqf"

sleep 5;

d_hc_array = d_hc_array - [objNull, grpNull];

if (d_hc_array isEqualTo []) exitWith {};

{
	if (count d_hc_array == 1) then {
		_x setGroupOwner (owner (d_hc_array # 0));
	} else {
		if (d_hc_counter >= count d_hc_array) then {
			d_hc_counter = 0;
		};
		
		_x setGroupOwner (owner (d_hc_array # d_hc_counter));
		
		d_hc_counter = d_hc_counter + 1;
	};
	sleep 0.5;
} forEach allGroups select {!isNil {_x getVariable "d_can_move2hc"}};