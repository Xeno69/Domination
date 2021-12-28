// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _firstar = (count d_target_names) call d_fnc_RandomIndexArray;
__TRACE_1("","_firstar")
private _add = [];

for "_i" from 0 to (count _firstar - 2) do {
	_nn = _firstar # _i;
	if (((d_target_names # _nn) # 0) distance2D ((d_target_names select (_firstar select (_i + 1))) # 0) < 800) then {
		_add pushBack _nn;
		_firstar set [_i, -999];
	};
};

__TRACE_1("","_add")

if (_add isNotEqualTo []) then {
	_firstar = _firstar - [-999];
	_firstar append _add;
};

if (count _firstar > d_MainTargets_num) then { 
	_firstar resize d_MainTargets_num;
};

__TRACE_1("","_firstar")

_firstar