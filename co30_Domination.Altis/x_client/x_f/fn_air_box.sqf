// by Xeno
#define THIS_FILE "fn_air_box.sqf"
#include "..\..\x_setup.sqf"

private _box = d_the_box createVehicleLocal [0,0,0];
_box setPos [param [0], param [1], 0];
player reveal _box;
[_box] call d_fnc_weaponcargo;
_box addEventHandler ["killed",{
	deleteVehicle (param [0]);
}];

if (isNil "d_airboxes") then {
	d_airboxes = [];
};
_box setVariable ["d_airboxtime", time + 1800];
d_airboxes pushBack _box;