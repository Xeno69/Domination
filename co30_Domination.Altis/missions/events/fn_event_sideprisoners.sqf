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

//position the event site near target center at max distance 125m and min 15m 
private _poss = [[[_target_center, 125]],[[_target_center, 15]]] call BIS_fnc_randomPos;
_x_mt_event_ar = [];

private _trigger = [_poss, [225,225,0,false,30], [d_own_side,"PRESENT",true], ["this","thisTrigger setVariable ['d_event_start', true]",""]] call d_fnc_CreateTriggerLocal;

waitUntil {sleep 0.1;!isNil {_trigger getVariable "d_event_start"}};

_eventDescription = localize "STR_DOM_MISSIONSTRING_1805_MILITARY";
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisoners",d_kbtel_chan];

private _marker = ["d_mt_event_marker_sideprisoners", _poss, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_PRISONERS", 0, "mil_unknown"] call d_fnc_CreateMarkerGlobal;

private _prisonerGroup = [d_own_side] call d_fnc_creategroup;

private _distance_to_rescue = 1.5; //in meters

private _allActors = [];

__TRACE_1("","_prisonerGroup")
// select a starting point, units will be moved later to occupy a building if possible
private _nposss = [];
_nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};

// create pilot1
private _pilot1 = _prisonerGroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
_x_mt_event_ar pushBack _pilot1;
_allActors pushBack _pilot1;
[_pilot1, 30] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;
removeHeadgear _pilot1;
_pilot1 unlinkItem (hmd _pilot1); //remove nvgs
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

// create 3 enemy guards with unusual hat/bandanna to help players identify them
private _hat_type = selectRandom ["H_Cap_red", "H_Cap_blu", "H_Cap_grn"];
private _bandanna_type = selectRandom ["G_Bandanna_beast", "G_Bandanna_shades", "G_Bandanna_sport", "G_Bandanna_aviator"];
private _enemyGuardGroup = ["specops", 1, "allmen", 0, _nposss , 5, false, true, 3] call d_fnc_CreateInf select 0;
{
	[_x, 30] call d_fnc_nodamoffdyn;
	_x forceSpeed 0;
	_x unlinkItem (hmd _x); //remove nvgs
	removeHeadgear _x;
	_x addHeadgear _hat_type;
	_x addGoggles _bandanna_type;
	_allActors pushBack _x;
	_x_mt_event_ar pushBack _x;
} forEach (units _enemyGuardGroup);

//find a suitable building and occupy
_buildings_array_sorted_by_distance = [[_poss, 200, nil, (count _allActors)] call d_fnc_getbuildings, _poss] call d_fnc_sortarraybydistance;
private _unitsNotGarrisoned = [];
{
	//dry run to find a suitable building
	_unitsNotGarrisoned = [getPos _x, _allActors, -1, false, false, true, false, 2, true, true, true] call d_fnc_Zen_OccupyHouse;
	if (count _unitsNotGarrisoned == 0) exitWith {
		// building is suitable
		_unitsNotGarrisoned = [getPos _x, _allActors, -1, false, false, true, false, 2, true, true] call d_fnc_Zen_OccupyHouse;
	};

} forEach _buildings_array_sorted_by_distance;

{
	//diag_log [format ["failed to garrison and will remain in starting position: %1", _x]];
} forEach _unitsNotGarrisoned;

private _all_dead = false;
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
		//a unit in enemyGuardGroup was wounded, soon guards will shoot prisoner and a bomb will explode
		_pilot1 setCaptive false;
		// brief delay until the guards attempt to execute the prisoner
		sleep 2;
		{	
			//todo - play a sound?
			_x forceSpeed -1;
		} forEach (units _enemyGuardGroup);
		// another brief delay, players must kill all guards or an explosion will occur
		sleep 5;
		if (({alive _x} count units _enemyGuardGroup) > 0) then {
			// not all of the guards were killed so a suicide bomb is triggered
			_bomb_type = "Rocket_04_HE_F"; //TODO: bigger??
			_bomb = _bomb_type createVehicle [0,0,5000];
			_bomb setPosASL eyePos _pilot1;
        };
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
