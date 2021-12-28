// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface || {(_this # 3) != "Heal" || {isNil {(_this # 0) getVariable "d_mplayer"} || {(_this # 0) getVariable "d_mplayer" == player || {!d_player_canu}}}}) exitWith {};

((_this # 0) getVariable "d_mplayer") spawn {
	scriptName "spawn_healatmash";
	player setVariable ["d_isinaction", true];

	waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!d_player_canu}};
	player setVariable ["d_isinaction", false];
	if (!d_player_canu) exitWith {};

	player setDamage 0;
	player setBleedingRemaining 0;
	
	if (d_with_ranked || {d_database_found}) then {
		private _ow = (_this # 0) getVariable "d_owner";
		if (!isNil "_ow") then {
			[_ow, 11] remoteExecCall ["d_fnc_addscore", 2]
		};
	};
};