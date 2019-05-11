// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerLocal.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerLocal.sqf"];
__TRACE_1("","_this")

if (hasInterface) then {
	0 spawn {
		scriptName "spawn_init_playerlocal";
		waitUntil {time > 0};
		sleep (2 + random 1);
		private _np = player getVariable ["d_plname", ""];
		if (_np isEqualTo "" || {_np isEqualTo "Error: No unit"}) then {
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

player enableAttack false;

if (hasInterface) then {
	execVM "tasks.sqf";
};
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerLocal.sqf processed"];