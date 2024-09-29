// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

// If any player enters the maintarget radius then create a large group of infantry very near the center of the maintarget.  Infantry is free to move immediately.

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1_%2", d_cur_tgt_name, "INFANTRY_AMBUSH"];
diag_log [format ["start event: %1", _mt_event_key]];


private _trigger = [_target_center, [(d_cur_target_radius * 0.90),(d_cur_target_radius * 0.90),0,false,10], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start_time', time];",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 5; !isNil {_trigger getVariable "d_event_start_time"}};

diag_log [format ["start event: %1", _mt_event_key]];

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventEnemyAmbushGroup",
	d_kbtel_chan
];

private _enemyForceInf = ["allmen", "allmen", "allmen"];

{
	private _unitlist = [_x, d_enemy_side_short] call d_fnc_getunitlistm;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _rand_pos = [[[_target_radius, 25]],["water"]] call BIS_fnc_randomPos;
	private _units = [_rand_pos, _unitlist, _newgroup, false, true] call d_fnc_makemgroup;
	{
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
	} forEach _units;
	d_delinfsm append _units;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _enemyForceInf;

// cleanup immediately, nothing to wait for
diag_log [format ["cleanup of event: %1", _mt_event_key]];
deleteVehicle _trigger;