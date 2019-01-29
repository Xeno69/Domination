// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerfiredeh.sqf"
#include "..\..\x_setup.sqf"

__TRACE("fn_playerfiredeh")

if (d_player_in_air && {animationState player == "halofreefall_non" && {(_this select 4) isKindOf "TimeBombCore"}}) then {
	deleteVehicle (_this select 6);
	player addMagazine (_this select 5);
} else {
	if (d_player_in_base && {!d_pisadminp}) then {
#ifndef __TT__
		if (player inArea d_base_array) then {
#else
		if (player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}) then {
#endif
			__TRACE("Player in Base")
			private _ta = _this select 4;
			if ([_ta, 0] call d_fnc_checkammo) then {
				if (count _this > 6) then {
					deleteVehicle (_this select 6);
				};
				[player, d_name_pl, 1] remoteExecCall ["d_fnc_RptMsgBS", 2];
			} else {
				if (!d_there_are_enemies_atbase && {!d_enemies_near_base && {!([_ta, 1] call d_fnc_checkammo)}}) then {
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
	};
};