// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addgrp2hc.sqf"
#include "..\..\x_setup.sqf"

_this setVariable ["d_can_move2hc", true];

if (d_hc_array isEqualTo []) exitWith {};

d_hc_array = d_hc_array - [objNull, grpNull];

if (d_hc_array isEqualTo []) exitWith {};

if (count d_hc_array == 1) then {
	_this setGroupOwner (owner (d_hc_array # 0));
} else {
	if (d_hc_counter >= count d_hc_array) then {
		d_hc_counter = 0;
	};
	
	_this setGroupOwner (owner (d_hc_array # d_hc_counter));
	
	d_hc_counter = d_hc_counter + 1;
};
