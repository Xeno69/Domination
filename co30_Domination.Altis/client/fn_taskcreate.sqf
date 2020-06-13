// by Xeno
#define THIS_FILE "fn_taskcreate.sqf"
#include "..\x_setup.sqf"

/*
	Author: Jiri Wainar

	Description:
	Create a task.

	Parameters:
		0: BOOL or OBJECT or GROUP or SIDE or ARRAY - Task owner(s)
		1: STRING or ARRAY - Task name or array in the format [task name, parent task name]
		2: ARRAY or STRING - Task texts in the format ["description", "title", "marker"] or CfgTaskDescriptions class
		3: OBJECT or ARRAY or STRING - Task destination (use [object,true] to always show marker on the object, even if player doesn't 'knowsAbout' it)
		4: BOOL or NUMBER or STRING - Task state (or true to set as current)
		5: NUMBER - Task priority (when automatically selecting a new current task, higher priority is selected first)
		6: BOOL - Show notification (default: true)
		7: STRING - Task type as defined in the CfgTaskTypes
		8: BOOL - Task always visible in 3D (default: false)

	Example:
	[_owner,_taskid,_texts,_destination,_state,_priority,_showNotification,_taskType,_alwaysVisible] call bis_fnc_taskCreate;

	Returns:
	STRING - Task ID
*/
#define DESTINATION					4       // _destination		| [objNull,false]
#define PRIORITY					5       // _priority		| -1
#define DESCRIPTION					6       // _description		| ""
#define TITLE						7       // _title		| ""
#define MARKER						8       // _marker		| ""
#define STATE						9       // _state		| "CREATED"
#define TYPE						10      // _type		| "Default"
#define CORE						11      // _core		| false

#define VAR_TEMPLATE					"%1.%2"
#define GET_VAR(TASKVAR,INDEX)				format[VAR_TEMPLATE,TASKVAR,INDEX]
#define GET_DEFAULT_DATA(INDEX)				["","",[],[],[objNull,false],-1,"","","","CREATED","Default",false] select INDEX

//this is internal, only for use in GET_DATA macro, don't use outside as it is not safe :)
#define GET_DATA_UNSAFE(TASKVAR,INDEX)			(missionNamespace getVariable [GET_VAR(TASKVAR,INDEX),GET_DEFAULT_DATA(INDEX)])

#define GET_DATA(TASKVAR,INDEX)				(if (GET_DATA_UNSAFE(TASKVAR,INDEX) isEqualType []) then {+GET_DATA_UNSAFE(TASKVAR,INDEX)} else {GET_DATA_UNSAFE(TASKVAR,INDEX)})

private _target = param [0,true,[true,sideunknown,grpnull,objnull,[],""]];
private _params = param [1,"",["",[]]];

private _taskID = _params param [0,"",[""]]; if (_taskID == "") exitWith {};
private _taskVar = _taskID call bis_fnc_taskVar;

private _texts = param [2,[GET_DATA(_taskVar,DESCRIPTION),GET_DATA(_taskVar,TITLE),GET_DATA(_taskVar,MARKER)],[[],""]];
private _dest = param [3,GET_DATA(_taskVar,DESTINATION),[objNull,[],""]];
private _state = param [4,GET_DATA(_taskVar,STATE),["",false,0]];
private _priority = param [5,GET_DATA(_taskVar,PRIORITY),[0]];
private _showNotification = param [6,true,[true]];
private _taskType = param [7,GET_DATA(_taskVar,TYPE),[""]];
private _alwaysVisible = param [8,GET_DATA(_taskVar,CORE),[true]];

if (_dest isEqualType "") then {_dest = markerpos _dest;};
if (_state isEqualType 0) then {_state = _state > 0;};

[_params,_target,_texts,_dest,_state,_priority,_showNotification,false,_taskType,_alwaysVisible] call bis_fnc_setTask;