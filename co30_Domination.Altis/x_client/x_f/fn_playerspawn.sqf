// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerspawn.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_rtype"];
__TRACE_1("","_rtype")

if (_rtype == 0) then { // player died
	call d_fnc_save_respawngear;
	player setVariable ["d_currentvisionmode", currentVisionMode player];
	if (visibleMap) then {
		openMap false;
	};
	if (d_WithRevive == 1) then {
		player setVariable ["d_is_leader", [objNull, group player] select (player == leader (group player))];
		setPlayerRespawnTime 20;
	};
	if (!isNil {player getVariable "d_ld_action"}) then {
		player removeAction (player getVariable "d_ld_action");
	};
	if (!isNil {player getVariable "d_ccas_action"}) then {
		player removeAction (player getVariable "d_ccas_action");
	};
	if (player getVariable ["d_has_ffunc_aid", -9999] != -9999) then {
		player removeAction (player getVariable "d_has_ffunc_aid");
		player setVariable ["d_has_ffunc_aid", -9999];
	};
	if (player getVariable ["d_has_sfunc_aid", false]) then {
		if (d_actionID2 != -9999) then {
			[d_orig_sfunc_obj, d_actionID2] call bis_fnc_holdActionRemove;
			d_actionID2 = -9999;
		};
		player setVariable ["d_has_sfunc_aid", false];
	};
} else { // _rtype = 1, player has respawned
	d_commandingMenuIniting = false;
	d_DomCommandingMenuBlocked = false;
#ifdef __CARRIER__
	if (d_WithRevive == 1) then {
		private _resp_pos = markerPos "base_spawn_1";
		_resp_pos set [2, (getPosASL d_FLAG_BASE) # 2];
		player setPosASL _resp_pos;
	};
#endif
	showCommandingMenu "";
	__TRACE("adding player handleDamage eventhandler non ace")
	if (!d_with_ace) then {
		player addEventHandler ["handleDamage", {_this call xr_fnc_ClientHD}];
	};
	xr_phd_invulnerable = true;
	player setFatigue 0;
	if (d_weapon_respawn) then {
		if (d_WithRevive == 1) then {
			call d_fnc_retrieve_layoutgear;
		} else {
			call d_fnc_retrieve_respawngear;
		};
	};
	if (player getVariable ["d_has_gps", false]) then {
		player linkItem "ItemGPS";
		player setVariable ["d_has_gps", false];
	};
	// "RadialBlurr" effect adjustment still needed in A3? - Well, they don't do any harm so they stay
	"RadialBlur" ppEffectAdjust [0.0, 0.0, 0.0, 0.0];
	"RadialBlur" ppEffectCommit 0;
	"RadialBlur" ppEffectEnable false;

	if (d_WithRevive == 1) then {
		deleteVehicle ((_this # 1) # 1);
	};
	
#ifndef __IFA3LITE__
	if (d_without_nvg == 1 && {player call d_fnc_hasnvgoggles && {sunOrMoon < 0.99 || {player getVariable ["d_currentvisionmode", 0] == 1}}}) then {
		player action ["NVGoggles",player];
	};
#endif

	if !(player getVariable ["xr_isdead", false]) then {
		0 spawn {
			scriptName "spawn_playerspawn_vul";
			waitUntil {!dialog};
			sleep 5;
			xr_phd_invulnerable = false;
		};
	};
	if (d_WithRevive == 1 && {!isNull (player getVariable "d_is_leader")}) then {
		//[player getVariable "d_is_leader", player] remoteExecCall ["selectLeader", groupOwner (player getVariable "d_is_leader")];
		[player getVariable "d_is_leader", player] remoteExecCall ["xr_fnc_selleader", player getVariable "d_is_leader"];
	};
	private _clattachedobj = player getVariable ["d_p_clattachedobj", objNull];
	if (!isNull _clattachedobj) then {
		_clattachedobj attachTo [player, [0, -0.03, 0.07], "LeftShoulder"]; 
	};
	if (!d_no_ai || {d_string_player in d_can_use_artillery || {d_string_player in d_can_mark_artillery}}) then {
#ifndef __IFA3LITE__
		player setVariable ["d_ld_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1520"], {_this call d_fnc_mark_artillery} , 0, 9, true, false, "", "alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
#else
		player setVariable ["d_ld_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1520"], {_this call d_fnc_mark_artillery} , 0, 9, true, false, "", "alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}"]];
#endif
	};
	if (!d_no_ai || {d_string_player in d_can_call_cas}) then {
#ifndef __TT__
		if (!d_ifa3lite) then {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}}"]];
		} else {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!(screenToWorld [0.5, 0.5] inArea d_base_array) && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}}}"]];
		};
#else
	if (d_player_side == blufor) then {
		player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available_w && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}}"]];
	} else {
		player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available_e && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}}"]];
	};
#endif
	};
	if (d_enablefatigue == 0) then {
		player enableFatigue false;
	};
	
	if (d_enablesway == 0) then {
		player setCustomAimCoef 0.1;
	};
	player enableAttack false;
	
	d_player_in_vec = false; // just to be sure
	
	if (!isNil "d_heli_kh_ro") then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", d_heli_kh_ro];
		d_heli_kh_ro = nil;
	};
	if (!isNil {player getVariable "d_recdbusy"}) then {
		player setVariable ["d_recdbusy", false];
	};
	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0.0;
	
	player setFatigue 0;
	player setBleedingRemaining 0;
	
	/*0 spawn {
		sleep (1 + random 1);
		private _np = player getVariable ["d_plname", ""];
		if (_np isEqualTo "" || {_np isEqualTo "Error: No unit"}) then {
			_np = profileName splitString """'" joinString "";
			if (_np isEqualTo "Error: No unit") then {
				_np = (name player) splitString """'" joinString "";
			};
			player setVariable ["d_plname", _np, true];
			d_name_pl = _np;
		};
	};*/
	
	player disableConversation true;
	if (!d_with_ai) then {
		enableSentences false;
	};
	[player , "NoVoice"] remoteExecCall ["setSpeaker", -2, false];
	
#ifndef __TT__
	0 spawn {
		sleep 1;
		[player] remoteExecCall ["d_fnc_addceo", 2];
	};
#endif
};