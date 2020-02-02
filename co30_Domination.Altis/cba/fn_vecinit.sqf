// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vecinit.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!isServer) exitWith {};

params ["_vec"];

if (_vec isKindOf "ParachuteBase" || {unitIsUAV _vec}) exitWith {};

if (d_with_dynsim == 0) then {
	if (!dynamicSimulationEnabled  _vec) then {
		_vec enableDynamicSimulation true; 
	};
};
