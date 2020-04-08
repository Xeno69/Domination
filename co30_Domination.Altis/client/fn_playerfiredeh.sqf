// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerfiredeh.sqf"
#include "..\x_setup.sqf"

__TRACE("fn_playerfiredeh")

__TRACE_1("","_this")

private _fnc_nearmhq = {
	private _ets = player nearEntities [["Air", "Car", "Tank"], 9];
	if (_ets isEqualTo []) exitWith {false};
	(_ets findIf {_x getVariable ["d_vec_type", ""] == "MHQ"}) != -1
};

if ((_this # 1) == "Put" && {(d_player_in_air && {animationState player == "halofreefall_non"}) || {call _fnc_nearmhq}}) then {
	deleteVehicle (_this select 6);
	player addMagazine (_this select 5);
	systemChat (localize "STR_DOM_MISSIONSTRING_2006");
} else {
	if (d_player_in_base && {!d_pisadminp}) then {
#ifndef __TT__
		if (player inArea d_base_array) then {
#else
		if (player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}) then {
#endif
			__TRACE("Player in Base")
			if ((_this # 1) == "Put") then {
			//if ([_this # 4, 0] call d_fnc_checkammo) then {
				if (count _this > 6) then {
					deleteVehicle (_this select 6);
				};
				[player, d_name_pl, 1] remoteExecCall ["d_fnc_RptMsgBS", 2];
			} else {
				if (!d_there_are_enemies_atbase && {!d_enemies_near_base && {!([_this # 4, 1] call d_fnc_checkammo)}}) then {
					private _num = (player getVariable "d_p_f_b") + 1;
					player setVariable ["d_p_f_b", _num];
					if !(player inArea [d_flag_base, 25, 25, 0, false]) then {
						if (d_player_kick_shootingbase != 1000) then {
							if (_num >= d_player_kick_shootingbase) then {
								if (isNil {player getVariable "d_pfbk_announced"}) then {
									[player, d_name_pl, 0] remoteExecCall ["d_fnc_RptMsgBS", 2];
									player setVariable ["d_pfbk_announced", true];
								};
							} else {
								hint (localize "STR_DOM_MISSIONSTRING_537");
							};
						} else {
							if (_num >= d_player_kick_shootingbase) then {
								[player, d_name_pl, 0] remoteExecCall ["d_fnc_RptMsgBS", 2];
								player setVariable ["d_p_f_b", 0];
							};
						};
					};
				};
			};
		} else {
			player setVariable ["d_p_f_b", 0];
		};
	} else {
		if (count _this > 6 && {(_this # 1) == "Put"}) exitWith {
		//if (count _this > 6 && {[_this # 4, 0] call d_fnc_checkammo}) exitWith {
			if !((player nearEntities  ["ReammoBox_F", 30]) isEqualTo []) then {
				deleteVehicle (_this select 6);
			};
		};
		if (d_with_ace) exitWith {};
		if (d_launcher_cooldown > 0 && {isNull (_this select 7)}) then {
			__TRACE("7 is null")
			if (getText (configFile>>"CfgAmmo">>(_this select 4)>>"simulation") == "laserDesignate") exitWith {
				__TRACE("ammo is laserDesignate")
			};
			if (getNumber (configFile>>"CfgAmmo">>(_this select 4)>>"manualControl") > 0 || {getNumber (configFile>>"CfgAmmo">>(_this select 4)>>"weaponLockSystem") > 0}) then {
				__TRACE("has manual control")
				//private _w = player getVariable ("d_" + (_this # 5));
				private _w = player getVariable "d_rcoold";
				__TRACE_1("1","_w")
				if (!isNil "_w") then {
					if (time < _w) then {
						deleteVehicle (_this # 6);
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
					_w = time + d_launcher_cooldown;
					__TRACE_1("2","_w")
					//player setVariable ["d_" + (_this # 5), _w];
					player setVariable ["d_rcoold", _w];
				};
			};
		};
	};
};