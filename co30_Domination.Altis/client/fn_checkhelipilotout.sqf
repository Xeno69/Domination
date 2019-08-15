// by Xeno
#define THIS_FILE "fn_checkhelipilotout.sqf"
#include "..\x_setup.sqf"

if (_this select 2 != player) exitWith {};

if (!isNil {player getVariable "d_hud_id"} && {(player getVariable "d_hud_id") != -1000}) then {
	(_this select 0) removeAction (player getVariable "d_hud_id");
	player setVariable ["d_hud_id", -1000];
};