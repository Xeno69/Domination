// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_enabledynsim.sqf"
#include "..\x_setup.sqf"

params ["_obj", ["_stime", 20]];

if (_stime > 0) then {
	sleep _stime;
};
if (!isNull _obj && {!dynamicSimulationEnabled _obj}) then {
	_obj enableDynamicSimulation true;
};
