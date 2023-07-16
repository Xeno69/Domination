// by Xeno edited by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface || {!d_player_canu}) exitWith {};

if (d_enable_extra_cas == 0) exitWith {
	// disabled
	systemChat localize "STR_DOM_MISSIONSTRING_1063";
};

if (count d_cur_uav_combat > 0 && {d_arty_unlimited != 1}) exitWith {
	//diag_log ["team already has one combat UAV and arty is not unlimited"];
	systemChat localize "STR_DOM_MISSIONSTRING_COMBAT_UAV_TEAM_MAX_REACHED";
};

private _uav_count_player = 0;
{
	if (_x getVariable "d_player_netId" == netId player) then {
		_uav_count_player = _uav_count_player + 1;
	};
} forEach d_cur_uav_combat;

if (_uav_count_player > 0) exitWith {
	//diag_log ["player already has a combat UAV, no more allowed"];
	systemChat localize "STR_DOM_MISSIONSTRING_COMBAT_UAV_PLAYER_MAX_REACHED";
};

private _exitj = false;
if (d_with_ranked || {d_database_found}) then {
	if (score player < (d_ranked_a # 24)) then {
		[1, format [localize "STR_DOM_MISSIONSTRING_76b", score player,d_ranked_a # 24]] call d_fnc_sideorsyschat;
		_exitj = true;
	} else {
		[player, 11] remoteExecCall ["d_fnc_ascfc", 2]; // subtract points
	};
};
if (_exitj) exitWith {};

if !(d_UAV_Terminal in (assignedItems player)) then {
	player setVariable ["d_has_gps", "ItemGPS" in (assignedItems player)];
	player linkItem d_UAV_Terminal;
};

private _uav = [[(getPosATL player) # 0, (getPosATL player) # 1, 2000], 0, d_UAV_CAS, d_player_side, false, false] call bis_fnc_spawnVehicle;

__TRACE_1("","_uav")
_uav params ["_vecu", "_crew", "_grp"];

_vecu setVariable ["d_player_netId", netId player];

d_cur_uav_combat pushBack _vecu;
publicVariable "d_cur_uav_combat";

_grp deleteGroupWhenEmpty true;

_vecu allowCrewInImmobile true;

_vecu setVehicleReceiveRemoteTargets true;
_vecu setVehicleReportRemoteTargets true;
_vecu setVehicleRadar 1;

//_vecu allowDamage false;

{
	_x setSkill ["spotDistance", 1];
} forEach _crew;	

private _loiter_pos = getPos player;
if !(d_cur_tgt_pos isEqualTo []) then {
	_loiter_pos = d_cur_tgt_pos;
};
private _loiter_radius = 800;
if (d_cur_target_radius > 0) then {
	_loiter_radius = d_cur_target_radius + 800;
};
_wp = _grp addWaypoint [_loiter_pos, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius _loiter_radius;
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointCombatMode "BLUE";

_vecu flyInHeight 2000;

player connectTerminalToUav _vecu;

player action ["UAVTerminalOpen"];
