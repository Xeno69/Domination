// by Xeno (modified by Longtime)
//#define __DEBUG__
#define THIS_FILE "fn_event_sideprisoners.sqf"
#include "..\..\x_setup.sqf"

params ["_target_radius", "_target_center"];

// Rescue captive friendly soldiers guarded by specops.  If the specops are injured they will kill the hostages.

if !(isServer) exitWith {};

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

private _mt_event_key = format ["d_X_MTEVENT_%1", d_cur_tgt_name];

//position the event site near target center at max distance 250m and min 150m 
private _poss = [[[_target_center, 250]],[[_target_center, 150]]] call BIS_fnc_randomPos;
_x_mt_event_ar = [];

private _trigger = [_poss, [225,225,0,false], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

_eventDescription = localize "STR_DOM_MISSIONSTRING_1805_MILITARY";
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisoners",d_kbtel_chan];

private _marker = ["d_mt_event_marker_sideprisoners", _poss, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_PRISONERS", 0, "mil_unknown"] call d_fnc_CreateMarkerGlobal;

private _prisonerGroup = [d_own_side] call d_fnc_creategroup;

private _distance_to_rescue = 3; //in meters

private _allActors = [];

if (d_with_ai) then {
	_prisonerGroup setVariable ["d_do_not_delete", true];
};
__TRACE_1("","_prisonerGroup")
private _nposss = [];
_nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};
private _pilot1 = _prisonerGroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
_x_mt_event_ar pushBack _pilot1;
_allActors pushBack _pilot1;
[_pilot1, 30] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;
[_pilot1, getPos _pilot1] call d_fnc_setposagls;

removeAllWeapons _pilot1;
_pilot1 setCaptive true;
_pilot1 enableStamina false;
_pilot1 enableFatigue false;
_pilot1 disableAI "PATH";
_pilot1 disableAI "RADIOPROTOCOL";
_pilot1 forceSpeed 0;
private _leader = leader _prisonerGroup;
_leader setSkill 1;
_prisonerGroup allowFleeing 0;
_prisonerGroup deleteGroupWhenEmpty true;


if (d_with_dynsim == 0) then {
	[_prisonerGroup] spawn d_fnc_enabledynsim;
};

sleep 2.333;

private _enemyGuardGroup = ["specops", 1, "allmen", 0, _poss , 12, false, true, 3] call d_fnc_CreateInf select 0;
{
	[_x, 30] call d_fnc_nodamoffdyn;
	_x forceSpeed 0;
	_allActors pushBack _x;
	_x_mt_event_ar pushBack _x;
} forEach (units _enemyGuardGroup);

//occupy a building using Zenophon script
_unitsNotGarrisoned = [
	_poss,											// Params: 1. Array, the building(s) nearest this position is used
	_allActors,									//         2. Array of objects, the units that will garrison the building(s)
	-1,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
	false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
	false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
	true,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
	false,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
	2,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	true,                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
	true                                                //  (opt.) 10. Boolean, true to allow the selected position to be near an enemy (default: false)
] call d_fnc_Zen_OccupyHouse;

{deleteVehicle _x} forEach _unitsNotGarrisoned;

private _hostages_reached_dest = false;
private _all_dead = false;
private _rescued = false;
private _rescuer = objNull;
private _isExecutePrisoners = false;
                                             
while {!d_mt_done} do {

	if (!alive _pilot1) exitWith { _all_dead = true };
	
	private _nobjs = (_pilot1 nearEntities ["CAManBase", _distance_to_rescue]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
	if !(_nobjs isEqualTo []) exitWith {
		__TRACE("rescued _pilot1")
		deleteVehicle _pilot1;
		// todo announce player
	};
	
	if ((units _enemyGuardGroup) findIf {damage _x > 0.02} != -1) then {
		//if any unit in enemyGuardGroup is wounded more than 0.15 then set flag to shoot prisoners
    	_isExecutePrisoners = true;
	};
    
    if (_isExecutePrisoners) then {
		_pilot1 setCaptive false;
		{
        	_x forceSpeed -1;
        } forEach (units _enemyGuardGroup);
    };
    
    if (_isExecutePrisoners || {!(captive _pilot1)}) then {
		{	
			//todo - play a sound?
			_x forceSpeed -1;
			_enemyGuardGroup reveal [_pilot1, 4];
			_x doTarget _pilot1;
			_x doSuppressiveFire _pilot1;
		} forEach (units _enemyGuardGroup);
    };
    
    // gimme three steps mister
    if (_isExecutePrisoners) then {
		sleep 3;
	};
	
	sleep 3.14;
};

if (_all_dead) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersFail",d_kbtel_chan];
} else {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersSucceed",d_kbtel_chan];
};

sleep 30;

//cleanup
{
	if !(isNull _x) then {
		if (_x isKindOf "House") then {
			_x setDamage 0;
			deleteVehicle _x;
		} else {
			if (_x isKindOf "LandVehicle" && {!((crew _x) isEqualTo [])}) then {
				if ({(_x call d_fnc_isplayer) && {alive _x}} count (crew _x) == 0) then {
					_x call d_fnc_DelVecAndCrew;
				};
			} else {
				deleteVehicle _x;
			};
		};
	};
} forEach _x_mt_event_ar;
_x_mt_event_ar = [];

deleteVehicle _trigger;
deleteMarker _marker;

d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
