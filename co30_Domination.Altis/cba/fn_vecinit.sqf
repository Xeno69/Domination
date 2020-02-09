// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vecinit.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (d_with_dynsim == 1) exitWith {};

if (!isServer) exitWith {};

params ["_vec"];

if (_vec isKindOf "ParachuteBase" || {unitIsUAV _vec}) exitWith {};

_vec spawn {
	sleep 15;
	if (alive _this && {isNil {_this getVariable "d_nodyn"} && {!dynamicSimulationEnabled  _this}}) then {
		_this enableDynamicSimulation true; 
	};
};
