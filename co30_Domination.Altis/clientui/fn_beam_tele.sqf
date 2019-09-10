// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_beam_tele.sqf"
#include "..\x_setup.sqf"
#define __CTRL2(A) (_display displayCtrl A)

if (d_beam_target == "" || {d_x_loop_end}) exitWith {};

d_x_loop_end = true;

if (!isNull objectParent player) then {unassignVehicle player};

params ["_wone"];

disableSerialization;
private _display = [uiNamespace getVariable "xr_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);
if (_wone == 0) then {
	__CTRL2(100102) ctrlEnable false;
	__CTRL2(100107) ctrlEnable false;
	__CTRL2(100108) ctrlEnable false;
	__CTRL2(100109) ctrlEnable false;
} else {
	__CTRL2(3000) ctrlShow false;
};

private _global_pos = [];
private _global_dir = 180;
private _typepos = 0;

if (d_beam_target == "D_BASE_D") then {
#ifndef __TT__
	_global_pos = markerPos "base_spawn_1";
#else
	_global_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
#ifndef __CARRIER__
	_global_pos set [2, 0];
#else
	_global_pos set [2, (getPosASL d_FLAG_BASE) # 2];
#endif
	d_player_in_base = true;
} else {
	if (d_beam_target == "D_SQL_D") then {
		private _lead = leader (group player);
		private _emptycargo = [0, (vehicle _lead) emptyPositions "cargo"] select (!isNull objectParent _lead);
		if (_emptycargo == 0) then {
			_global_pos = [(vehicle _lead) modelToWorldVisual [0, -8, 0], getPosASLVisual _lead] select (isNull objectParent _lead);
			_global_pos set [2, _lead distance (getPos _lead)];
			_global_dir = getDirVisual _lead;
			_typepos = 1;
		} else {
			_typepos = 2;
		};
#ifndef __TT__
		d_player_in_base = player inArea d_base_array;
#else
		d_player_in_base = player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)};
#endif
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
			_global_pos = _mrs call d_fnc_posbehindvec;
			(boundingBoxReal _mrs) params ["_p1", "_p2"];
			private _maxHeight = abs ((_p2 # 2) - (_p1 # 2)) / 2;
			_global_pos set [2, (_mrs distance (getPos _mrs)) - _maxHeight];
			__TRACE_1("","_mrs distance (getPos _mrs)")
			_global_dir = getDirVisual _mrs;
			_typepos = 1;
			d_player_in_base = false;
		};
	};
};

d_last_beam_target = d_beam_target;
d_beam_target = "";

if (_typepos == 1) then {
	player setDir _global_dir;
	player setVehiclePosition [_global_pos, [], 0, "NONE"]; // CAN_COLLIDE ?
} else {
	if (_typepos == 0) then {
		player setDir _global_dir;
		if (!surfaceIsWater _global_pos) then {
			player setVehiclePosition [_global_pos, [], 0, "NONE"]; // CAN_COLLIDE ?
		} else {
			player setPosASL _global_pos;
		};
	} else {
		if (_typepos == 2) then {
			player moveInCargo (vehicle leader (group player));
		};
	};
};
[_wone, _typepos] spawn {
	scriptName "spawn_beam_tele";
	params ["_wone", "_typepos"];
	sleep 2;
	if (_wone == 0) then {
		if (d_teleport_dialog_open) then {closeDialog 0};
		titleText ["", "BLACK IN"];
	};

	{player reveal _x} forEach ((player nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 30]) + (player nearSupplies 30));

	if (d_with_ai && {alive player && {!(player getVariable ["xr_pluncon", false]) && {_typepos != 2 && {!(player getVariable ["ace_isunconscious", false])}}}}) then {[] spawn d_fnc_moveai};
};