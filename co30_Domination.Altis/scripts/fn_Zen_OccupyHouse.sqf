//#define __DEBUG__
#define THIS_FILE "fn_Zen_OccupyHouse.sqf"
#include "..\x_setup.sqf"

// Infantry Occupy House
// by Zenophon
// Released under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
// http://creativecommons.org/licenses/by-nc/4.0/

// Teleports the units to random windows of the building(s) within the distance
// Faces units in the right direction and orders them to stand up or crouch on a roof
// Units will only fill the building to as many positions as there are windows
// Multiple buildings can be filled either evenly or to the limit of each sequentially
// Usage : Call, execVM
// Params: 1. Array, the building(s) nearest this position is used
//         2. Array of objects, the units that will garrison the building(s)
//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
//  (opt.) 8. Scalar
//                0 - unit is free to move immediately (default: 0)
//                1 - unit is free to move after a firedNear event is triggered
//                2 - unit is static, no movement allowed
//  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
//  (opt.) 10. Boolean, true to allow the selected position to be near an enemy (default: false)
// Return: Array of objects, the units that were not garrisoned

#define I(X) X = X + 1;
#define EVAL(X) (X call _comparator)
#define EYE_HEIGHT 1.53
#define CHECK_DISTANCE 5
#define FOV_ANGLE 10
#define ROOF_CHECK 4
#define ROOF_EDGE 2

params [
	["_center", [0,0,0], [[]], 3],
	["_units", [objNull], [[]]],
	["_buildingRadius", -1, [0]],
	["_putOnRoof", false, [true]],
	["_fillEvenly", false, [true]],
	["_sortHeight", false, [true]],
	["_doMove", false, [true]],
	["_unitMovementMode", 0, [0]],
	["_isRequireRoofOverhead", false, [true]],
	["_isAllowSpawnNearEnemy", false, [true]]
];

private [
	"_Zen_ExtendPosition",
	"_buildingsArrayFiltered",
	"_buildingPosArray",
	"_posArray",
	"_unitIndex",
	"_j",
	"_building",
	"_posArray",
	"_randomIndex",
	"_housePos",
	"_startAngle",
	"_i",
	"_checkPos",
	"_hitCount",
	"_isRoof",
	"_edge",
	"_k",
	"_array",
	"_Zen_InsertionSort",
	"_Zen_ArrayShuffle"
];

if (_center isEqualTo [0,0,0]) exitWith {
	player sideChat str "Zen_Occupy House Error : Invalid position given.";
	diag_log "Zen_Occupy House Error : Invalid position given.";
	[]
};

