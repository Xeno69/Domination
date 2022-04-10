// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_centerPos",
	"_maxNumUnits",			// limits but does not increase the size of the team, -1 for no max
	"_fillRadius",
	"_fillRoof",
	"_fillEvenly",
	"_fillTopDown",
	"_disableTeleport",
	"_unitMovementMode"		// passed to zen_occupyhouse and also used in this script to determine which units to create
							// if (_unitMovementMode == 2) then "sniper" else "allmen"
];

__TRACE("from createmaintarget garrison function")

__TRACE_1("_garrisonUnits","_this")

private _unitlist = [["allmen", "sniper"] select (_unitMovementMode == 2), d_enemy_side_short] call d_fnc_getunitlistm;

__TRACE_1("","_unitlist")

if (_maxNumUnits > 0 && {count _unitlist > _maxNumUnits}) then {
	while {count _unitlist > _maxNumUnits} do {
		_unitlist deleteAt (ceil (random (count _unitlist - 1)));
	};
};

private _newgroup = [d_side_enemy] call d_fnc_creategroup;

if (_unitMovementMode == 2) then {
	//give the sniper group a random name prefixed with "Sniper" as a hint for d_fnc_makemgroup
	_sniperGrpName = format["Sniper%1", floor(random 999999)];
	_newgroup setGroupId [_sniperGrpName];
};

#ifndef __TT__
private _units_to_garrison = [_centerPos, _unitlist, _newgroup, false, true, -1, d_side_player] call d_fnc_makemgroup;
//private _units_to_garrison = ([_centerPos, _unitlist, _newgroup, false, true, -1, d_side_player] call d_fnc_makemgroup) + ([_centerPos, _unitlist, _newgroup, false, true, -1, d_side_player] call d_fnc_makemgroup);
#else
private _units_to_garrison = [_centerPos, _unitlist, _newgroup, false, true, -1, [blufor, opfor]] call d_fnc_makemgroup;
#endif
if (_unitMovementMode == 2) then {
	{
		_x disableAI "PATH";
		_x forceSpeed 0;
		_x setUnitPos "UP";
	} forEach _units_to_garrison;
};
sleep 0.2;
//_newgroup allowFleeing 0;
//_newgroup setVariable ["d_defend", true];
//[_newgroup, _poss] spawn d_fnc_taskDefend;
if (d_with_dynsim == 0) then {
	[_newgroup, 0] spawn d_fnc_enabledynsim;
};

_units_to_garrison = _units_to_garrison - [objNull];
__TRACE_1("","_units_to_garrison")

//AI soldiers will be garrisoned in a building (window/roof)
__TRACE("Placing units in a building...")
//occupy a building using Zenophon script
_unitsNotGarrisoned = [
	_centerPos,											// Params: 1. Array, the building(s) nearest this position is used
	_units_to_garrison,									//         2. Array of objects, the units that will garrison the building(s)
	_fillRadius,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
	_fillRoof,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
	_fillEvenly,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
	_fillTopDown,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
	_disableTeleport,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
	_unitMovementMode,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	false //true                                                //  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead // todo - fix the roof check, currently disqualifies many top floor position when set to true
] call d_fnc_Zen_OccupyHouse;
sleep 0.01;
__TRACE_1("","_unitsNotGarrisoned")
_units_to_garrison = _units_to_garrison - _unitsNotGarrisoned;
if !(_unitsNotGarrisoned isEqualTo []) then {
	diag_log [format ["units not garrisoned and will be deleted: %1", _unitsNotGarrisoned joinString "/"]];
};
{deleteVehicle _x} forEach _unitsNotGarrisoned;
if (_units_to_garrison isEqualTo []) exitWith {
	deleteGroup _newgroup;
};
/* Removed for now, garrison groups should not respawn at main target respawn barracks (it's getting too much when there are about 40 players on the server)
if (d_mt_respawngroups == 0) then {
	{
		[_x, 3] call d_fnc_setekmode;
	} forEach _units_to_garrison;
	_newgroup setVariable ["d_respawninfo", ["specops", [], _centerPos, 0, "patrol2", d_side_enemy, 0, 0, 1, [_centerPos, _radius], false, []]];
};*/
_newgroup call d_fnc_addgrp2hc;
__TRACE_1("","_newgroup")
__TRACE_1("","_units_to_garrison")

_units_to_garrison
