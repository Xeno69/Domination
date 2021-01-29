// by Xeno
#define THIS_FILE "fn_updatemove.sqf"
#include "..\x_setup.sqf"

private _dst = (player getVariable "d_move_opos") distance2D (player getVariable ["d_move_stop", getPosWorld player]);
__TRACE_1("","_dst")
private _ar = player getVariable "d_p_distar";
if (isNull objectParent player) then {
	_ar set [0, (_ar # 0) + _dst];
} else {
	private _v = vehicle player;
	call {
		if (_v isKindOf "LandVehicle") exitWith {
			_ar set [1, (_ar # 1) + _dst];
		};
		if (_v isKindOf "Air") exitWith {
			_ar set [2, (_ar # 2) + _dst];
		};
		if (_v isKindOf "Ship") exitWith {
			_ar set [3, (_ar # 3) + _dst];
		};
	};
};
player setVariable ["d_move_opos", getPosWorld player];