if (_units isEqualTo [] || {isNull (_units # 0)}) exitWith {
	player sideChat str "Zen_Occupy House Error : No units given.";
	diag_log "Zen_Occupy House Error : No units given.";
	([])
};

_Zen_ExtendPosition = {
	params ["_center", "_dist", "_phi"];

	([(_center # 0) + (_dist * (cos _phi)), (_center # 1) + (_dist * (sin _phi)), _this # 3])
};

_Zen_InsertionSort = {
	params ["_array", "_comparator"];

	if (_array isEqualTo []) exitWith {};
	
	private ["_element", "_value"];

	for "_i" from 1 to (count _array - 1) do {
		scopeName "forI";
		_element = _array select _i;
		_value = EVAL(_element);

		for [{_j = _i}, {_j >= 1}, {_j = _j - 1}] do {
			if (_value > EVAL(_array select (_j - 1))) then {
				breakTo "forI";
			};
			_array set [_j, _array select (_j - 1)];
		};

		_array set [_j, _element];
	};
};

_Zen_ArrayShuffle = {
	params ["_array"];
	if (count _array > 1) then {
		private ["_temp"];
		for "_i" from 0 to (count _array - 1) do {
			_j = _i + floor random ((count _array) - _i);
			_temp = _array select _i;
			_array set [_i, _array select _j];
			_array set [_j, _temp];
		};
	};
};

_buildingsArrayFiltered = [_center, _buildingRadius, d_side_enemy] call d_fnc_getbuildings;

_buildingPosArray = [];
0 = [_buildingsArrayFiltered] call _Zen_ArrayShuffle;
{
	_posArray = _x buildingPos -1;
	if (_posArray isNotEqualTo []) then {
		_buildingPosArray pushBack _posArray;
	};
} forEach _buildingsArrayFiltered;

__TRACE_1("","_buildingPosArray")

if (_sortHeight) then {
	{
		0 = [_x, {-1 * (_this select 2)}] call _Zen_InsertionSort;
	} forEach _buildingPosArray;
} else {
	{
		0 = [_x] call _Zen_ArrayShuffle;
	} forEach _buildingPosArray;
};

_unitIndex = 0;
for [{_j = 0}, {(_unitIndex < count _units) && {(count _buildingPosArray > 0)}}, {I(_j)}] do {
	scopeName "for";

	_building = _buildingsArrayFiltered select (_j % (count _buildingsArrayFiltered));
	_posArray = _buildingPosArray select (_j % (count _buildingPosArray));
	__TRACE_2("","_building","_posArray")

	if (count _posArray == 0) then {
		_buildingsArrayFiltered deleteAt (_j % (count _buildingsArrayFiltered));
		_buildingPosArray deleteAt (_j % (count _buildingPosArray));
	};

	while {count _posArray > 0} do {
		scopeName "while";
		__TRACE_1("","_posArray")
		if (_unitIndex >= count _units) exitWith {};

		_housePosArray = _posArray select 0;
		__TRACE_1("","_housePosArray")
		_posArray deleteAt 0;
		_housePos = [_housePosArray select 0, _housePosArray select 1, (_housePosArray select 2) + (getTerrainHeightASL _housePosArray) + EYE_HEIGHT];
		
		if (_isRequireRoofOverhead && {!((_housePos) call d_fnc_isinhouse)}) exitWith {};

		_startAngle = (round random 10) * (round random 36);
		for "_i" from _startAngle to (_startAngle + 350) step 10 do {
			_checkPos = [_housePos, CHECK_DISTANCE, 90 - _i, _housePos select 2] call _Zen_ExtendPosition;

			if !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull]) then {
				if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
					_checkPos = [_housePos, CHECK_DISTANCE, 90 - _i, (_housePos select 2) + (CHECK_DISTANCE * tan FOV_ANGLE)] call _Zen_ExtendPosition;
					if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
						_hitCount = 0;
						for "_k" from 30 to 360 step 30 do {
							_checkPos = [_housePos, 20, 90 - _k, _housePos select 2] call _Zen_ExtendPosition;
							if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
								I(_hitCount)
							};

							if (_hitCount >= ROOF_CHECK) exitWith {};
						};

						_isRoof = (_hitCount < ROOF_CHECK) && {!(lineIntersects [_housePos, [_housePos select 0, _housePos select 1, (_housePos select 2) + 25], objNull, objNull])};
						if (!_isRoof || {_isRoof && {_putOnRoof}}) then {
							if (_isRoof) then {
								_edge = false;
								for "_k" from 30 to 360 step 30 do {
									_checkPos = [_housePos, ROOF_EDGE, 90 - _k, _housePos select 2] call _Zen_ExtendPosition;
									_edge = !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) - EYE_HEIGHT - 1], objNull, objNull]);

									if (_edge) exitWith {
										_i = _k;
									};
								};
							};

							if (!_isRoof || {_edge}) then {
								private _uuidx = _units select _unitIndex;
								_uuidx doWatch ([_housePos, CHECK_DISTANCE, 90 - _i, (_housePos select 2) - (getTerrainHeightASL _housePos)] call _Zen_ExtendPosition);

								if (_doMove) then {
									_uuidx doMove ASLToATL ([_housePos select 0, _housePos select 1, (_housePos select 2) - EYE_HEIGHT]);
								} else {
									_uuidx setPosASL [_housePos select 0, _housePos select 1, (_housePos select 2) - EYE_HEIGHT];
									_uuidx setDir _i;

									doStop _uuidx;
								};

								//occupy mode - no special behavior
								if (_unitMovementMode == 0) then {
									//do nothing
								};

								//ambush mode - static until firedNear within 69m restores unit ability to move and fire
								if (_unitMovementMode == 1) then {

									if !(_doMove) then {
										_uuidx disableAI "TARGET";
										_uuidx forceSpeed 0;
									};

									_uuidx setVariable ["zen_fn_idx2", _uuidx addEventHandler ["FiredNear", {
										params ["_unit", "_firer"];
										scriptName "spawn_zoh_firednear1ambush";
										if (d_side_player getFriend side (group _firer) >= 0.6) then {
											_unit enableAI "TARGET";
											_unit enableAI "AUTOTARGET";
											_unit enableAI "MOVE";
											_unit forceSpeed -1;
										};
									}]];
								};

								//sniper mode - static forever
								if (_unitMovementMode == 2) then {
									if (d_snp_aware == 1) then {
										//highly aware snipers
										//do nothing, advanced awareness is already loaded with d_fnc_hallyg_dlegion_Snipe_awareness
									} else {
										//common snipers with up/down script triggered by firedNear within 69m but no advanced awareness
										if (_isRoof) then {
											_uuidx setUnitPos "MIDDLE";
											_uuidx setVariable ["zen_fn_idx", _uuidx addEventHandler ["FiredNear", {
												scriptName "spawn_zoh_firednear1";
												[_this # 0, ["DOWN","MIDDLE"]] spawn d_fnc_Zen_JBOY_UpDown;
											}]];
										} else {
											_uuidx setUnitPos "UP";
											_uuidx setVariable ["zen_fn_idx",_uuidx addEventHandler ["FiredNear", {
												scriptName "spawn_zoh_firednear2";
												[_this # 0, ["UP","MIDDLE"]] spawn d_fnc_Zen_JBOY_UpDown;
											}]];
										};

										if !(_doMove) then {
											_uuidx disableAI "TARGET";
											_uuidx forceSpeed 0;
										};
									};
								};
								
								//overwatch mode - static forever but without special sniper behaviors
								if (_unitMovementMode == 3) then {
									if !(_doMove) then {
										_uuidx disableAI "TARGET";
										_uuidx forceSpeed 0;
									};
								};

								I(_unitIndex)
								if (_fillEvenly) then {
									breakTo "for";
								} else {
									breakTo "while";
								};
							};
						};
					};//end if
				};//end if
			};//end if
		};//end for
	};//end while
};//end for

