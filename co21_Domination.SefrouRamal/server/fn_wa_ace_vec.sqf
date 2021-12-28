// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_v"];

__TRACE_1("","_this")

sleep 1;

while {alive _v && {canMove _v}} do {
	sleep 1;
};
if (alive _v) then {
	__TRACE_1("alive 1","_v")
	sleep (1 + random 1);
	__TRACE_1("alive 2","_v")
	if (alive _v) then {
		_v setDamage 1;
	};
};
