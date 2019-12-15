// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeremove.sqf"
#include "..\x_setup.sqf"

params ["_name"];

if (_name in (allVariables d_ef_store)) then {
	d_ef_store setVariable [_name, nil];

	if ((allVariables d_ef_store) isEqualTo []) then {
		removeMissionEventHandler ["EachFrame", d_ef_running];
		d_ef_running = -1;
	};
} else {
	{
		if (!isNil {_x getVariable _name}) exitWith {
			_x setVariable [_name, nil];
			if ((allVariables _x) isEqualTo []) then {
				d_ef_trig_store deleteAt _forEachIndex;
				deleteVehicle _x;
			};
		};
	} forEach (allVariables d_ef_trig_store);
};