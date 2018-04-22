// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pjump.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_startLocation"];

if (d_HALOWaitTime > 0) then {d_next_jump_time = time + d_HALOWaitTime};

titleText ["", "Plain"];
__TRACE_1("","d_jump_helo")
private _jumphelo = createVehicle [d_jump_helo, _startLocation, [], 0, "FLY"];
_jumphelo setPos _startLocation;
_jumphelo engineOn true;
if (_jumphelo emptyPositions "cargo" > 0) then {
	player moveInCargo _jumphelo;
} else {
	player moveInDriver _jumphelo;
};
if (isNull objectParent player) exitWith {
	if (!isNull _jumphelo) then {
		deleteVehicle _jumphelo;
	};
};

player setVelocity [0,0,0];
player action["eject", vehicle player];

sleep 3;

deleteVehicle _jumphelo;
if (d_with_ai && {alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}}) then {[getPosATL player, velocity player, getDirVisual player] spawn d_fnc_moveai};

d_jump_action_id = player addAction [localize "str_a3_rscgrouprootmenu_items_openparachute0", {
	private _chute = createVehicle ["Steerable_Parachute_F", [0,0, getPos player # 2], [], 0, "FLY"];
	_chute setDir (getDir player);
	_chute setPos (getPos player);
	player moveInDriver _chute;
	player removeAction d_jump_action_id;
	d_jump_action_id = nil;
}, 0, 6, false, false, "", "if (!alive player || {player getVariable ['xr_pluncon', false] || {getPos player # 2 < 1.5 || {player getVariable ['ace_isunconscious', false]}}}) then {player removeAction d_jump_action_id;d_jump_action_id = nil; false} else {true}"];
