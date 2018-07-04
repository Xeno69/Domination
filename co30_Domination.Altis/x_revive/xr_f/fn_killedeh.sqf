// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_killedeh.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

__TRACE_1("start","_this")
player setVariable ["xr_presptime", 6];
setPlayerRespawnTime 6;
__TRACE("respawn time 6")
enableRadio false;
xr_death_pos = [];
private _do_black = true;
if (player getVariable "xr_pluncon") then {
	player call xr_fnc_CheckRespawn;
} else {
	player setVariable ["xr_pluncon", true, true];
	if (xr_max_lives != -1) then {
		private _lives = (player getVariable "xr_lives") - 1;
		__TRACE_1("lives left","_lives")
		player setVariable ["xr_lives", _lives];
		[getPlayerUID player, _lives] remoteExecCall ["d_fnc_ChangeRLifes", 2];
		if (_lives == -1) then {
			__TRACE("lives = -1")
			player setVariable ["xr_isdead", true];
			xr_phd_invulnerable = true;
			[true] spawn xr_fnc_park_player;
			player removeAllEventHandlers "killed";
			player removeAllEventHandlers "respawn";
			_do_black = false;
		};
	};
};

__TRACE_1("","_do_black")
if (_do_black) then {
	0 spawn {
		private _etime = time + (player getVariable "xr_presptime") - 1.3;
		__TRACE_1("spawn","_etime")
		waitUntil {time >= _etime};
		__TRACE("spawn blacking out 1 sec before respawn")
		"xr_revtxt" cutText ["", "BLACK OUT", 1];
	};
};

if (xr_selfheals > 0) then {
	player removeAction (player getVariable "xr_selfh_ac_id");
};