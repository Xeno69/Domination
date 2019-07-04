// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeadd.sqf"
#include "..\..\x_setup.sqf"

params ["_name", "_code", ["_delta", 0], ["_type", "seconds"]];

_type = [1, 0] select (_type == "seconds");

d_ef_store setVariable [_name, [_code, _delta, -1, _type]];
d_ef_events pushBack _name;

if (d_ef_running == -1) then {
	d_ef_running = addMissionEventhandler ["EachFrame", {call d_fnc_eachframerun}];
};