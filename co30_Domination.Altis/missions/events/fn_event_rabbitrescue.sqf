// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// One rabbit spawns in a location near the center of the maintarget and then moves around randomly, disappears when "caught"

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _trigger = [_target_center, [600,600,0,false,30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

private _bunnyName = selectRandom ['Captain Fluffbutt', 'Ivan Ironfluff', 'Oreo FlopEar Rabbitton III', 'Thumper von Pinknose', 'Snowball the Terrible'];

private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028_RABBIT", _bunnyName];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSideRabbitRescue",
	["1", "", _bunnyName, []],
	d_kbtel_chan
];

private _rand_pos = [[[_target_center, 15]],["water"]] call BIS_fnc_randomPos;
private _rabbitgroup = [independent] call d_fnc_creategroup;
//private _rabbit = _rabbitgroup createUnit ["Rabbit_F", _target_center, [], 0, "NONE"];
private _rabbit = createAgent ["Rabbit_F", _rand_pos, [], 5, "NONE"];
[_rabbit, 30] call d_fnc_nodamoffdyn;

_rabbitgroup setCombatMode "RED";
_rabbitgroup setSpeedMode "FULL";
_rabbitgroup setBehaviour "COMBAT";

if (d_with_dynsim == 0) then {
	[_rabbitgroup, 0] spawn d_fnc_enabledynsim;
};

sleep 3.14;

private _event_succeed_points = 25;
private _is_dead = false;
private _is_rescued = false;
private _move_order_interval = 300;
private _last_move = 0 - _move_order_interval;
private _distanceToEnableRescue = 3; //in meters
_rabbit setVariable ["BIS_fnc_animalBehaviour_disable", true];
private _marker = ["d_bunny_marker", _rabbit, "ICON", "ColorBlue", [0.5,0.5], localize "STR_DOM_MISSIONSTRING_2028_RABBIT_MARKER", 0, "hd_dot"] call d_fnc_CreateMarkerGlobal;
	[_marker, "STR_DOM_MISSIONSTRING_2028_RABBIT_MARKER"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

[_rabbit, _target_center, _move_order_interval] spawn {
	scriptName "spawn rabbitrescue";
	params ["_rabbit", "_target_center", "_move_order_interval"];
	_rabbit playMove "Rabbit_Hop";
	private _time_last_move = time;
	private _first_time = true;
	while { sleep 5; alive _rabbit } do
	{
		if ((time - _time_last_move) > _move_order_interval || { _first_time }) then {
			_time_last_move = time;
			_first_time = false;
			// this doesn't actually work, rabbit wanders around and does not obey moveTo
			_rabbit moveTo ([[[_target_center, 100]],[[_target_center, 25]]] call BIS_fnc_randomPos);
		};
		"d_bunny_marker" setMarkerPos (getPosWorld _rabbit);
	};
};

while {!d_mt_done && {!_is_dead && {!_is_rescued}}} do {
	if (!alive _rabbit) exitWith {
		_is_dead = true;
	};
	private _nobjs = (_rabbit nearEntities ["CAManBase", _distanceToEnableRescue]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
	if (_nobjs isNotEqualTo []) then {
		_is_rescued = true;
	};
	sleep 5.621;
};

if (_is_rescued || {!_is_dead}) then {
	if (_is_rescued) then {
		d_kb_logic1 kbTell [
			d_kb_logic2,
			d_kb_topic_side,
			"MTEventSideRescueGenericNameSucceed",
			["1", "", _bunnyName, []],
			["2", "", str _event_succeed_points, []],
			d_kbtel_chan
		];
		{
			_x addScore _event_succeed_points;
		} forEach (allPlayers - entities "HeadlessClient_F");
	};
} else {
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"MTEventSideRescueGenericNameFail",
		["1", "", _bunnyName, []],
		d_kbtel_chan
	];
};

deleteVehicle _rabbit;
deleteVehicle _trigger;
deleteMarker _marker;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
