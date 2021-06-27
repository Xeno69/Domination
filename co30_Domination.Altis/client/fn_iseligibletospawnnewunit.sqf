// by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

//check if _unit (a player) is eligible for another player to spawn on them
//if _unit is alive, conscious, not falling, not swimming and if in a vehicle has cargo space available for the new player

params ["_unit"];

private _emptycargo = [0, (vehicle _unit) emptyPositions "cargo"] select (!isNull objectParent _unit);

if (alive _unit && {!(_unit getVariable ["xr_pluncon", false])} && {!(_unit getVariable ["ace_isunconscious", false])} && {_emptycargo > 0 || {(getPos _unit) # 2 < 10}} && {!(_unit call d_fnc_isswimming)} && {!underwater _unit}) then {
	true
} else {
	false
}