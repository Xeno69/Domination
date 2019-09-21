// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_aboxkilled.sqf"
#include "..\x_setup.sqf"

params ["_box"];
deleteMarker ((_box getVariable "d_box_params") # 1);
[_box] remoteExecCall ["d_fnc_RemABoxC"];
_box spawn {sleep 30; deleteVehicle _this};
d_ammo_boxes = d_ammo_boxes - [_box, objNull];
publicVariable "d_ammo_boxes";