// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerLocal.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerLocal.sqf"];
__TRACE_1("","_this")
if (hasInterface) then {
	0 spawn {
		waitUntil {sleep 0.1; !isNil "d_with_bis_dynamicgroups"};
		if (d_with_bis_dynamicgroups == 0) then {
			["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
		};
		sleep 3;
		(findDisplay 46) displayAddEventHandler ["KeyDown", {if ((_this select 1) in actionKeys "TeamSwitch" && {alive player && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false]) && {!(_this select 2) && {!(_this select 3) && {!(_this select 4)}}}}}}) then {[0, _this] call d_fnc_KeyDownCommandingMenu; true} else {false}}];
		(findDisplay 46) displayAddEventHandler ["KeyUp", {if ((_this select 1) in actionKeys "TeamSwitch"&& {!(_this select 2) && {!(_this select 3) && {!(_this select 4)}}}) then {[1, _this] call d_fnc_KeyDownCommandingMenu; true} else {false}}];
	};
};
player enableAttack false;

if (hasInterface) then {
	0 spawn {
		sleep (1 + random 1);
		private _np = player getVariable ["d_plname", ""];
		if (_np == "" || {_np == "Error: No unit"}) then {
			_np = profileName splitString """'" joinString "";
			if (_np isEqualTo "Error: No unit") then {
				_np = (name player) splitString """'" joinString "";
			};
			player setVariable ["d_plname", _np, true];
		};
		__TRACE_1("","_np")
		d_name_pl = _np;
	};
};

execVM "tasks.sqf";
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerLocal.sqf processed"];