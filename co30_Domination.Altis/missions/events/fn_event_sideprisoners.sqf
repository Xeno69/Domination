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
d_x_mt_event_pos = [[[_target_center, 250]],[[_target_center, 150]]] call BIS_fnc_randomPos;
d_x_mt_event_ar = [];
d_mt_event_resolved = false;

publicVariable "d_x_mt_event_pos";
private _poss = d_x_mt_event_pos;
d_x_mt_event_start = "";
private _trigger = [_poss, [225,225,0,false], [d_own_side,"PRESENT",true], ["this","d_x_mt_event_start = time",""]] call d_fnc_CreateTrigger;
publicVariable "d_x_mt_event_start";

waitUntil { !(d_x_mt_event_start isEqualTo "") };

d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisoners",d_kbtel_chan];

private _marker = ["d_mt_event_marker", _poss, "ICON","ColorBlack", [1, 1], localize "STR_DOM_MISSIONSTRING_PRISONERS", 0, "hd_start"] call d_fnc_CreateMarkerGlobal;

private _newgroup = [d_own_side] call d_fnc_creategroup;

private _distanceToEnableFriendlyMovement = 0.5; //in meters

private _allActors = [];

if (d_with_ai) then {
	_newgroup setVariable ["d_do_not_delete", true];
};
__TRACE_1("","_newgroup")
private _nposss = [];
_nposss = _poss findEmptyPosition [10, 25, d_sm_pilottype];
if (_nposss isEqualTo []) then {_nposss = _poss};
private _pilot1 = _newgroup createUnit [d_sm_pilottype, _nposss, [], 0, "NONE"];
d_x_mt_event_ar pushBack _pilot1;
_allActors pushBack _pilot1;
[_pilot1, 30] call d_fnc_nodamoffdyn;
__TRACE_1("","_pilot1")
_pilot1 call d_fnc_removenvgoggles_fak;
[_pilot1, getPos _pilot1] call d_fnc_setposagls;

private _units = [_pilot1];

{
	removeAllWeapons _x;
	_x setCaptive true;
	_x enableStamina false;
    _x enableFatigue false;
    _x disableAI "PATH";
    _x disableAI "RADIOPROTOCOL";
} forEach _units;
private _leader = leader _newgroup;
_leader setSkill 1;
_newgroup allowFleeing 0;
_newgroup deleteGroupWhenEmpty true;

private _otrig = [_leader, [800, 800, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["this", "[thisTrigger, 0] call d_fnc_trigwork", "[thisTrigger, 1] call d_fnc_trigwork"]] call d_fnc_createtriggerlocal;
_otrig setVariable ["d_objs", _units];

__TRACE_1("","_units")

if (d_with_dynsim == 0) then {
	[_newgroup] spawn d_fnc_enabledynsim;
};

sleep 2.333;

private _enemyGuardGroup = ["specops", 1, "allmen", 2, _poss , 25, false] call d_fnc_CreateInf select 0;
{
	[_x, 30] call d_fnc_nodamoffdyn;
	_x forceSpeed 0;
	_allActors pushBack _x;
	d_x_mt_event_ar pushBack _x;
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
	0,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	true,                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
	true                                                //  (opt.) 10. Boolean, true to allow the selected position to be near an enemy (default: false)
] call d_fnc_Zen_OccupyHouse;

{deleteVehicle _x} forEach _unitsNotGarrisoned;

private _hostages_reached_dest = false;
private _all_dead = false;
private _rescued = false;
private _rescuer = objNull;
private _isExecutePrisoners = false;
private _victim = objNull;

while {!_hostages_reached_dest && {!_all_dead && {!d_mt_event_resolved}}} do {                                             
	//if maintarget is done then just exit the while loop and proceed to cleanup
	if (d_mt_done) exitWith {
		d_mt_event_resolved = true;
		publicVariable "d_mt_event_resolved";
	};
	if (_units findIf {alive _x} == -1) exitWith {
		__TRACE("All dead exiting")
		_all_dead = true;
	};
	
	{
    	if (damage _x > 0.02) then {
    		//if any unit in enemyGuardGroup is wounded more than 0.15 then set flag to shoot prisoners
    		_isExecutePrisoners = true;
    	};
    } forEach (units _enemyGuardGroup);
    
    
    
    if (_isExecutePrisoners) then {
		_victim = selectRandom _units;
		_victim setCaptive false;
    };
    
    if (_isExecutePrisoners || !(captive _victim)) then {
		{	
			//todo - play a sound?
			_x forceSpeed -1;
			_enemyGuardGroup reveal [_victim, 4];
			_x doTarget _victim;
			_x doSuppressiveFire _victim;
		} forEach (units _enemyGuardGroup);
    };
    
    if (_isExecutePrisoners) then {
		sleep 5;
	};
    
	if (!_rescued) then {
		_leader = leader _newgroup;
		private _nobjs = (_leader nearEntities ["CAManBase", _distanceToEnableFriendlyMovement]) select {alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
		if !(_nobjs isEqualTo []) then {
			{
				if (alive _x && {(_x call d_fnc_isplayer) && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}) exitWith {
					_rescued = true;
					deleteVehicle _otrig;
					_rescuer = _x;
					{
						_x setCaptive false;
						_x enableAI "PATH";
					} forEach (_units select {alive _x});
					_units join _rescuer;
					doStop _units;
				};
				sleep 0.01;
			} forEach _nobjs;
		};
	} else {
		private _tmp_flag = d_FLAG_BASE;
		_hostages_reached_dest = _units findIf {alive _x && {(vehicle _x) distance2D _tmp_flag < 50 || {!isNil "d_flag_airfield" && {(vehicle _x) distance2D d_flag_airfield < 50}}}} > -1;
		
		__TRACE_1("1","_hostages_reached_dest")
		
		if (!_hostages_reached_dest) then {
			private _fidx = _units findIf {alive _x};
			if (_fidx > -1) then {
				_newgroup = group (_units # _fidx);
			};
			if !((leader _newgroup) call d_fnc_isplayer) then {
				_rescued = false;
			};
		};
	};
	sleep 3.14;
};

__TRACE_3("over","_hostages_reached_dest","_all_dead","_rescued")

if (_hostages_reached_dest) then {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersSucceed",d_kbtel_chan];
} else {
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventSidePrisonersFail",d_kbtel_chan];
};

d_mt_event_resolved = true;

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
} forEach d_x_mt_event_ar;
d_x_mt_event_ar = [];

deleteVehicle _trigger;
deleteMarker _marker;
