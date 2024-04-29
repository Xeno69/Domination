// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// Guerilla infantry spawn in the maintarget garrisoned in buildings and defend the city
// This is always a pre-emptive event, runs concurrently with fn_event_enemy_incoming or another incoming event

if !(isServer) exitWith {};

params ["_target_radius", "_target_center"];

private _event_name = "guerrilla_defend";
private _mt_event_key = format ["d_X_MTEVENT_%1_%2", d_cur_tgt_name, _event_name];

diag_log [format ["start event: %1", _mt_event_key]];

private _x_mt_event_ar = [];

private _townNearbyName = "local reserves"; // hard coded
private _eventDescription = format [localize "STR_DOM_MISSIONSTRING_2028_INFANTRY", _townNearbyName];
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventSideGuerrInfantry",
	["1", "", _townNearbyName, []],
	d_kbtel_chan
];

private _newgroups_inf = [];

// calculate the sum of all groups of AI
private _targetGroupCount = d_occ_cnt_current + d_ovrw_cnt_current + d_amb_cnt_current + d_grp_cnt_footpatrol;
// guerrillas should be outnumbered
private _guerrillaGroupCount = round(_targetGroupCount / 3) min 5;
private _guerrillaForce = [];
// size the guerrilla force
for "_i" from 0 to _guerrillaGroupCount do {
	_guerrillaForce pushBack "allmen";
};

private _guerrillaBaseSkill = 0.85;
private _markerpos = [];
{
	private _unitlist = [_x, "G"] call d_fnc_getunitlistm;
	if !(d_faction_independent_array isEqualTo []) then {
		_unitlist = selectRandom (d_faction_independent_array select 0);
	};
	private _newgroup = [independent] call d_fnc_creategroup;
	// random position within 125m of target center
	private _rand_pos = [[[_target_center, 80]],["water"]] call BIS_fnc_randomPos;
	if (_markerpos isEqualTo []) then {
		_markerpos = _rand_pos;
	};
	private _units = [_rand_pos, _unitlist, _newgroup, false, true, 5, true] call d_fnc_makemgroup;
	{
		_x setSkill _guerrillaBaseSkill;
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		_x addEventHandler ["handleHeal", {call d_fnc_handleheal}];
		_x_mt_event_ar pushBack _x;
	} forEach _units;
	_newgroups_inf pushBack _newgroup;
	d_delinfsm append _units;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
	// garrison the units
	// a chance the group is in overwatch or ambush mode
	if (random 100 > 50) then {
		private _unitsNotGarrisoned = [
			_rand_pos,
			_units,
			99,
			false,
			false,
			false,
			false,
			3, // (overwatch) unit is static, free to move after firedNear event at very close range
			false,
			false,
			false,
			-1
		] call d_fnc_Zen_OccupyHouse;
	} else {
		private _unitsNotGarrisoned = [
			_rand_pos,
			_units,
			99,
			false,
			false,
			false,
			false,
			1, // (ambush) unit is free to move after a firedNear event is triggered at 35m
			false,
			false,
			false,
			-1
		] call d_fnc_Zen_OccupyHouse;
	};
		
} forEach _guerrillaForce;

_marker = ["d_mt_event_marker_guerrillainfantry_defend", _markerpos, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_GUERRILLAS", 0, "mil_start"] call d_fnc_CreateMarkerGlobal;
[_marker, "STR_DOM_MISSIONSTRING_GUERRILLAS"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

waitUntil {sleep 1; d_mt_radio_down && {d_mt_done}};

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";

//cleanup
diag_log [format ["cleanup of event: %1", _mt_event_key]];
diag_log [format ["cleanup of event array: %1", _x_mt_event_ar]];
deleteMarker _marker;
