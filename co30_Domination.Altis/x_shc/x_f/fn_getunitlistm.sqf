// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitlistm.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_grptype", "_side"];

private _ret = selectRandom (missionNamespace getVariable format ["d_%1_%2", _grptype, [switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case civilian: {"W"};}, _side] select (_side isEqualType "")]);

__TRACE_2("1","count _ret","_ret")

// for now reduce inf groups to 7 units max to save a little bit performance
if (count _ret > 7) then {
	while {count _ret > 7} do {
		_ret deleteAt (ceil (random (count _ret - 1)));
	};
};
__TRACE_2("2","count _ret","_ret")

_ret
