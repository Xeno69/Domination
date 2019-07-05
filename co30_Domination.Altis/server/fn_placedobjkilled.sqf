// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_placedobjkilled.sqf"
#include "..\x_setup.sqf"

params ["_obj"];

__TRACE_1("","_obj")

private _val = _obj getVariable "d_owner";
if (!isNil "_val") then {
	if !(_val isEqualType "") then {
		_val = str _val;
	};
	__TRACE_1("","_val")
	private _ar = d_placed_objs_store getVariable _val;
	if (!isNil "_ar") then {
		__TRACE_1("","_ar")
		private _fidx = _ar findIf {_x # 0 == _obj};
		if (_fidx > -1) then {
			deleteMarker (_ar # _fidx # 1);
			_ar deleteAt _fidx;
		};
	};
	_val remoteExecCall ["d_fnc_PlacedObjAn", [0, -2] select isDedicated];
};
_obj removeAllMPEventHandlers "MPKilled";
private _content = _obj getVariable ["d_objcont", []];
if !(_content isEqualTo []) then {
	{
		deleteVehicle _x;
	} forEach _content;
};
deleteVehicle _obj;