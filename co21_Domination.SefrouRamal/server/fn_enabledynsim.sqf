// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_obj", ["_stime", 20]];

if (_stime > 0) then {
	sleep _stime;
};
if (!isNull _obj && {isNil {_obj getVariable "d_nodyn"} && {!dynamicSimulationEnabled _obj}}) then {
	_obj enableDynamicSimulation true;
};
