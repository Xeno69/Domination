// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_beam_target isEqualTo "" || {d_x_loop_end}) exitWith {};

d_x_loop_end = true;

if (!isNull objectParent player) then {unassignVehicle player};

params ["_wone"];

disableSerialization;
private _disp = [uiNamespace getVariable "xr_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);
if (_wone == 0) then {
	(_disp displayCtrl 100102) ctrlEnable false;
	(_disp displayCtrl 100107) ctrlEnable false;
	(_disp displayCtrl 100108) ctrlEnable false;
	(_disp displayCtrl 100109) ctrlEnable false;
} else {
	(_disp displayCtrl 3000) ctrlShow false;
};

private _global_pos = [];
private _global_dir = 180;
private _typepos = 0;
private _mrsv = objNull;
private _respawn_target = nil;

if (d_beam_target == "D_BASE_D") then {
#ifndef __TT__
	_global_pos = markerPos "base_spawn_1";
#else
	_global_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
	if (!d_carrier) then {
		_global_pos set [2, 0];
	} else {
		_global_pos set [2, (getPosASL d_FLAG_BASE) # 2];
	};
	d_player_in_base = true;
} else {
	if (d_beam_target == "D_SQL_D") then {
		__TRACE_1("DSQLD","d_beam_target")
		if (leader (group player) != player && {leader (group player) call d_fnc_iseligibletospawnnewunit}) then {
			_respawn_target = leader (group player);
			__TRACE_1("1","_respawn_target")
		} else {
			// are any squadmates alive and eligible as a spawn target?
			{
				if (_x != player && {[_x] call d_fnc_iseligibletospawnnewunit}) exitWith {
					_respawn_target = _x;
					__TRACE_1("2","_respawn_target")
				};
			} forEach (units player);
		};
		
		__TRACE_1("3","_respawn_target")
		// failed to find a respawn target
		if (isNil "_respawn_target") exitWith {};
		
		private _emptycargo = [0, (vehicle _respawn_target) emptyPositions "cargo"] select (!isNull objectParent _respawn_target);
		if (_emptycargo == 0) then {
			_global_pos = [(vehicle _respawn_target) modelToWorldVisual [0, -8, 0], getPosASLVisual _respawn_target] select (isNull objectParent _respawn_target);
			_global_pos set [2, _respawn_target distance (getPos _respawn_target)];
			_global_dir = getDirVisual _respawn_target;
			_typepos = 1;
		} else {
			_typepos = 2;
		};
		if (_global_pos distance2D [0, 0, 0] >= 60) then {
			if (d_with_ranked || {d_database_found}) then {
				[_respawn_target, 12] remoteExecCall ["d_fnc_addscore", 2];
			};
#ifndef __TT__
			d_player_in_base = player inArea d_base_array;
#else
			d_player_in_base = player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)};
#endif
		};
	} else {
		private _uidx = d_add_resp_points_uni find d_beam_target;
		__TRACE_1("","_uidx")
		if (_uidx != -1) then {
			_global_pos = (d_additional_respawn_points # _uidx) # 1;
			if (surfaceIsWater _global_pos) then {
				_global_pos set [2, ((d_additional_respawn_points # _uidx) # 5) # 2];
			};
			__TRACE_1("","_global_pos")
			_global_dir = 0;
			d_player_in_base = false;
		} else {
			private _mrs = missionNamespace getVariable [d_beam_target, objNull];
			if (alive _mrs) then {
				if !(_mrs isKindOf "Ship") then {
					if (isNil "d_alt_map_pos") then {
						_global_pos = _mrs call d_fnc_posbehindvec;
						__TRACE_1("1","_global_pos")
						(boundingBoxReal _mrs) params ["_p1", "_p2"];
						private _maxHeight = abs ((_p2 # 2) - (_p1 # 2)) / 2;
						__TRACE_1("","_maxHeight")
						_global_pos set [2, (_mrs distance (getPos _mrs)) - _maxHeight];
					} else {
						_global_pos = d_alt_map_pos;
						_global_pos set [2, 0];
					};
					__TRACE_1("2","_global_pos")
					_global_dir = getDirVisual _mrs;
					_typepos = 1;
				} else {
					_typepos = 3;
					_mrsv = _mrs;
				};
				d_player_in_base = false;
			} else {
#ifndef __TT__
				_global_pos = markerPos "base_spawn_1";
#else
				_global_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
				if (!d_carrier) then {
					_global_pos set [2, 0];
				} else {
					_global_pos set [2, (getPosASL d_FLAG_BASE) # 2];
				};
				d_player_in_base = true;
			};
		};
	};
};

d_last_beam_target = d_beam_target;
d_beam_target = "";

if (d_database_found) then {
	player setVariable ["d_move_stop", getPosWorld player];
	call d_fnc_updatemove;
};

if (_global_pos distance2D [0, 0, 0] < 60) then {
#ifndef __TT__
	_global_pos = markerPos "base_spawn_1";
#else
	_global_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
	if (!d_carrier) then {
		_global_pos set [2, 0];
	} else {
		_global_pos set [2, (getPosASL D_FLAG_BASE) # 2];
	};
	d_player_in_base = true;
};

if (_typepos == 1) then {
	player setDir _global_dir;
	player setVehiclePosition [_global_pos, [], 0, "NONE"]; // CAN_COLLIDE ?
} else {
	if (_typepos == 0) then {
		player setDir _global_dir;
		if (!surfaceIsWater _global_pos) then {
			player setVehiclePosition [_global_pos, [], 0, "NONE"]; // CAN_COLLIDE ?
			if (d_vn) then {
				if (markerPos "base_spawn_1" distance2D [15712, 7157.78, 0] < 10) then {
					private _pasl = getPosASL player;
					_pasl set [2, 14.981];
					player setPosASL _pasl;
				};
			};
		} else {
			player setPosASL _global_pos;
		};
	} else {
		if (_typepos == 2) then {
			player moveInCargo (vehicle _respawn_target);
		} else {
			if (_typepos == 3) then {
				player moveInCargo _mrsv;
			};
		};
	};
};

if (d_database_found) then {
	player setVariable ["d_move_opos", getPosWorld player];
	player setVariable ["d_move_stop", nil];
};

[_wone, _typepos] spawn {
	scriptName "spawn_beam_tele";
	params ["_wone", "_typepos"];
	sleep 2;
	if (_wone == 0) then {
		if (d_teleport_dialog_open) then {closeDialog 0};
		titleText ["", "BLACK IN"];
	};

	{player reveal _x} forEach ((player nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank", "Ship"], 30]) + (player nearSupplies 30));

	if (d_with_ai && {d_player_canu && {_typepos != 2}}) then {[] spawn d_fnc_moveai};
};