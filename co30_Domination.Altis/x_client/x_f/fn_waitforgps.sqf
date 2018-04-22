// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_waitforgps.sqf"
#include "..\..\x_setup.sqf"

disableSerialization;
sleep 10;
__TRACE_1("","uiNamespace getVariable 'IGUI_displays'")
waitUntil {sleep 0.1;visibleGPS};
__TRACE("starting")
__TRACE_1("","(uiNamespace getVariable 'RscCustomInfoMiniMap')")
((uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101) ctrlAddEventHandler ["Draw", {[[(uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101, 0], 0] call d_fnc_mapondraw}];
