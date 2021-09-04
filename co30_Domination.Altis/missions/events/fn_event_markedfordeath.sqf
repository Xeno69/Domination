// by Longtime
//#define __DEBUG__
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

private _trigger = [_target_center, [(d_cur_target_radius * 0.50),(d_cur_target_radius * 0.50),0,false,10], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start_time', time];",""]] call d_fnc_CreateTriggerLocal;

private _event_start_time = nil;
private _event_target = nil;
private _event_target_name = nil;
private _event_survive_time = 180; // in seconds
private _event_succeed_points = 5;

waitUntil {sleep 5;!isNil {_trigger getVariable "d_event_start_time"}};
_event_start_time = _trigger getVariable "d_event_start_time";
d_priority_targets pushBack ([allPlayers, _target_center] call BIS_fnc_nearestPosition);
publicVariable "d_priority_targets";
_event_target = d_priority_targets # 0;
_event_target_name = name _event_target;

_event_target addEventHandler ["Killed", {
	// reset
	d_priority_targets = [];
	publicVariable "d_priority_targets";
	(_this # 0) removeEventHandler ["Killed", _thisEventhandler];
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

// waitUntil either killed EH or _event_survive_time duration
waitUntil {sleep 3;d_priority_targets isEqualTo []  || {(time - _event_start_time) > _event_survive_time}};

diag_log ["markedfordeath ended"];

if (d_priority_targets isEqualTo []) then {
	diag_log ["markedfordeath failure"];
	private _fail_survive_time = time - _event_start_time;
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"PlayerMarkedForDeathFail",
    	["1", "", _event_target_name, []],
    	["2", "", str _fail_survive_time, []],
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
	{
		_x addScore _event_succeed_points;
	} forEach (allPlayers - entities "HeadlessClient_F");
	// reset 
	d_priority_targets deleteAt 0;
	publicVariable "d_priority_targets";
};

// cleanup
// nothing?