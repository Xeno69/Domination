// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_startLocation"];

if (d_HALOWaitTime > 0) then {d_next_jump_time = time + d_HALOWaitTime};

titleText ["", "Plain"];

player setPos _startLocation;

sleep 3;

if (d_with_ai && {d_player_canu}) then {[getPosATL player, velocity player, getDirVisual player] spawn d_fnc_moveai};

d_jump_action_id = player addAction [localize "str_a3_rscgrouprootmenu_items_openparachute0", {
	private _chuten = call {
		if (d_ifa3 || {d_gmcwg || {d_unsung || {d_csla || {d_spe || {d_vn && {d_force_steerable_parachutes != 1}}}}}}) exitWith {
			d_non_steer_para
		};
		"Steerable_Parachute_F"
	};
	private _chute = createVehicle [_chuten, [0,0, getPos player # 2], [], 0, "FLY"];
	_chute setDir (getDir player);
	_chute setPos (getPos player);
	player moveInDriver _chute;
	player removeAction d_jump_action_id;
	d_jump_action_id = nil;
}, 0, 6, false, false, "", "if (!d_player_canu || {getPos player # 2 < 1.5}) then {player removeAction d_jump_action_id;d_jump_action_id = nil; false} else {true}"];
