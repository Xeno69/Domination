// by Xeno
#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("fn_playerfiredeh")

__TRACE_1("","_this")

private _fnc_nearmhq = {
	private _ets = player nearEntities [["Air", "Car", "Tank"], 15];
	if (_ets isEqualTo []) exitWith {
		false
	};
	private _mhqnear = [(_ets findIf {_x getVariable ["d_vec_type", ""] == "MHQ"}) != -1, (_ets # 0) getVariable ["d_vec_type", ""] == "MHQ"] select (count _ets == 1);
	if (!_mhqnear) exitWith {
		false
	};	
	_ets = player nearEntities ["ReammoBox_F", 25];
	if (_ets isEqualTo [] || {(_ets # 0) getVariable ["d_nocheck", false]}) exitWith {false};
	true
};

private _do_exit = false;

if ((_this # 6) isKindOf "BulletCore" || {(_this # 6) isKindOf "ShotgunCore"}) then {
	d_p_rounds = d_p_rounds + 1;
	_do_exit = true;
};

if (!_do_exit && {(_this # 1) isEqualTo "Put" && {(getUnitFreefallInfo player) # 0 || {call _fnc_nearmhq}}}) exitWith {
	deleteVehicle (_this # 6);
	player addMagazine (_this # 5);
	systemChat (localize "STR_DOM_MISSIONSTRING_2006");
	__TRACE("Put ended")
};

if (!_do_exit && {(_this # 4) isKindOf "Chemlight_base"}) exitWith {
	__TRACE("is chemlight")
	(_this # 6) remoteExecCall ["d_fnc_ad_c_ar", 2];
};

 if (d_player_in_base && {!d_pisadminp}) then {
#ifndef __TT__
	if (player inArea d_base_array) then {
#else
	if (player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}) then {
#endif
		__TRACE("Player in Base")
		call {
			if ((_this # 1) isEqualTo "Put") exitWith {
				__TRACE("Put")
				if (count _this > 6) then {
					deleteVehicle (_this # 6);
				};
				[player, d_name_pl, 1] remoteExecCall ["d_fnc_RptMsgBS", 2];
				_do_exit = true;
			};
			if ((_this # 1) isEqualTo "Throw" && {player inArea [d_flag_base, 70, 70, 0, false]}) exitWith {
				__TRACE("Throw")
				if (count _this > 6) then {
					deleteVehicle (_this # 6);
				};
				[player, d_name_pl, 2] remoteExecCall ["d_fnc_RptMsgBS", 2];
				_do_exit = true;
			};
			if (!d_there_are_enemies_atbase && {!d_enemies_near_base && {!(call d_fnc_checkammo)}}) exitWith {
				private _num = (player getVariable "d_p_f_b") + 1;
				player setVariable ["d_p_f_b", _num];
				_do_exit = true;
				_num spawn {
					if !(player inArea [d_flag_base, 25, 25, 0, false]) then {
						if (d_player_kick_shootingbase != 1000) then {
							if (_this >= d_player_kick_shootingbase) then {
								if (isNil {player getVariable "d_pfbk_announced"}) then {
									[player, d_name_pl, 0] remoteExecCall ["d_fnc_RptMsgBS", 2];
									player setVariable ["d_pfbk_announced", true];
								};
							} else {
								hint (localize "STR_DOM_MISSIONSTRING_537");
							};
						} else {
							if (_this >= d_player_kick_shootingbase) then {
								[player, d_name_pl, 0] remoteExecCall ["d_fnc_RptMsgBS", 2];
								player setVariable ["d_p_f_b", 0];
							};
						};
					};
				};
			};
		};
	} else {
		player setVariable ["d_p_f_b", 0];
	};
};
if (_do_exit || {d_with_ace}) exitWith {
	__TRACE("Do Exit")
};
if (d_launcher_cooldown > 0 && {isNull (_this # 7) && {(_this # 1) isKindOf ["LauncherCore", configFile >> "CfgWeapons"] && {getText (configFile>>"CfgAmmo">>(_this # 4)>>"simulation") in ["shotRocket", "shotMissile"]}}}) then {
	__TRACE("7 is null")
	if (getText (configFile>>"CfgAmmo">>(_this # 4)>>"simulation") == "shotMissile") exitWith {
		if (getNumber (configFile>>"CfgAmmo">>(_this # 4)>>"manualControl") > 0 || {getNumber (configFile>>"CfgAmmo">>(_this # 4)>>"weaponLockSystem") > 0}) then {
			__TRACE("has manual control")
			private _w = player getVariable "d_rcoold";
			__TRACE_1("1","_w")
			if (!isNil "_w") then {
				if (time < _w) then {
					(_this # 6) remoteExecCall ["d_fnc_delproj"];
					//deleteVehicle (_this # 6);
					__TRACE("projectile deleted")
					private _ul =+ getUnitLoadout player;
					(_ul # 1) set [4, [_this # 5, 1]];
					player setUnitLoadout _ul;
					__TRACE("Magazine added")
					private _str = format [localize "STR_DOM_MISSIONSTRING_1969", [_this # 1, "CfgWeapons"] call d_fnc_getdisplayname, round (_w - time)];
					hintSilent parseText format ["<t color='#ff0000' size='1.5' align='center'>%1</t>", _str];
					systemChat _str;
				};
			} else {
				player setVariable ["d_rcoold", time + d_launcher_cooldown];
			};
		};
	__TRACE("Running through")
	};
	if ((player nearEntities ["ReammoBox_F", 25]) isNotEqualTo []) then {
		private _w = player getVariable "d_rcoold2";
		__TRACE_1("1","_w")
		if (!isNil "_w") then {
			if (time < _w) then {
				_mmm = typeOf (_this # 6);
				__TRACE_1("","_mmm")
				(_this # 6) remoteExecCall ["d_fnc_delproj"];
				//deleteVehicle (_this # 6);
				__TRACE("projectile deleted")
				private _ul =+ getUnitLoadout player;
				(_ul # 1) set [4, [_this # 5, 1]];
				player setUnitLoadout _ul;
				__TRACE("Magazine added")
				private _str = format [localize "STR_DOM_MISSIONSTRING_1969a", [_this # 1, "CfgWeapons"] call d_fnc_getdisplayname, round (_w - time)];
				hintSilent parseText format ["<t color='#ff0000' size='1.5' align='center'>%1</t>", _str];
				systemChat _str;
			};
		} else {
			player setVariable ["d_rcoold2", time + d_launcher_cooldown];
		};
	};
};
