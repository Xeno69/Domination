// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_player_stuff.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")
d_player_autokick_time = _this # 0;

if (d_WithRevive == 0 && {(_this # 8) == -1 && {xr_max_lives != -1}}) exitWith {
	0 spawn {
		scriptName "spawn_playerstuffparking";
		waitUntil {sleep 0.1; !d_still_in_intro};
		__TRACE("player_stuff, calling park_player")
		player setVariable ["xr_lives", -1, true];
		xr_pl_no_lifes = true;
		[false] spawn xr_fnc_park_player;
	};
};

#ifdef __TT__
_this spawn {
	waitUntil {sleep 0.1; !d_still_in_intro};
	if (!isNil {player getVariable "d_no_side_change"}) then {
		private _rtime = serverTime - ((_this # 9) # 1);
		[3, profileName, round (30 - (_rtime / 60))] remoteExecCall ["d_fnc_csidechat", -2];
		0 spawn {
			scriptName "spawn_endmissionloser";
			sleep 1.5;
			endMission "LOSER";
		};
	} else {
		private _prev_side = _this # 5;
		if (_prev_side != sideUnknown && {d_player_side != _prev_side}) then {
			[4, profileName, _prev_side, d_player_side] remoteExecCall ["d_fnc_csidechat", -2];
		};
	};
};
#endif

private _lo = _this # 11;
__TRACE_1("","_lo")
if (_lo # 0 isNotEqualTo []) then {
	_lo spawn {
		scriptName "spawn_player_stuff";
		waitUntil {!isNil "d_player_side"};
		if (_this # 1 == d_player_side) then {
			player setUnitLoadout [_this # 0, false];
			call d_fnc_save_respawngear;
			call d_fnc_save_layoutgear;
			call d_fnc_store_rwitems;
			call d_fnc_storepitems;
		};
	};
};

/*if (_this # 7 >= d_maxnum_tks_forkick) then {
	0 spawn {
		scriptName "spawn_endmissionloser2";
		hint "You will be kicked back to the lobby because of too much teamkilling!!!!";
		titleText "You will be kicked back to the lobby because of too much teamkilling!!!!";
		sleep 5;
		endMission "LOSER";
		forceEnd;
	};
};*/

d_player_jescape = _this # 3;

if (d_player_jescape > 10) then {
	endMission "LOSER";
	forceEnd;
};

if (_this # 13 > 0) then {
	_this spawn {
		scriptname "spawn plstuffjail";
		waitUntil {sleep 0.2; !d_still_in_intro};
		[_this # 7, _this # 13] spawn d_fnc_jail;
	};
};
