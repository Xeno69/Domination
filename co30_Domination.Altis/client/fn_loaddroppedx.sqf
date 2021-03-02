// by Xeno
#define THIS_FILE "fn_loaddroppedx.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_unit", "_caller"];

private _chatfunc = {
	if (vehicle (_this # 1) == _this # 0) then {
		(_this # 0) vehicleChat (_this # 2);
	} else {
		(_this # 1) sideChat (_this # 2);
	};
};

if (_unit == _caller) then {_unit = d_curvec_dialog};

if (_caller != currentPilot _unit && {!isNil {_unit getVariable "d_choppertype"}}) exitWith {};

if ((_unit call d_fnc_GetHeight) > 3) exitWith {_unit vehicleChat (localize "STR_DOM_MISSIONSTRING_267")};

if (speed _unit > 3) exitWith {_unit vehicleChat (localize "STR_DOM_MISSIONSTRING_268")};

if (_unit getVariable ["d_ammobox", false]) exitWith {[_unit, _caller, localize "STR_DOM_MISSIONSTRING_269"] call _chatfunc};

if (_unit getVariable ["d_ammobox_next", -1] > time) exitWith {[_unit, _caller, format [localize "STR_DOM_MISSIONSTRING_270", round ((_unit getVariable "d_ammobox_next") - time)]] call _chatfunc};

private _nobjs = nearestObjects [_unit, [d_the_box], 20];
if (_nobjs isEqualTo []) exitWith {[_unit, _caller, localize "STR_DOM_MISSIONSTRING_271"] call _chatfunc};
[_unit, _caller, localize "STR_DOM_MISSIONSTRING_272"] call _chatfunc;
private _box = _nobjs # 0;
[_box] remoteExecCall ["d_fnc_RemABoxC"];
sleep 0.5;
[_box, _unit] remoteExecCall ["d_fnc_RemABox", 2];
_unit setVariable ["d_ammobox", true, true];
_unit setVariable ["d_ammobox_next", time + d_drop_ammobox_time, true];
[_unit, _caller, localize "STR_DOM_MISSIONSTRING_273"] call _chatfunc;

disableSerialization;
private _disp = uiNamespace getVariable "d_VecDialog";
(_disp displayCtrl 44448) ctrlEnable true;
(_disp displayCtrl 44452) ctrlEnable false;