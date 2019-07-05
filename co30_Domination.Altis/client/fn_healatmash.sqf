// by Xeno
#define THIS_FILE "fn_healatmash.sqf"
#include "..\x_setup.sqf"

if (!hasInterface || {_this select 1 != player || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}}) exitWith {};

player setVariable ["d_isinaction", true];

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 1;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}};
player setVariable ["d_isinaction", false];
if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {};

player setDamage 0;
player setBleedingRemaining 0;

if (d_with_ranked || {d_database_found}) then {
	[_this select 0, d_name_pl, d_ranked_a # 7] remoteExecCall ["d_fnc_ampoi", 2];
};
