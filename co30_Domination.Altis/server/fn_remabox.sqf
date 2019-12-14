// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_remabox.sqf"
#include "..\x_setup.sqf"

params ["_box"];
private _dbidx = (_box getVariable "d_box_params") # 0;
private _idx = d_ammo_boxes findIf {
	(_x # 0) == _dbidx
};
if (_idx > -1) then {
	deleteMarker (d_ammo_boxes # _idx # 2);
	d_ammo_boxes deleteAt _idx;
};
publicVariable "d_ammo_boxes";
deleteVehicle _box;
