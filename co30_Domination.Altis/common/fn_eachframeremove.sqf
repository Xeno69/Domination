// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeremove.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_name"];

if (_name in (allVariables d_ef_store)) then {
	d_ef_store setVariable [_name, nil];

	if ((allVariables d_ef_store) isEqualTo []) then {
		removeMissionEventHandler ["EachFrame", d_ef_running];
		d_ef_running = -1;
	};
} else {
	{
		private _trig = d_ef_trig_store getVariable _x;
		__TRACE_2("","_x","_trig")
		if (!isNil {_trig getVariable _name}) exitWith {
			_trig setVariable [_name, nil];
			if ((allVariables _trig) isEqualTo []) then {
				d_ef_trig_store deleteAt _forEachIndex;
				deleteVehicle _trig;
			};
		};
	} forEach (allVariables d_ef_trig_store);
};