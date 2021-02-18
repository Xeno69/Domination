// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_event_rabbitrescue.sqf"
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// One rabbit spawns in a location near the center of the maintarget and then moves around randomly, disappears when "caught"

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

private _trigger = [_target_center, [600,600,0,false,30], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

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

private _rabbitgroup = [independent] call d_fnc_creategroup;
//private _rabbit = _rabbitgroup createUnit ["Rabbit_F", _target_center, [], 0, "NONE"];
private _rabbit = createAgent ["Rabbit_F", _target_center, [], 5, "NONE"];
[_rabbit, 30] call d_fnc_nodamoffdyn;
_rabbitgroup deleteGroupWhenEmpty true;

_rabbitgroup setCombatMode "RED";
_rabbitgroup setSpeedMode "FULL";
_rabbitgroup setBehaviour "COMBAT";

if (d_with_dynsim == 0) then {
	[_rabbitgroup, 0] spawn d_fnc_enabledynsim;
};

sleep 3.14;

private _is_dead = false;
private _is_rescued = false;
private _move_order_interval = 300;
private _last_move = 0 - _move_order_interval;
private _distanceToEnableRescue = 3; //in meters
_rabbit setVariable ["BIS_fnc_animalBehaviour_disable", true];

[_rabbit, _target_center, _move_order_interval] spawn {
	scriptName "spawn rabbitrescue";
	params ["_rabbit", "_target_center", "_move_order_interval"];
	_rabbit playMove "Rabbit_Hop";
	while { sleep 1; alive _rabbit } do
	{
		_rabbit moveTo ([[[_target_center, 250]],[[_target_center, 150]]] call BIS_fnc_randomPos);
		sleep _move_order_interval;
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

if (_is_rescued || !_is_dead) then {
	d_kb_logic1 kbTell [
		d_kb_logic2,
		d_kb_topic_side,
		"MTEventSideRescueGenericNameSucceed",
		["1", "", _bunnyName, []],
		d_kbtel_chan
	];
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

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
