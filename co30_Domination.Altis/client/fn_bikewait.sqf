// by Xeno
#include "..\x_setup.sqf"

private _vec = _this;
while {alive _vec && {(crew _vec) findIf {alive _x} > -1}} do {
	sleep 1;
};
deleteVehicle _vec;