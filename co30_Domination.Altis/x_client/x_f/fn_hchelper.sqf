// by Xeno
#define THIS_FILE "fn_hchelper.sqf"
#include "..\..\x_setup.sqf"

sleep 3;

while {true} do {
	private _grsa = (hcAllGroups player) select {_x != group player && {isNil {_x getVariable "d_do_not_delete"}}};
	if !(_grsa isEqualTo []) then {
		{
			[_x, ["d_do_not_delete", true]] remoteExecCall ["setVariable", 2];
			_x setVariable ["d_do_not_delete", true];
		} forEach _grsa;
	};
	sleep 2;
};