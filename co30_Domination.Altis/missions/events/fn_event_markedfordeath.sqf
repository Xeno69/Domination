// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_event_markedfordeath.sqf"
#include "..\..\x_setup.sqf"

// When triggered the player closest to _target_center will become a priority target. All moving enemies will move and attack that specific player until dead.
// Target player must survive long enough to win the mission.

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _trigger = [_target_center, [225,225,0,false,30], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start_time', time];",""]] call d_fnc_CreateTriggerLocal;

private _event_start_time = nil;
private _event_target_name = nil;
private _event_survive_time = 180; // in seconds
private _event_succeed_points = 0; // haha maybe someday

waitUntil {sleep 5;!isNil {_trigger getVariable "d_event_start_time"}};
_event_start_time = _trigger getVariable "d_event_start_time";
d_priority_target = [allPlayers, _target_center] call BIS_fnc_nearestPosition;
publicVariable "d_priority_target";
_event_target_name = name d_priority_target;

d_priority_target addEventHandler ["Killed", {
	d_priority_target = nil;
	publicVariable "d_priority_target";
}];

diag_log [format["markedfordeath begins start time: %1 _event_target_name: %2", _event_start_time, _event_target_name]];
d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"PlayerMarkedForDeath",
	["1", "", _event_target_name, []],
	["2", "", str _event_survive_time, []],
	d_kbtel_chan
];


waitUntil {sleep 3;isNil "d_priority_target" || {(time - _event_start_time) > _event_survive_time}};

diag_log ["markedfordeath ended"];

if (isNil "d_priority_target") then {
	diag_log ["markedfordeath failure"];
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"PlayerMarkedForDeathFail",
    	["1", "", _event_target_name, []],
    	["2", "", str _event_survive_time, []],
    	d_kbtel_chan
    ];
} else {
	diag_log ["markedfordeath success"];
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"PlayerMarkedForDeathSucceed",
		["1", "", _event_target_name, []],
		["2", "", str _event_survive_time, []],
		["3", "", str _event_succeed_points, []],
		d_kbtel_chan
	];
	d_priority_target = nil;
	publicVariable "d_priority_target";
};

// cleanup
// nothing?