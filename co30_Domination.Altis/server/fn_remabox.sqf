// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_remabox.sqf"
#include "..\x_setup.sqf"

params ["_box", ["_vec", objNull]];

if (!isNull _vec) then {
	private _percent = _box getVariable "d_abox_perc";
	if (!isNil "_percent") then {
		(_this # 1) setVariable ["d_abox_perc", _percent, true];
	};
};
private _dbidx = (_box getVariable "d_box_params") # 0;
private _idx = d_ammo_boxes findIf {
	(_x # 0) == _dbidx
};
if (_idx > -1) then {
	deleteMarker (d_ammo_boxes # _idx # 2);
	d_ammo_boxes deleteAt _idx;
};
publicVariable "d_ammo_boxes";
private _jipid = _box getVariable "d_box_drop2_jip_id";
__TRACE_1("","_jipid")
if (!isNil "_jipid") then {
	remoteExecCall ["", _jipid];
};
deleteVehicle _box;
