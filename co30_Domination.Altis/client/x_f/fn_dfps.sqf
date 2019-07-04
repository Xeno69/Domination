// by Xeno
#define THIS_FILE "fn_dfps.sqf"
#include "..\..\x_setup.sqf"

//if (d_still_in_intro) exitWith {};

disableSerialization;
private _disp = uiNamespace getVariable "d_fpsresource";
if (isNil "_disp" || {isNull _disp}) then {
	"d_fpsresource" cutRsc ["d_fpsresource", "PLAIN"];
	_disp = uiNamespace getVariable "d_fpsresource";
};
(_disp displayCtrl 50) ctrlSetText str (round _this);
(_disp displayCtrl 51) ctrlSetText str (round diag_fps);
