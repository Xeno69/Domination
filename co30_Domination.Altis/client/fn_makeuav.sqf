// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface || {!d_player_canu}) exitWith {};

private _exitj = false;
if (d_with_ranked || {d_database_found}) then {
	if (score player < (d_ranked_a # 19)) then {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_76b", score player,d_ranked_a # 19];
		_exitj = true;
	} else {
		[player, 6] remoteExecCall ["d_fnc_ascfc", 2];
	};
};
if (_exitj) exitWith {};

if !(d_UAV_Terminal in (assignedItems player)) then {
	player setVariable ["d_has_gps", "ItemGPS" in (assignedItems player)];
	player linkItem d_UAV_Terminal;
};

private _uav = [getPosATL player, 0, d_UAV_Small, d_player_side, false, false] call bis_fnc_spawnVehicle;
__TRACE_1("","_uav")
_uav params ["_vecu", "_crew", "_grp"];

_grp deleteGroupWhenEmpty true;

_vecu allowCrewInImmobile true;

_vecu setVehicleReceiveRemoteTargets true;
_vecu setVehicleReportRemoteTargets true;
_vecu setVehicleRadar 1;

_vecu allowDamage false;

{
	_x setSkill ["spotDistance", 1];
} forEach _crew;	

player connectTerminalToUav _vecu;

player action ["UAVTerminalOpen"];

["a2", d_player_uid, _vecu] remoteExecCall ["d_fnc_p_o_ar", 2];

//diag_log ["UAVControl", UAVControl _vecu];

_uav spawn {
	scriptName "spawn_makuav";
	params ["_uav", "_crew"];
	__TRACE_1("spawn","_this")
	private _exit_it = false;
	sleep 1;
	while {true} do {
		if (!d_player_canu || {!alive _uav || {(isNull (findDisplay 160) && ((UAVControl _uav) # 1) isEqualTo "") || {isNull (getConnectedUav player)}}}) exitWith {};
		sleep 1.1;
	};
	__TRACE("uav spawn while over")
	
	["a2r", d_player_uid, _uav] remoteExecCall ["d_fnc_p_o_ar", 2];
	
	__TRACE_1("uav spawn","findDisplay 160")
	if (!isNull (findDisplay 160)) then {
		(findDisplay 160) closeDisplay 1;
	};

	{_uav deleteVehicleCrew _x} forEach _crew;
	deleteVehicle _uav;
	
	if (d_player_canu && {player getVariable ["d_has_gps", false]}) then {
		player linkItem "ItemGPS";
		player setVariable ["d_has_gps", false];
	};
	__TRACE("UAV spawn over")
};
