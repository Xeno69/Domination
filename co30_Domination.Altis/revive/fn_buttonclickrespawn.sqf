// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","d_beam_target")
if (d_beam_target == "") exitWith {
	__TRACE("exit, beam target empty")
};

private _respawn_pos = [0, 0, 0];
private _respawn_target = nil;
__TRACE("black out")
"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_917", "BLACK OUT", 0.2];

player setVariable ["xr_hasusedmapclickspawn", true];

if (d_beam_target == "D_BASE_D") then {
	if (!d_tt_ver) then {
		_respawn_pos = markerPos "base_spawn_1";
	} else {
		_respawn_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
	};
	if (!d_carrier) then {
		_respawn_pos set [2, 0];
	} else {
		_respawn_pos set [2, (getPosASL D_FLAG_BASE) # 2];
	};
	d_player_in_base = true;
} else {
	if (d_beam_target == "D_SQL_D") then {
		if (leader (group player) != player && [leader (group player)] call d_fnc_iseligibletospawnnewunit) then {
			_respawn_target = leader (group player);
		} else {
			// are any squadmates alive and eligible as a spawn target?
			{
				if (_x != player && [_x] call d_fnc_iseligibletospawnnewunit) exitWith {
					_respawn_target = _x;
				};
			} forEach (units group player);
		};
		
		// failed to find a respawn target
		if (isNil "_respawn_target") exitWith {};
		
		_respawn_pos = [(vehicle _respawn_target) modelToWorldVisual [0, -8, 0], getPosASL _respawn_target] select (isNull objectParent _respawn_target);
		_respawn_pos set [2, _respawn_target distance (getPos _respawn_target)];
		if (d_with_ranked || {d_database_found}) then {
			[_respawn_target, 12] remoteExecCall ["d_fnc_addscore", 2];
		};
		if (!d_tt_ver) then {
			d_player_in_base = player inArea d_base_array;
		} else {
			d_player_in_base = player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)};
		};
	} else {
		private _uidx = d_add_resp_points_uni find d_beam_target;
		if (_uidx != -1) then {
			_respawn_pos = (d_additional_respawn_points # _uidx) # 1;
			if (surfaceIsWater _respawn_pos) then {
				_respawn_pos set [2, ((d_additional_respawn_points # _uidx) # 5) # 2];
			};
			d_player_in_base = false;
		} else {
			private _mrs = missionNamespace getVariable [d_beam_target, objNull];
			if (isNil "d_alt_map_pos") then {
				_respawn_pos = _mrs call d_fnc_posbehindvec;
				(boundingBoxReal _mrs) params ["_p1", "_p2"];
				private _maxHeight = abs ((_p2 # 2) - (_p1 # 2)) / 2;
				_respawn_pos set [2, (_mrs distance (getPos _mrs)) - _maxHeight];
			} else {
				_respawn_pos = d_alt_map_pos;
				_respawn_pos set [2, 0];
			};
			d_player_in_base = false;
		};
	};
};

if (!d_player_in_base && {!isNil {player getVariable "d_old_eng_can_repfuel"}}) then {
	d_eng_can_repfuel = false;
};
player setVariable ["d_old_eng_can_repfuel", nil];

__TRACE_1("","_respawn_pos")

sleep 1;
__TRACE("stopspect = true")
xr_stopspect = true;
player setVariable ["xr_plno3dd", true, true];
player setVariable ["xr_pluncon", false, true];
player setCaptive false;
sleep 0.5;

private _mhqobj = objNull;
if (d_beam_target != "D_BASE_D" && {d_beam_target != "D_SQL_D" && {!(d_beam_target in d_add_resp_points_uni)}}) then {
	private _rpnetts = _respawn_pos nearEntities ["All", 25];
	private _fidx = _rpnetts findIf {_x getVariable ["d_vec_type", ""] == "MHQ"};
	if (_fidx > -1) then {
		_mhqobj = _rpnetts # _fidx;
	};
};
[player, 105] remoteExecCall ["xr_fnc_handlenet"];
__TRACE_1("","_mhqobj")
if (!isNull _mhqobj) then {
	if !(_mhqobj isKindOf "Ship") then {
		private _newppos = _mhqobj call d_fnc_posbehindvec;
		(boundingBoxReal _mhqobj) params ["_p1", "_p2"];
		private _maxHeight = abs ((_p2 # 2) - (_p1 # 2)) / 2;
		_newppos set [2, (_mhqobj distance (getPos _mhqobj)) - _maxHeight];
		player setDir (getDirVisual _mhqobj);
		player setVehiclePosition [_newppos, [], 0, "NONE"]; // CAN_COLLIDE ?
	} else {
		player moveInCargo _mhqobj;
	};
	{player reveal _x} forEach ((player nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 30]) + (player nearSupplies 30));
	if ((player nearEntities  ["ReammoBox_F", 30]) isNotEqualTo []) then {
		call d_fnc_retrieve_layoutgear;
	};
} else {
	private _domovevec = false;
	if (d_beam_target != "D_SQL_D")	then {
		call d_fnc_retrieve_layoutgear;
	} else {
		private _emptycargo = [0, (vehicle _respawn_target) emptyPositions "cargo"] select (!isNull objectParent _respawn_target);
		if (_emptycargo > 0) then {
			_domovevec = true;
		};
	};
	if (!_domovevec) then {
		player allowDamage false;
		if (surfaceIsWater _respawn_pos) then {
			__TRACE("is water")
			player setPosASL _respawn_pos;
		} else {
			if (d_beam_target == "D_BASE_D") then {
				player setVehiclePosition [_respawn_pos, [], 2, "NONE"];
				if (d_vn) then {
					if (markerPos "base_spawn_1" distance2D [15712, 7157.78, 0] < 10) then {
						private _pasl = getPosASL player;
						_pasl set [2, 14.981];
						player setPosASL _pasl;
					};
				};
			} else {
				player setVehiclePosition [_respawn_pos, [], 0, "NONE"];
			};
		};
		player allowDamage true;
	} else {
		player moveInCargo (vehicle _respawn_target);
	};
};

player setVariable ["xr_plno3dd", nil, true];

d_last_beam_target = d_beam_target;
d_beam_target = "";
player setDamage 0;
__TRACE("MapClickRespawn, black in")
"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_918", "BLACK IN", 6];
if (xr_max_lives != -1) then {
	0 spawn {
		scriptName "spawn_buttonclickrespawn";
		sleep 7;
		if (xr_max_lives != -1) then {
			hintSilent format [localize "STR_DOM_MISSIONSTRING_933", player getVariable "xr_lives"];
		};
		if (d_with_ai && {alive player && {!(player getVariable "xr_pluncon")}}) then {[] spawn d_fnc_moveai};
	};
};

if (d_database_found) then {
	player setVariable ["d_move_opos", getPosWorld player];
	player setVariable ["d_move_stop", nil];
};

0 spawn {
	scriptName "spawn_buttonclickrespawn2";
	if (!d_ifa3lite && {d_without_nvg == 1 && {player call d_fnc_hasnvgoggles && {sunOrMoon < 0.99 || {player getVariable ["d_currentvisionmode", 0] == 1}}}}) then {
		player action ["NVGoggles", player];
	};
};
__TRACE("MapClickRespawn done")