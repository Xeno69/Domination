// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

#define __spectdlg1005 ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1005)
#define __spectdlg1006 ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006)

if (time >= xr_u_nextcrytime) then {
	playSound3D [format ["%1%2%3", (xr_moansoundsar # xr_plsayer) # 0, xr_voicetype, (xr_moansoundsar # 3) # (floor (random (count (xr_moansoundsar # 3))))], player, false, getPosASL player, 1, 1, 100];
	//playSound3D [((xr_moansoundsar # xr_plsayer) # 0) + xr_voicetype + ((xr_moansoundsar # 3) # (floor (random (count (xr_moansoundsar # 3))))), player, false, getPosASL player, 1, 1, 100];
	xr_u_nextcrytime = time + 15 + (random 15);
};

private _tt = round ((player getVariable "xr_unconendtime") - time);
if (_tt != xr_u_ott) then {
	__spectdlg1005 ctrlSetText str _tt;
	xr_u_ott = _tt;
};
if (xr_near_player_dist_respawn && {!xr_respawn_available && {xr_u_dcounter > 10 && {time > xr_u_xxstarttime}}}) then {
	private _nearunit = objNull;
	d_allplayers findIf {
		_ret = _x != player && {!(_x getVariable ["xr_pluncon", false])};
		if (_ret) then {
			_nearunit = _x;
		};
		_ret
	};
	if (isNull _nearunit) then {
		xr_respawn_available = true;
		__spectdlg1006 ctrlSetText (localize "STR_DOM_MISSIONSTRING_922");
		__spectdlg1006 ctrlSetTextColor [1,1,0,1];
		__spectdlg1006 ctrlCommit 0;
	};
	xr_u_dcounter = 0;
} else {
	xr_u_dcounter = xr_u_dcounter + 1;
	if (xr_u_dcounter > 1000) then {xr_u_dcounter = 0};
};
if (xr_u_respawn != -1 && {!xr_respawn_available && {time >= xr_u_respawn}}) then {
	__spectdlg1006 ctrlSetText (localize "STR_DOM_MISSIONSTRING_922");
	__spectdlg1006 ctrlSetTextColor [1,1,0,1];
	__spectdlg1006 ctrlCommit 0;
	xr_respawn_available = true;
};
if (_tt <= 0) exitWith {
	//__TRACE("_tt < =0, exit")
	if (xr_with_marker) then {
		xr_strpldead remoteExecCall ["deleteMarker", 2];
	};
	player remoteExecCall ["xr_fnc_removeActions", d_own_sides_o];
	xr_u_remactions = true;
	//__TRACE("_tt <= 0, black out")
	"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_932", "BLACK OUT", 1];
	0 spawn {
		scriptName "spawn xr uncon oneframe";
		sleep 1;
		closeDialog 0;
		//__TRACE("_tt stopspect = true")
		xr_stopspect = true;
		sleep 1.3;
		//player setPos (markerPos "base_spawn_1");
		player setVehiclePosition [markerPos "base_spawn_1", [], 0, "NONE"]; // CAN_COLLIDE ?
		d_player_in_base = true;
		player setDamage 0;
		[player, 105] remoteExecCall ["xr_fnc_handlenet"];
		call d_fnc_retrieve_layoutgear;
		if (d_database_found) then {
			player setVariable ["d_move_opos", getPosWorld player];
			player setVariable ["d_move_stop", nil];
		};
		sleep 1.3;
		//__TRACE("time over black in")
		"xr_revtxt" cutText ["","BLACK IN", 2];
		xr_pl_has_pos_changed = false;
		player setVariable ["xr_pluncon", false, true];
		if (xr_max_lives != -1) then {
			0 spawn {
				scriptName "spawn xr uncon oneframe2";
				sleep 3;
				hintSilent format [localize "STR_DOM_MISSIONSTRING_933", player getVariable "xr_lives"];
			};
		};
		xr_u_pl_died = true;
	};
	xr_u_doend_of = true;
};
if (time > xr_next_pl_near_check) then {
	true call xr_fnc_nearplayercheck;
};
if (xr_with_marker) then {
	// adjust marker if uncon player gets moved. Can happen when he gets dragged/carried or when a apc hits him (flying miles away)
	private _newplposm = getPosWorld player;
	if (_newplposm distance2D xr_u_plposm > 5) then {
		//__TRACE_2("","xr_u_plposm","_newplposm")
		xr_u_plposm = _newplposm;
		xr_strpldead setMarkerPos _newplposm;
	};
};
