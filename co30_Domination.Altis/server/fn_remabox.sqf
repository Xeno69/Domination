// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_remabox.sqf"
#include "..\x_setup.sqf"

params ["_box"];
private _fidx = d_ammo_boxes findIf {(_x # 0) == _box};
if (_fidx > -1) then {
	deleteMarker (d_ammo_boxes # _fidx # 1);
	d_ammo_boxes deleteAt _fidx;
};
publicVariable "d_ammo_boxes";
deleteVehicle _box;
