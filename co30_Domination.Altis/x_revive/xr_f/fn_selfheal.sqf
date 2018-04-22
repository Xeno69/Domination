// by Xeno
// #define __DEBUG__
#define THIS_FILE "fn_selfheal.sqf"

#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

player setVariable ["xr_pisinaction", true];

private _ma = "ainvpknlmstpslaywrfldnon_medic";
player playMove _ma;
private _endtime = time + 12;
waitUntil {animationState player == _ma || {!alive player || {player getVariable "xr_pluncon" || {time > _endtime}}}};
waitUntil {animationState player != _ma || {!alive player || {player getVariable "xr_pluncon" || {time > _endtime}}}};

if (alive player && {!(player getVariable "xr_pluncon")}) then {
	player setDamage 0;
	player setVariable ["xr_numheals", (player getVariable "xr_numheals") - 1];
};

player setVariable ["xr_pisinaction", false];
