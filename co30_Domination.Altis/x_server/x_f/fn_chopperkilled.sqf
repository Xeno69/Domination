// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_chopperkilled.sqf"
#include "..\..\x_setup.sqf"

_this call d_fnc_fuelCheck;
private _ropes = (_this select 0) getVariable "d_ropes";
if (!isNil "_ropes") then {
	{ropeDestroy _x} forEach (_ropes select {!isNull _x});
	(_this select 0) setVariable ["d_ropes", nil];
};
private _attached = (_this select 0) getVariable "d_attachedto_v";
if (!isNil "_attached") then {
	detach _attached;
	(_this select 0) setVariable ["d_attachedto_v", nil, true];
};
