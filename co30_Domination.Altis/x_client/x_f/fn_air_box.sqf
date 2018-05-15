// by Xeno
#define THIS_FILE "fn_air_box.sqf"
#include "..\..\x_setup.sqf"

private _box = d_the_box createVehicleLocal [0,0,0];
_box setPos [_this select 0, _this select 1, 0];
player reveal _box;
[_box] call d_fnc_weaponcargo;
_box addEventHandler ["killed",{
	deleteVehicle (_this select 0);
}];

if (isNil "d_airboxes") then {
	d_airboxes = [];
};
_box setVariable ["d_airboxtime", time + 1800];
d_airboxes pushBack _box;