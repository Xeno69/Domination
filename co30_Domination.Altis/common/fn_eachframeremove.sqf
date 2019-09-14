// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeremove.sqf"
#include "..\x_setup.sqf"

params ["_name"];

d_ef_store setVariable [_name, nil];

if ((allVariables d_ef_store) isEqualTo []) then {
	removeMissionEventHandler ["EachFrame", d_ef_running];
	d_ef_running = -1;
};