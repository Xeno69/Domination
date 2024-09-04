// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_grptype", "_side"];

private _ret =+ selectRandom (missionNamespace getVariable format ["d_%1_%2", _grptype, [switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case civilian: {"W"};}, _side] select (_side isEqualType "")]);

if (isNil "_ret") exitWith {
	diag_log ["Attention in getunitlistm!!! Current _grptype returns nil, _grptype:", _grptype, ", _side:", _side];
	[]
};

	if (d_grp_size_override == 0) then {
		// 0 = normal, resize the group if it is too large
		if (!d_with_ace) then {
			if (count _ret > 7) then {
				_ret resize (selectRandom [6, 7]);
			};
		};
	} else {
		if (d_grp_size_override == 1) then {
			// 1 = high, do not resize the group, do nothing
		} else {
			// 2 or higher, resize group to d_grp_size_override if possible
			if (count _ret > d_grp_size_override) then {
				_ret resize d_grp_size_override;
			};
		};
	};


if (_ret isEqualTo []) then {
	diag_log ["Attention in getunitlistm!!! Current _grptype returns empty list, _grptype:", _grptype, ", _side:", _side];
};

_ret
