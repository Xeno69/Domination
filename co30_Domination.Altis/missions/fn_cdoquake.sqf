// by Xeno
#define THIS_FILE "fn_cdoquake.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (isTouchingGround (vehicle player) && {player distance2D (d_x_sm_pos # 0) < 400}) then {
	[_this] spawn BIS_fnc_earthquake;
};