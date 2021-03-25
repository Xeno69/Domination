// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_uncon.sqf"
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

disableSerialization;
enableRadio false;
if (d_earplugs_fitted) then {
	1 fadeSound 0.2;
} else {
	1 fadeSound 1;
};
{
	player remoteExecCall ["xr_fnc_addActions", _x];
} forEach d_own_sides_o;
if (!captive player) then {
	player setCaptive true;
};

closeDialog 0;
xr_respawn_available = false;
private _curtime = time;
player setVariable ["xr_unconendtime", _curtime + xr_lifetime];
player setVariable ["xr_hasusedmapclickspawn", false];
xr_u_ott = -1;
xr_u_respawn = if (xr_respawn_available_after != -1) then {
	_curtime + xr_respawn_available_after
} else {
	xr_respawn_available = true; -1
};

__TRACE_2("","_curtime","xr_u_respawn")

if (xr_spectating) then {
	[true] spawn xr_fnc_spectating;
} else {
	[true] spawn xr_fnc_no_spectating;
};

xr_u_pl_died = false;
xr_u_dcounter = 0;
__TRACE("starting main loop")
xr_u_remactions = false;
xr_u_nextcrytime = time + 15 + (random 15);
if (xr_with_marker) then {
	__TRACE("creating marker")
	[player, getPosWorld player] remoteExecCall ["xr_fnc_addmarker", 2];
};
xr_u_xxstarttime = time + 40;
xr_u_plposm = getPosWorld player;
__TRACE_1("","xr_u_plposm")

xr_u_doend_of = false;

false call xr_fnc_nearplayercheck;

xr_uncon_units pushBack player;

d_uncon_finally_over = false;

__TRACE("starting main uncon loop")

["dom_xr_uncon_of", {
	if (!xr_u_doend_of && {alive player && {player getVariable "xr_pluncon"}}) then {
		call xr_fnc_uncon_oneframe;
	} else {
		["dom_xr_uncon_of"] call d_fnc_eachframeremove;

		xr_u_dcounter = nil;
		xr_u_xxstarttime = nil;
		xr_u_plposm = nil;
		xr_u_ott = nil;
		xr_u_respawn = nil;
		xr_u_nextcrytime = nil;
		xr_u_doend_of = nil;

		xr_uncon_units = xr_uncon_units - [player, objNull];

		if (!d_player_in_base && {!isNil {player getVariable "d_old_eng_can_repfuel"}}) then {
			d_eng_can_repfuel = false;
		};
		player setVariable ["d_old_eng_can_repfuel", nil];
		
		if (!isNull (attachedTo player)) then {
			detach player;
		};

		0 spawn {
			scriptname "spawn 1uncon";
			if (!xr_u_remactions) then {
				__TRACE("xr_u_remactions")
				{
					player remoteExecCall ["xr_fnc_removeActions", _x];
				} forEach d_own_sides_o;
			};
			if (xr_with_marker) then {
				__TRACE("del marker")
				xr_strpldead remoteExecCall ["deleteMarker", 2];
			};
			__TRACE("set capture false player")
			player setCaptive false;
			enableRadio true;
			__TRACE_1("","xr_u_pl_died")
			if (!xr_u_pl_died) then {
				if (!(player getVariable "xr_hasusedmapclickspawn")) then {
					__TRACE("player alive and lives left, black out")
					"xr_revtxt" cutText ["","BLACK OUT", 1];
				};
				sleep 1;
				if (!(player getVariable "xr_hasusedmapclickspawn")) then {
					__TRACE("Sending 102")
					[player, 102] remoteExecCall ["xr_fnc_handlenet"];
				};
				player setDamage 0;
				d_x_loop_end = true;
				closeDialog 0;
				if (!xr_stopspect) then {
					__TRACE("stopspect = true")
					xr_stopspect = true;
				};
				if (!(player getVariable "xr_hasusedmapclickspawn")) then {
					__TRACE("player alive and lives left, black in")
					"xr_revtxt" cutText ["","BLACK IN", 6];
					if (xr_max_lives != -1) then {
						0 spawn {
							scriptname "spawn 2uncon";
							sleep 7;
							hintSilent format [localize "STR_DOM_MISSIONSTRING_933", player getVariable "xr_lives"];
						};
					};
				};
			};
			__TRACE("after if !u_pl_died")
			xr_u_pl_died = nil;
			xr_near_players = nil;
			player setFatigue 0;
			bis_fnc_feedback_burningTimer = 0;
			call xr_fnc_joingr;
			bis_fnc_feedback_allowPP = true;
			d_DomCommandingMenuBlocked = false;
			d_commandingMenuIniting = false;
			showCommandingMenu "";
			if (d_with_ai && {player != leader (group player) && {d_current_ai_units isNotEqualTo []}}) then {
				d_current_ai_units = [];
				d_current_ai_num = 0;
			};
			d_uncon_finally_over = true;
		};
		{
			player remoteExecCall ["xr_fnc_announcenearrem", _x];
		} forEach (d_allplayers select {alive _x && {_x != player && {!(_x getVariable ["xr_pluncon", false]) && {_x distance2D player < 100}}}});
		__TRACE("uncon ended, one frame removed")
	};
}, 0.02] call d_fnc_eachframeadd;
