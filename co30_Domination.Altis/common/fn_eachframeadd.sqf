// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeadd.sqf"
#include "..\x_setup.sqf"

params ["_name", "_code", ["_delta", 0], ["_type", "seconds"]];

_type = [1, 0] select (_type == "seconds");

d_ef_store setVariable [_name, [_code, _delta, -1, _type]];

if (d_ef_running == -1) then {
	d_ef_running = addMissionEventhandler ["EachFrame", {call d_fnc_eachframerun}];
};

// TODO check if everything works with d_ef_events array replaced with allVariables d_ef_store