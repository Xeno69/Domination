// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_box"];
deleteMarker ((_box getVariable "d_box_params") # 2);
[_box] remoteExecCall ["d_fnc_RemABoxC", [0, -2] select isDedicated];
_box spawn {
	scriptname "spawn aboxkilled";
	sleep 30;
	deleteVehicle _this;
};
private _dbidx = (_box getVariable "d_box_params") # 0;
private _idx = d_ammo_boxes findIf {
	(_x # 0) == _dbidx
};
if (_idx > -1) then {
	d_ammo_boxes deleteAt _idx;
};
publicVariable "d_ammo_boxes";