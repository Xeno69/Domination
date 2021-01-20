// by Xeno
#define THIS_FILE "fn_dfps.sqf"
#include "..\x_setup.sqf"

if (!hasInterface || {d_force_isstreamfriendlyui == 1 || isStreamFriendlyUIEnabled}) exitWith {};

disableSerialization;
private _disp = uiNamespace getVariable "d_fpsresource";
if (isNil "_disp" || {isNull _disp}) then {
	"d_fpsresource" cutRsc ["d_fpsresource", "PLAIN"];
	_disp = uiNamespace getVariable "d_fpsresource";
};
(_disp displayCtrl 50) ctrlSetText str (round _this);
(_disp displayCtrl 51) ctrlSetText str (round diag_fps);
private _stime = systemTime;
private _hour = [str (_stime # 3), "0" + str (_stime # 3)] select ((_stime # 3) < 10);
private _sec = [str (_stime # 4), "0" + str (_stime # 4)] select ((_stime # 4) < 10);
(_disp displayCtrl 52) ctrlSetText format ["%1 %2:%3", localize "STR_DOM_MISSIONSTRING_2037", _hour, _sec];