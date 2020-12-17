// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeremove.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_name"];

if (_name in (keys d_ef_hash)) then {
	d_ef_hash deleteAt _name;

	if ((count d_ef_hash) isEqualTo 0) then {
		removeMissionEventHandler ["EachFrame", d_ef_running];
		d_ef_running = nil;
		d_ef_hash = nil;
	};
} else {
	private "_todel";
	{
		private _trig = _y;
		__TRACE_2("","_x","_trig")
		if (!isNil {_trig getVariable _name}) exitWith {
			_trig setVariable [_name, nil];
			if ((allVariables _trig) isEqualTo []) then {
				deleteVehicle _trig;
				d_ef_trig_hash deleteAt _x;
			};
			break;
		};
	} forEach d_ef_trig_hash;
};
