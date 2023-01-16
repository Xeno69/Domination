// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface || {(d_force_isstreamfriendlyui == 1) || {isStreamFriendlyUIEnabled}}) exitWith {};

disableSerialization;
private _disp = uiNamespace getVariable "d_fpsresource";
if (isNil "_disp" || {isNull _disp}) then {
	"d_fpsresource" cutRsc ["d_fpsresource", "PLAIN"];
	_disp = uiNamespace getVariable "d_fpsresource";
};
(_disp displayCtrl 50) ctrlSetText str (round _this);
(_disp displayCtrl 51) ctrlSetText str (round diag_fps);
(_disp displayCtrl 52) ctrlSetText format ["%1 %2:%3", d_yt_loc2037, d_num_hash getOrDefault [systemTime # 3, systemTime # 3], d_num_hash getOrDefault [systemTime # 4, systemTime # 4]];
