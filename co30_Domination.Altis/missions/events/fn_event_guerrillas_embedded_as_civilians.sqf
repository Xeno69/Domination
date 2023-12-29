// by Longtime
//#define __DEBUG__
#include "..\..\x_setup.sqf"

#ifdef __TT__
//do not run this event in TvT (for now)
if (true) exitWith {};
#endif

// units in plain clothes will fight if the player fires within 30m
// units may fight as an independent or join the player's group depending on the call parameters

if !(isServer) exitWith {};

params [
	["_target_radius", ""],
	["_target_center", ""],
	["_join_player", false] // deprecated
];

private _buildings = [_target_center, (_target_radius * 0.75)] call d_fnc_getbldgswithpositions;
if (count _buildings < 1) exitWith {};

private _eventDescription = localize "STR_DOM_MISSIONSTRING_CIV_RESISTANCE";
d_mt_event_messages_array pushBack _eventDescription;
publicVariable "d_mt_event_messages_array";

d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTEventCivResistance",d_kbtel_chan];

private _guerrilla_uniforms = ["U_IG_Guerilla1_1",
 "U_IG_Guerilla2_1",
 "U_IG_Guerilla2_2",
 "U_IG_Guerilla2_3",
 "U_IG_Guerilla3_1",
 "U_IG_Guerilla3_2",
 "U_IG_leader"];

private _newgroups = [];
private _newunits = [];
private _guerrillaBaseSkill = 0.5;

// calculate the sum of all groups of AI
private _targetGroupCount = d_occ_cnt_current + d_ovrw_cnt_current + d_amb_cnt_current + d_grp_cnt_footpatrol;

private _guerrillaGroupCount = round(_targetGroupCount / 3) min 5;
private _guerrillaForce = [];
for "_i" from 0 to _guerrillaGroupCount do {
	_guerrillaForce pushBack "allmen";
};

{
	if (_buildings isEqualTo []) exitWith {};
	private _bldg = selectRandom _buildings;
	_buildings deleteAt (_buildings find _bldg);
	_posArray = _bldg buildingPos -1;
	private _unitlist = [_x, "G"] call d_fnc_getunitlistm;
	private _newgroup = [independent] call d_fnc_creategroup;
	private _unitCount = 4;
	if (count _posArray < _unitCount) then {
		_unitCount = count (_posArray);
	};
	private _spawn_pos = selectRandom _posArray;
	private _units = [_spawn_pos, _unitlist, _newgroup, false, true, _unitCount, true] call d_fnc_makemgroup;
	_newgroup setCombatMode "BLUE";
	private _unitsNotGarrisoned = [_spawn_pos, _units, 10, false, false, true, false, 0, true, true] call d_fnc_Zen_OccupyHouse;
	{		
		_x setSkill _guerrillaBaseSkill;
		_x setSkill ["spotTime", 0.6];
		_x setSkill ["spotDistance", 0.6];
		_x setSkill ["courage", 1];
		_x setSkill ["commanding", 1];
		// guerillas are inactive (captive)
		_x setCaptive true;
		_x forceSpeed 0;
		_x addEventHandler ["handleHeal", {call d_fnc_handleheal}];
		// guerillas dressed in plain clothes and look like civs
		removeGoggles _x;
		removeHeadgear _x;
		#ifdef __VN__
			_x addHeadgear selectRandom ["vn_c_conehat_01", "vn_c_conehat_02"];
		#endif
		removeVest _x;
		removeUniform _x;
		_x removeWeaponGlobal (handgunWeapon _x);
		_x removeWeaponGlobal (secondaryWeapon _x);
		_x setVariable ["d_primary_weapon", primaryWeapon _x];
		_x setVariable ["d_primary_weapon_magazine", primaryWeaponMagazine _x];
		_x removeWeaponGlobal (primaryWeapon _x);
		_x addUniform (selectRandom _guerrilla_uniforms);
		private _hmd = hmd _x;
		if (_hmd != "" && {getText(configFile>>"CfgWeapons">>_hmd>>"simulation") == "NVGoggles"}) then {
			_x unlinkItem _hmd;
		};
		if (_join_player) then {
			_x setVariable ["_join_player", true];
		};
		// guerrillas are triggered by the friendly side fighting nearby
		_x addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			if (captive _unit && {_firer call d_fnc_isplayer && {_unit distance2D _firer < 30 }}) then {
				// a player shooting near this unit has inspired his entire group to fight!
				{
					// restore weapons
					private _primary_weapon = _x getVariable "d_primary_weapon";
					private _primary_weapon_magazine = (_x getVariable "d_primary_weapon_magazine") select 0;
					_x addWeaponGlobal _primary_weapon;
					// restore ammo
					if (isNull (unitBackpack _x)) then {
						// units will only have a few magazines without a backpack
						_x addBackpack "B_HuntingBackpack";
					};
					private _mag_count = 0;
					while { _mag_count < 10} do {
						_x addMagazineGlobal _primary_weapon_magazine;
					};
					_x selectWeapon _primary_weapon;
					_x setCaptive false;
					_x forceSpeed -1;
					group _x setCombatMode "RED";
					group _x setSpeedMode "FULL";
					group _x setBehaviour "COMBAT";
					if (_x getVariable "_join_player" && {(count units group _firer < 10)}) then {
						[_x] join (group _firer);
					};
				} forEach units group _unit;
			};
		}];
		_newunits pushBack _x;
	} forEach _units;
	_newgroups pushBack _newgroup;
	if (d_with_dynsim == 0) then {
		[_newgroup, 0] spawn d_fnc_enabledynsim;
	};
} forEach _guerrillaForce;

private _start_ts = time;
while {sleep 5; !d_mt_done} do {
	private _foundAlive = _newunits findIf {alive _x} > -1;
	if (!_foundAlive) exitWith {};
	if (time - _start_ts > 30) then { 
		_start_ts = time;
		// occasionally replenish guerrilla ammo
		{
			_x setVehicleAmmo 1;
		} forEach _newunits;
	};
};

//cleanup
{
	deleteVehicle _x;
} forEach _newunits;
d_mt_event_messages_array deleteAt (d_mt_event_messages_array find _eventDescription);
publicVariable "d_mt_event_messages_array";
