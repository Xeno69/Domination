// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitlistm.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_grptype", "_side"];

private _ret =+ selectRandom (missionNamespace getVariable format ["d_%1_%2", _grptype, [switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case civilian: {"W"};}, _side] select (_side isEqualType "")]);

if (count _ret > 7) then {
	_ret resize (selectRandom [5, 6, 7]);
};

_ret
