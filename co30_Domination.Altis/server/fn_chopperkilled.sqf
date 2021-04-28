// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

call d_fnc_fuelCheck;
private _ropes = _this getVariable "d_ropes";
if (!isNil "_ropes") then {
	{ropeDestroy _x} forEach (_ropes select {!isNull _x});
	_this setVariable ["d_ropes", nil];
};
private _attached = _this getVariable "d_attachedto_v";
if (!isNil "_attached") then {
	detach _attached;
	_this setVariable ["d_attachedto_v", nil, true];
};
