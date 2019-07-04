// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_waitforgps.sqf"
#include "..\..\x_setup.sqf"

disableSerialization;
sleep 10;
__TRACE_1("","uiNamespace getVariable 'IGUI_displays'")
waitUntil {sleep 0.1; visibleGPS};
__TRACE("starting")
__TRACE_1("","(uiNamespace getVariable 'RscCustomInfoMiniMap')")
__TRACE_1("","(uiNamespace getVariable 'RscCustomInfoMiniMap')  displayCtrl 101")
//((uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101) ctrlAddEventHandler ["Draw", {[[(uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101, 0], 0] call d_fnc_mapondraw}];
//(findDisplay 311 displayCtrl 101) ctrlAddEventHandler ["Draw", {[[findDisplay 311 displayCtrl 101, 0], 0] call d_fnc_mapondraw}];

{
	private _ctrl = _x displayCtrl 101;
	if (!isNull _ctrl) exitWith {
		__TRACE_1("","_x")
		uiNamespace setVariable ["d_gps_map_ctrl", _ctrl];
		_ctrl ctrlAddEventHandler ["Draw", {[[uiNamespace getVariable "d_gps_map_ctrl", 0], 0] call d_fnc_mapondraw}];
	};
} forEach (uiNamespace getVariable "IGUI_displays");
