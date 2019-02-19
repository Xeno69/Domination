// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_revive\xr_init.sqf"
#include "..\x_macros.sqf"

if (isDedicated) exitWith {};

if (didJIP) then {
	waitUntil {!isNull player};
};
waitUntil {player == player};

if (isNil {player getVariable "xr_lives"}) then {
	player setVariable ["xr_lives", xr_max_lives, true];
};
player setVariable ["xr_is_dragging", false];
player setVariable ["xr_presptime", -1];
player setVariable ["xr_pluncon", false, true];
player setVariable ["xr_pisinaction", false];
player setVariable ["xr_dragged", false, true];
player setVariable ["xr_isdead", false];

xr_uncon_units = [];
xr_death_pos = [];

private _grpl = group player;
xr_side_pl = [playerSide, side _grpl] select (!isNull _grpl);

xr_strpl = str player;
xr_strpldead = xr_strpl + "_xr_dead";

player addEventHandler ["killed", {_this call xr_fnc_killedEH}];

player addEventHandler ["respawn", {_this call xr_fnc_respawneh}];

xr_name_player = player call d_fnc_getplayername;

xr_announce_ar = [];
xr_announce_unit_ar = [];

player addEventHandler ["handleDamage", {_this call xr_fnc_ClientHD}];

if (d_only_medics_canrevive != 0) then {
	xr_pl_can_revive = true;
} else {
	xr_pl_can_revive = player getUnitTrait "Medic";
};

{
	if (alive _x && {_x getVariable ["xr_pluncon", false]}) then {
		_x spawn {
			scriptName "spawn xr init";
			sleep 1;
			if (alive _this && {_this getVariable ["xr_pluncon", false]}) then {
				_this call xr_fnc_addActions;
			};
		};
		xr_uncon_units pushBackUnique _x;
	} else {
		_x setVariable ["xr_ReviveAction", -9999];
		_x setVariable ["xr_DragAction", -9999];
	};
} forEach ((allPlayers - entities "HeadlessClient_F") select {d_player_side getFriend side (group _x) >= 0.6});

addMissionEventHandler ["Draw3D", {call xr_fnc_draw3d}];