if (_doMove) then {
	[_units, _unitIndex, _unitMovementMode] spawn {
		scriptName "spawn_zoh_occupyhouse";
		params ["_units", "_unitIndex", "_unitMovementMode"];

		_usedUnits = _units select [0, _unitIndex];

		while {count _usedUnits > 0} do {
			sleep 1;
			_toRemove =  [];
			{
				if (unitReady _x) then {
					doStop _x;
					if (_unitMovementMode == 2) then {
						_x forceSpeed 0;
					};
					_toRemove pushBack _forEachIndex;
				};
			} forEach _usedUnits;

			_usedUnits = _usedUnits - _toRemove;
		};
	};
};

(_units select [_unitIndex, (count _units - 1) - _unitIndex])

// Changelog
// 7/21/15
	// 1. Added: Error reporting for invalid position and unit array arguments
	// 1. Added: Check and error report if no buildings are found
	// 3. Improved: Parameters 3, 4, and 5 are now optional and check for the correct type
	// 4. Improved: Parameters 6 and 7 check for the correct type
	// 5. Improved: AI should now stay in place better (thanks to JohnnyBoy)

// 7/6/15
	// 1. Added: AI now take cover when fired upon (credit to JohnnyBoy)
	// 2. Added: Parameter to order the AI to move to their position
	// 3. Improved: The order of buildings filled is now random
	// 4. Improved: A few minor optimizations

// 6/30/15
	// 1. Added: Parameter to fill buildings from top to bottom
	// 2. Improved: Optimized

// 7/31/14
	// 1. Added: Parameter to cycle through each building in the radius, giving units to each one
	// 2. Improved: Units on roof are only placed at the edge, and face the edge
	// 3. Improved: Optimized roof check
	// 4. Improved: General script cleanup

// 7/28/14
	// 1. Fixed: Units facing the wrong window
	// 2. Added: Parameter for distance to select multiple buildings
	// 3. Added: Parameter for units being on a roof
	// 4. Improved: Now checks that unit has a good FOV from the windows
	// 5. Improved: Units can no longer face a windows greater than 5 meters away
	// 6. Improved: Units on a roof now crouch
	// 7. Tweaked: Height of human eye to the exact value in ArmA

// 7/24/14
	// Initial Release

// Known Issues
	// None