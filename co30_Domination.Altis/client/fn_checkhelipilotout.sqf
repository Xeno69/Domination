// by Xeno
#include "..\x_setup.sqf"

if (_this # 2 != player) exitWith {};

if (!isNil {player getVariable "d_hud_id"} && {(player getVariable "d_hud_id") != -1000}) then {
	(_this # 0) removeAction (player getVariable "d_hud_id");
	player setVariable ["d_hud_id", -1000];
};