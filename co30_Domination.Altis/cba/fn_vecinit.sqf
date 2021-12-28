// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

//__TRACE_1("","_this")

if (d_with_dynsim == 1) exitWith {};

if (!isServer) exitWith {};

params ["_vec"];

if (_vec isKindOf "ParachuteBase" || {unitIsUAV _vec}) exitWith {};

_vec spawn {
	scriptName "spawn vecinit";
	sleep 15;
	if (alive _this && {isNil {_this getVariable "d_nodyn"} && {!dynamicSimulationEnabled  _this}}) then {
		_this enableDynamicSimulation true; 
	};
};
