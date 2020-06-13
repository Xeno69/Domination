// by Xeno
#define THIS_FILE "fn_tasksetstate.sqf"
#include "..\x_setup.sqf"

/*
	Author: Jiri Wainar

	Description:
	Set a task's state.

	Parameters:
		0: STRING - Task name
		1: STRING - Task state; one of the following:
			"CREATED"
			"ASSIGNED"
			"AUTOASSIGNED" ("ASSIGNED" when no task is assigned yet, otherwise "CREATED")
			"SUCCEEDED"
			"FAILED"
			"CANCELED"
		2: BOOL - Show hint (default: true)

	Returns:
	STRING - Task ID

	Example:
	["Hunter","SUCCEEDED"] call bis_fnc_taskSetState;
*/

private ["_taskID","_state","_hint"];
_taskID = param [0,"",[""]];
_state 	= param [1,"",[""]];
_hint 	= param [2,true,[true]];

[_taskID,nil,nil,nil,_state,nil,_hint,false] call bis_fnc_setTask;