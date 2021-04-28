// by Xeno
#include "..\x_setup.sqf"

if ((_this # 1) isNotEqualTo []) then {
	{
		if (_x getVariable ["d_hashchd", false]) then {
			_x setVariable ["d_hashchd", _x addEventHandler ["handleDamage", {call d_fnc_v_hd}]];
		};
	} forEach (_this # 1);
};
