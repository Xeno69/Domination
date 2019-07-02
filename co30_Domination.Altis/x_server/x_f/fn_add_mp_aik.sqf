// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_add_mp_aik.sqf"
#include "..\..\x_setup.sqf"

if (d_with_ace) exitWith {
	if (local (_this # 0)) then {
		[[15, 3, 2, 1], _this # 1, _this # 0] call d_fnc_AddKills;
	};
};

if (!isServer) exitWith {};

[[15, 3, 2, 1], _this # 1, _this # 0] call d_fnc_AddKills;