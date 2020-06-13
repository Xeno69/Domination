// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitlistm.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_grptype", "_side"];

private _ret =+ selectRandom (missionNamespace getVariable format ["d_%1_%2", _grptype, [switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case civilian: {"W"};}, _side] select (_side isEqualType "")]);

if (!d_with_ace) then {
	if (count _ret > 7) then {
		_ret resize (selectRandom [6, 7]);
	};
} else {
	if (count _ret > 5) then {
		_ret resize (selectRandom [4, 5, 6]);
	};
};

if (_ret isEqualTo []) then {
	diag_log ["Attention in getunitlistm!!! Current _grptype returns empty list, _grptype:", _grptype, ", _side:", _side];
};

_ret
