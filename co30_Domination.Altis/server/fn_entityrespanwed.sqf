// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_newEntity", "_oldEntity"];

private _cur = getAssignedCuratorLogic _oldEntity;
if (isNull _cur) exitWith {};
[_newEntity, _cur] spawn {
	params ["_newEntity", "_cur"];
	waitUntil {sleep 1; alive _newEntity};
	_newEntity assignCurator _cur;
};