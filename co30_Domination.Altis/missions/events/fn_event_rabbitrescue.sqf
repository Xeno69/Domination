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
private _rabbit = _rabbitgroup createUnit ["Rabbit_F", _rand_pos, [], 0, "NONE"];
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
private _move_order_interval = 30;
private _last_move = 0 - _move_order_interval;
private _distanceToEnableRescue = 3; //in meters
_rabbit setVariable ["BIS_fnc_animalBehaviour_disable", true];
private _dir = getDir _rabbit;
private _pos = getpos _rabbit;
// Create an invisible AI unit
private _ai = _rabbitgroup createUnit ["C_Man_1", _pos, [], 0, "FORM"];
_ai setdir _dir;
_ai allowdamage false;
hideObjectGlobal _ai;
//_ai enableSimulation false;
_ai setUnitPos "MIDDLE";
_ai allowFleeing 0;
_ai setBehaviour "CARELESS";
_ai setSpeedMode 'LIMITED';
_ai setSpeaker "NoVoice";
_ai enableai "ALL"; 
detach _ai; 
_ai enableSimulation true; 
_ai forcespeed -1; 
_ai switchMove ""; 
_ai setSpeedMode "FULL"; 
_ai forcespeed 9;
_ai setanimspeedcoef 1.3;

_rabbit attachTo [_ai,[0,-.4,0]];
_rabbit addEventHandler ["Killed", {params ["_unit", "_killer", "_instigator", "_useEffects"]; deleteVehicle (attachedTo _unit)}];
private _marker = ["d_bunny_marker", _rabbit, "ICON", "ColorBlue", [0.5,0.5], localize "STR_DOM_MISSIONSTRING_2028_RABBIT_MARKER", 0, "hd_dot"] call d_fnc_CreateMarkerGlobal;
	[_marker, "STR_DOM_MISSIONSTRING_2028_RABBIT_MARKER"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

[_rabbit, _ai, _target_center, _move_order_interval] spawn {
	scriptName "spawn rabbitrescue";
	params ["_rabbit", "_ai", "_target_center", "_move_order_interval"];
	_rabbit playMove "Rabbit_Hop";
	private _time_last_move = time;
	private _first_time = true;
	private _rand_pos = [];
	while { sleep 5; alive _rabbit } do
	{
		if ((time - _time_last_move) > _move_order_interval || { _first_time }) then {
			_time_last_move = time;
			_first_time = false;
			_rabbit playMove "Rabbit_Hop";
			_rand_pos = [[[_target_center, 100]],[[_target_center, 25]]] call BIS_fnc_randomPos;
			_ai doMove (_rand_pos);
		};
		"d_bunny_marker" setMarkerPos (getPosWorld _rabbit);
		if (_rabbit distance2D _rand_pos < 3) then {
			_rabbit playMove "Rabbit_Stop";
		};
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
	sleep 3.621;
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
		} forEach ((allPlayers - entities "HeadlessClient_F") select {!(_x isKindOf "VirtualMan_F")});
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
deleteVehicle _ai;
deleteVehicle _trigger;
deleteMarker _marker;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
