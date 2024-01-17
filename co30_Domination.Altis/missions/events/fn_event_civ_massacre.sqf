// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

// When triggered all enemy units will add civilians as targets in the awareness script
// See fn_hallyg_dlegion_Snipe_awareness.sqf for more info about targeting civilians.
// The event does not end until the maintarget is cleared.
// TODO - Players receive one point per civilian still alive when maintarget is completed

if (!isServer) exitWith {};

params ["_target_radius", "_target_center"];

//private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];
 
private _trigger = [_target_center, [round (d_cur_target_radius * 0.75), round (d_cur_target_radius * 0.75), 0 , false, 30], ["ANYPLAYER","PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 1; !isNil {_trigger getVariable "d_event_start"}};

diag_log ["civ_massacre begins"];

private _civ_count_endangered = 0;
private _civ_count_survived = 0;

{
	if (alive _x && {_x getEntityInfo 0 && {side _x == civilian}}) then {
		_civ_count_endangered = _civ_count_endangered + 1;
	};
} forEach (nearestObjects [_target_center, ["Man"], d_cur_target_radius]);

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventCivMassacre",
	["1", "", str _civ_count_endangered, []],
	d_kbtel_chan
];

d_civ_massacre = true;
publicVariable "d_civ_massacre";

private _event_description = format [localize "STR_DOM_MISSIONSTRING_EVENTCIVMASSACRE", _civ_count_endangered];
d_mt_event_messages_array pushBack _event_description;
publicVariable "d_mt_event_messages_array";

waitUntil {sleep 5; d_mt_done};

diag_log ["civ_massacre ended"];

{
	if (alive _x && {_x getEntityInfo 0 && {side _x == civilian}}) then {
		_civ_count_survived = _civ_count_survived + 1;
	};
} forEach (nearestObjects [_target_center, ["Man"], d_cur_target_radius]);

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"MTEventCivMassacreEnded",
	["1", "", str _civ_count_survived, []],
	["2", "", str _civ_count_endangered, []],
	d_kbtel_chan
];

// cleanup
deleteVehicle _trigger;
d_civ_massacre = false;
publicVariable "d_civ_massacre";
d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _event_description);
publicVariable "d_mt_event_messages_array";
