//#define __DEBUG__
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
// Params: 1. _center Array, the building(s) nearest this position is used
//         2. _units Array of objects, the units that will garrison the building(s)
//  (opt.) 3. _buildingRadius (_fillRadius) Scalar, radius in which to fill building(s), -1 for only nearest building but if -1 then _targetBuilding must be provided, (default: -1)
//  (opt.) 4. _putOnRoof (_fillRoof) Boolean, true to put units on the roof, false for only inside, (default: false)
//  (opt.) 5. _fillEvenly Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
//  (opt.) 6. _sortHeight (_fillTopDown) Boolean, true to fill from the top of the building down, (default: false)
//  (opt.) 7. _doMove (_disableTeleport) Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
//  (opt.) 8. _unitMovementMode Scalar
//                0 - (occupy) unit is free to move immediately (default: 0)
//                1 - (ambush) unit is free to move after a firedNear event is triggered  at 35m
//                2 - (sniper) unit is static, no movement allowed
//                3 - (overwatch) unit is static, free to move after firedNear event at very close range
//  (opt.) 9. _isRequireRoofOverhead Boolean, true to force position selection such that the unit has a roof overhead
//  (opt.) 10. _isAllowSpawnNearEnemy Boolean, true to allow the selected position to be near an enemy (default: false)
//  (opt.) 11. _isDryRun Boolean, true to dry run, for testing only no units are moved, still returns array of units that could not be garrisoned at given pos (default: false)
//  (opt.) 12. _distanceFromBuildingCenter Scalar, distance a unit may be placed from the center of a building (usually safer) or -1 for any (default: -1)
//  (opt.) 13. _targetBuilding Object, target building may be passed
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
	["_buildingRadius", 5, [0, objNull]],
	["_putOnRoof", false, [true]],
	["_fillEvenly", false, [true]],
	["_sortHeight", false, [true]],
	["_doMove", false, [true]],
	["_unitMovementMode", 0, [0]],
	["_isRequireRoofOverhead", false, [true]],
	["_isAllowSpawnNearEnemy", false, [true]],
	["_isDryRun", false, [true]],
	["_distanceFromBuildingCenter", -1, [0, objNull]],
	["_targetBuilding", objNull]
];

__TRACE_1("","_this")

private [
	"_Zen_ExtendPosition",
	"_j",
	"_building",
	"_randomIndex",
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

private _positionsUsed = [];

if (_center isEqualTo [0,0,0]) exitWith {
	[0, "Zen_Occupy House Error : Invalid position given."] call d_fnc_sideorsyschat;
	diag_log "Zen_Occupy House Error : Invalid position given.";
	[]
};

if (_units isEqualTo [] || {isNull (_units # 0)}) exitWith {
	[0, "Zen_Occupy House Error : No units given."] call d_fnc_sideorsyschat;
	diag_log "Zen_Occupy House Error : No units given.";
	([])
};

_Zen_ExtendPosition = {
	params ["_center", "_dist", "_phi", "_z"];

	([(_center # 0) + (_dist * (cos _phi)), (_center # 1) + (_dist * (sin _phi)), _z])
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

_spawn_script_enable_movement = {
	params ["_uuidx"];
	_uuidx spawn {
		scriptName "allow movement if d_priority_targets isNotEqualTo []";
		while { true } do {
			sleep 10 + random 5;
			if (d_priority_targets isNotEqualTo []) then {
				private _ptarget = d_priority_targets # 0;
				_this forceSpeed -1;
				_this doMove getPosATL _ptarget;
				sleep 3;
				// shoot at the priority target if visible to the unit
				if ([_this, _ptarget] call d_fnc_isvisible) then {
					_this doTarget _ptarget;
					_this doSuppressiveFire (getPosASL _ptarget);
				};
			};
		};
	};
};

_check_vertical_jumps = {
	params ["_uuidx"];
	_uuidx spawn {
		scriptName "check if unit is vertically jumping and delete if true";
		sleep 3;
		private _startposz = (getPosASL _this) select 2;
		sleep 3; 
		private _posz = (getPosASL _this) select 2;
		if (_posz != _startposz) exitWith {
			// found a jumper (unit hovers up and down)
			deleteVehicle _this;
		};
	};
};

private _buildingsArrayFiltered = [];

// use targetBuilding if it was passed
if !(isNull _targetBuilding) then {
	//diag_log [format ["occupy script was passed a target building with %1 positions: %2", count (_targetBuilding buildingPos -1), _targetBuilding]];
	_buildingsArrayFiltered = [_targetBuilding];
} else {
	_buildingsArrayFiltered = [_center, _buildingRadius] call d_fnc_getbldgswithpositions;
	if (count _buildingsArrayFiltered == 0) then {
		__TRACE_2("Error no buildings were found","_buildingRadius","_center")
    } else {
    	//diag_log [format ["occupyhouse found suitable building list: %1", _buildingsArrayFiltered]];
    };
};

private _buildingPosArray = [];

{
	private _parray = _x buildingPos -1;
	// some buildings in the safe list have one or more bad position, remove bad positions here
	if (["chapel_v1_f", toLowerANSI (getModelInfo _x # 0)] call BIS_fnc_inString) then {
		_parray deleteAt 1;
	};
	// add positions
	_buildingPosArray pushBack _parray;
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

__TRACE_1("placing units count","count _units")
private _unitIndex = 0;
private _tmpPosArray = [];
private _theBuilding = nil;
private _skipAngleCheck = false;
__TRACE("start of forEach _buildingPosArray")
{
	scopeName "for";
	private _posArray = _x;
	__TRACE_1("posArray", "_posArray")

	if (count _posArray == 0) then {
		diag_log ["_posArray is empty, non-fatal but should never happen (causes the next 'while' loop to be skipped)"];
	};

	while {count _posArray > 0} do {
		scopeName "while";
		__TRACE_1("","_posArray")
		if (_unitIndex >= count _units) exitWith {
			//diag_log ["all units have been placed! exiting while loop."];
		};
		private _skip_position = false;
		private _housePosBeforeEyeHeight = _posArray select 0;
		__TRACE_1("","_housePosBeforeEyeHeight")
		_posArray deleteAt 0;
		private _housePos = [_housePosBeforeEyeHeight select 0, _housePosBeforeEyeHeight select 1, (_housePosBeforeEyeHeight select 2) + (getTerrainHeightASL _housePosBeforeEyeHeight) + EYE_HEIGHT];
		// must re-detect the building object
		private _bldgs_list = [];
		if !(isNull _targetBuilding) then {
			//diag_log ["target building was provided, no need to redetect"];
			_theBuilding = _targetBuilding;
		} else {
			// collect a list of buildings so we can attempt to redetect the target building
			_bldgs_list = [_housePos, 199] call d_fnc_getbldgswithpositions;
		};
		
		if (_bldgs_list isEqualTo [] && {isNil "_theBuilding"}) then {
			diag_log ["position skipped, unexpectedly could not get the building object"];
			_skip_position = true;
		} else {
			if (count _bldgs_list > 1 && {isNil "_theBuilding"}) then {
				//diag_log [ format ["there are %1 buildings in the array, selecting the first element", count _bldgs_list]];
				_theBuilding = _bldgs_list select 0;
			};
		};
		// NOTE - next part has problems, disabling for now
		//if (!_skip_position && {_isRequireRoofOverhead && {!((_housePosBeforeEyeHeight) call d_fnc_iscoveredposition)}}) then {
		//	diag_log ["position skipped, position must be covered with building overhead"];
		//	_skip_position = true;
		//};
		if (!_skip_position && {!isNil "_theBuilding"}) then {
			//diag_log [format ["_theBuilding is provided: %1", _theBuilding]];
			//diag_log [format ["position checking... distance from center: %1 --- %2", (_housePos distance2D _theBuilding), _distanceFromBuildingCenter]];
		};
		if (!_skip_position && {!isNil "_theBuilding" && {_distanceFromBuildingCenter > 0 && {(_housePos distance2D _theBuilding) > _distanceFromBuildingCenter}}}) then {
			// the position is too far from the center of the building (limit is set by parameter)
			//diag_log [format ["position skipped, too far from center: distance %1 > _distanceFromBuildingCenter %2", (_housePos distance2D _theBuilding), _distanceFromBuildingCenter]];
			_skip_position = true;
		};
		// disabled for now, allow civilians to spawn above the first floor
		//if (!_skip_position && {!isNil "_theBuilding" && {((_housePos # 2) - (getTerrainHeightASL _housePos)) > 6}} && side (_units select _unitIndex) == civilian) then {
		//	// the position is too high above the terrain for a civilian unit (prevents putting them in sniper locations)
		//	//diag_log [format ["position skipped, too high: height above terrain is %1 > 6", ((_housePos # 2) - (getTerrainHeightASL _housePos))]];
		//	_skip_position = true;
		//};
		sleep 0.01;
		if (!_skip_position && {!isNil "_theBuilding" && {side (_units select _unitIndex) == civilian}}) then {
			// use dimensions from boundingBoxReal to check if the position is too near the edges of the building
			// this helps avoid placing civilians in exposed positions (balcony, front porch, etc.) but it's not perfect
			private _bbr = boundingBoxReal _theBuilding;
			private _pmin = _bbr select 0;
			private _pmax = _bbr select 1;
			private _pcenter = getPos _theBuilding;
			private _minx = _pcenter # 0 + _pmin # 0 + (0.65*abs(_pmin # 0));
			if (_housePos # 0 < _minx) then {
				//diag_log ["x axis failed min"];
				_housePos set [0, _minx];
			};
			private _maxx = _pcenter # 0 + _pmax # 0 - (0.65*abs(_pmax # 0));
			if (_housePos # 0 > _maxx) then {
				//diag_log ["x axis failed max"];
				_housePos set [0, _maxx];
			};
			private _miny = _pcenter # 1 + _pmin # 1 + (0.65*abs(_pmin # 1));
			if (_housePos # 1 < _miny) then {
				//diag_log ["y axis failed min"];
				_housePos set [1, _miny];
			};
			private _maxy = _pcenter # 1 + _pmax # 1 - (0.65*abs(_pmax # 1));
			if (_housePos # 1 > _maxy) then {
				//diag_log ["y axis failed max"];
				_housePos set [1, _maxy];
			};
		};
		if (!_skip_position && {(d_cur_tgt_building_positions_occupied find _housePos) != -1}) then {
			//diag_log ["we already used this position, force to reuse as a fuzzy position"];
			_positionsUsed pushBack _housePos;
			_skip_position = true;
		};
		if (!_skip_position && {!isNil "_theBuilding" && {side (_units select _unitIndex) == civilian}}) then {
			// skip the angle check when placing a civilian unit
			_skipAngleCheck = true;
		};

		if !(_skip_position) then {
			_startAngle = (round random 10) * (round random 36);
			for "_i" from _startAngle to (_startAngle + 350) step 10 do {
				_checkPos = [_housePos, CHECK_DISTANCE, 90 - _i, _housePos select 2] call _Zen_ExtendPosition;
				if (!lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull] || {_skipAngleCheck}) then {
					if (!lineIntersects [_housePos, _checkPos, objNull, objNull] || {_skipAngleCheck}) then {
						_checkPos = [_housePos, CHECK_DISTANCE, 90 - _i, (_housePos select 2) + (CHECK_DISTANCE * tan FOV_ANGLE)] call _Zen_ExtendPosition;
						if (!lineIntersects [_housePos, _checkPos, objNull, objNull] || {_skipAngleCheck}) then {
							_hitCount = 0;
							for "_k" from 30 to 360 step 30 do {
								_checkPos = [_housePos, 20, 90 - _k, _housePos select 2] call _Zen_ExtendPosition;
								if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
									I(_hitCount)
								};
	
								if (_hitCount >= ROOF_CHECK) exitWith {
									//diag_log [format ["stopped checking steps at: %1 _hitCount equal to ROOF_CHECK: %2", _k, ROOF_CHECK]];
								};
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
								
								sleep 0.01;
	
								if (!_isRoof || {_edge}) then {
									if (!_isDryRun) then {
										
										// success
										__TRACE_1("we found a good position and a good direction","_unitIndex")
										
										_positionsUsed pushBack _housePos;
									
										private _housePosFinal = _housePos;
																			
										if ((d_cur_tgt_building_positions_occupied find _housePos) == -1) then {
											d_cur_tgt_building_positions_occupied pushBack _housePos;
										} else {
											_housePosFinal = [ _housePos ] call d_fnc_getfuzzyposition;
										};
										
										private _uuidx = _units select _unitIndex;
										_uuidx doWatch ([_housePosFinal, CHECK_DISTANCE, 90 - _i, (_housePosFinal select 2) - (getTerrainHeightASL _housePosFinal)] call _Zen_ExtendPosition);
									
										if (_doMove) then {
											_uuidx doMove ASLToATL ([_housePosFinal select 0, _housePosFinal select 1, (_housePosFinal select 2) - EYE_HEIGHT]);
										} else {
											_uuidx setPosASL [_housePosFinal select 0, _housePosFinal select 1, (_housePosFinal select 2) - EYE_HEIGHT];
											_uuidx setDir _i;
		
											doStop _uuidx;
											[_uuidx] call _check_vertical_jumps;
											_uuidx 
										};
		
										//occupy mode - no special behavior
										if (d_with_MainTargetEvents != 0 && {_unitMovementMode == 0}) then {
											//do nothing, unit is free to move
											//enable priority movement
											[_uuidx] call _spawn_script_enable_movement;
										};
		
										//ambush mode - static until firedNear within 35m restores unit ability to move and fire or if d_priority_targets is not empty
										if (_unitMovementMode == 1) then {
		
											if !(_doMove) then {
												_uuidx disableAI "TARGET";
												_uuidx forceSpeed 0;
											};
		
											if (isNil {_uuidx getVariable "zen_fn_idx1"}) then {
												_uuidx setVariable ["zen_fn_idx1", _uuidx addEventHandler ["FiredNear", {
													__TRACE_1("firednear -1","_this")
													params ["_unit", "_firer", "_distance"];
													scriptName "spawn_zoh_firednear1ambush";
													
													// enable movement if firedNear by enemy
													if (d_side_enemy getFriend side (group _firer) < 0.6 && {_distance < 35 && {(_this # 6) isKindOf ["BulletCore", configFile >> "CfgAmmo"]}}) then {
														_unit enableAI "TARGET";
														_unit enableAI "AUTOTARGET";
														_unit enableAI "MOVE";
														_unit forceSpeed -1;
														_unit removeEventHandler ["FiredNear", _thisEventHandler];
													};
													
													// enable movement if hit
													if (isNil {_uuidx getVariable "d_zen_hiteh"}) then {
														_uuidx setVariable ["d_zen_hiteh", _uuidx addEventHandler ["Hit", {
														__TRACE_1("hit 1","_this")
															params ["_unit", "_source", "_damage", "_instigator"];
															scriptName "spawn_zoh_hiteh";
															_unit enableAI "TARGET";
															_unit enableAI "AUTOTARGET";
															_unit enableAI "MOVE";
															_unit forceSpeed -1;
															_unit removeEventHandler ["Hit", _thisEventHandler];
														}]];
													};
													
												}]];
											};
											//enable priority movement
											if (d_with_MainTargetEvents!= 0) then {
												[_uuidx] call _spawn_script_enable_movement;
											};
										};
										
										sleep 0.01;
		
										//sniper mode - static forever
										if (_unitMovementMode == 2) then {
											if (d_snp_aware == 1) then {
												//highly aware snipers
												//do nothing, advanced awareness is already loaded with d_fnc_hallyg_dlegion_Snipe_awareness
											} else {
												//common snipers with up/down script triggered by firedNear within 69m but no advanced awareness
												if (_isRoof) then {
													_uuidx setUnitPos "MIDDLE";
													__TRACE_1("setupos MIDDLE","_uuidx")
													if (isNil {_uuidx getVariable "d_zen_fneh"}) then {
														__TRACE_1("add firednear 0","_uuidx")
														_uuidx setVariable ["d_zen_fneh", _uuidx addEventHandler ["FiredNear", {
															__TRACE_1("firednear 0","_this")
															scriptName "spawn_zoh_firednear1";
															[_this # 0, ["DOWN", "MIDDLE"], unitPos (_this # 0), 0] spawn d_fnc_Zen_JBOY_UpDown;
															(_this # 0) removeEventHandler ["FiredNear", _thisEventHandler];
														}]];
													};
												} else {
													_uuidx setUnitPos "UP";
													__TRACE_1("setupos UP","_uuidx")
													if (isNil {_uuidx getVariable "d_zen_fneh"}) then {
														__TRACE_1("add firednear 0","_uuidx")
														_uuidx setVariable ["d_zen_fneh", _uuidx addEventHandler ["FiredNear", {
															__TRACE_1("firednear 1","_this")
															scriptName "spawn_zoh_firednear2";
															[_this # 0, ["UP", "MIDDLE"], unitPos (_this # 0), 1] spawn d_fnc_Zen_JBOY_UpDown;
															(_this # 0) removeEventHandler ["FiredNear", _thisEventHandler];
														}]];
													};
												};
		
												if !(_doMove) then {
													_uuidx disableAI "TARGET";
													_uuidx forceSpeed 0;
												};
											};
										};
										
										//overwatch mode - static but without special sniper behaviors, movement is allowed after an enemy fires a weapon nearby
										if (_unitMovementMode == 3) then {
											if !(_doMove) then {
												_uuidx disableAI "TARGET";
												_uuidx forceSpeed 0;
											};
											
											//enable priority movement
											if (d_with_MainTargetEvents != 0) then {
												[_uuidx] call _spawn_script_enable_movement;
											};
											
											if (isNil {_uuidx getVariable "d_zen_fneh2"}) then {
												_uuidx setVariable ["d_zen_fneh2", _uuidx addEventHandler ["FiredNear", {
												__TRACE_1("firednear 2","_this")
													params ["_unit", "_firer", "_distance"];
													scriptName "spawn_zoh_firednear3overwatch";
													// enable movement if _firer is an enemy and within 13m
													if (d_side_enemy getFriend side (group _firer) < 0.6 && {_distance < 13 && {(_this # 6) isKindOf ["BulletCore", configFile >> "CfgAmmo"]}}) then {
														_unit enableAI "TARGET";
														_unit enableAI "AUTOTARGET";
														_unit enableAI "MOVE";
														_unit forceSpeed -1;
														_unit removeEventHandler ["FiredNear", _thisEventHandler];
													};
												}]];
											};
											
											// enable movement if hit
											if (isNil {_uuidx getVariable "d_zen_hiteh"}) then {
												_uuidx setVariable ["d_zen_hiteh", _uuidx addEventHandler ["Hit", {
												__TRACE_1("hit 1","_this")
													params ["_unit", "_source", "_damage", "_instigator"];
													scriptName "spawn_zoh_hiteh";
													_unit enableAI "TARGET";
													_unit enableAI "AUTOTARGET";
													_unit enableAI "MOVE";
													_unit forceSpeed -1;
													_unit removeEventHandler ["Hit", _thisEventHandler];
												}]];
											};
										};
										// check if civilian was misplaced and delete if civ unit is not in a house
										// NOTE - next part has problems and erroneously deletes the unit, skipping for now
										//if (side (_units select _unitIndex) == civilian && {!(((_units select _unitIndex)) call d_fnc_isinhouse)}) then {
										//	diag_log ["static civ unit is not in a house, deleting the civ unit now"];
										//	d_cur_tgt_civ_units deleteAt (d_cur_tgt_civ_units find (_units select _unitIndex));
										//	deleteVehicle (_units select _unitIndex);
										//};
										if (side _uuidx == civilian) then {
											_uuidx setVariable ["civ_startpos", getPos _uuidx];
										};
									};//end if _isDryRun
									I(_unitIndex)
									if (_fillEvenly) then {
										breakTo "for";
									} else {
										breakTo "while";
									};
								} else {
									__TRACE("position skipped, roof or edge")
								};//end if
							};//end if
						};//end if
					};//end if
				};//end if
			};//end for
			//diag_log ["could not find a suitable angle, skipping this position"];
		} else {
			//diag_log [format ["position was skipped and %1 positions remain", count _posArray]];
		};//end if (_skip_position)
	};//end while
} forEach _buildingPosArray;

__TRACE("end of forEach _buildingPosArray")

if (_unitIndex < count _units && {!isNil "_theBuilding"}) then {
	//diag_log [format ["only %1 units out of %2 total units were moved", _unitIndex, count _units]];
	for [{_k = _unitIndex}, {(_k < count _units)}, {I(_k)}] do {
		private _unit = _units select _k;
		private _attempts = 0;
		private _foundgood = false;
		// try to place unit in a fuzzy location until successful or max attempts reached
		while {_attempts < 99 && {!_foundgood}} do {
			_attempts = _attempts + 1;
			private _targetPos = getPos _theBuilding;
			private _targetPosFuzzy = [_targetPos, (sizeOf typeOf _theBuilding) / 4] call d_fnc_getfuzzyposition;
			sleep 0.01;
			// create an actual unit/group to ensure a non-colliding position, get the unit pos and then delete the unit/group
			private _civgrptemp = createGroup civilian;
			private _civtemp = _civgrptemp createUnit ["C_man_1", _targetPosFuzzy, [], 0, "NONE"];
			if (isNil "_civtemp" || {getPos _civtemp # 0 < 100 || {getPos _civtemp # 1 < 100}}) then {
				if (isNil "_civtemp") then {
					//diag_log [format ["bad position, could not spawn %1", _attempts]];
				} else {
					//diag_log [format ["bad position %1 %2", _attempts, getPos _civtemp]];
					deleteVehicle _civtemp;
				};
				deleteGroup _civgrptemp;
			} else {
				private _targetPosFuzzyUnit = getPos _civtemp;
				deleteVehicle _civtemp;
				deleteGroup _civgrptemp;
				__TRACE_2("placing a unit in a non-standard position, raw fuzzy position and unit fuzzy position", "_targetPosFuzzy", "_targetPosFuzzyUnit")
				_unit setVehiclePosition [[_targetPosFuzzyUnit # 0, _targetPosFuzzyUnit # 1], [], 1.7, "NONE"];
				if (side _unit == civilian) then {
					_unit setVariable ["civ_startpos", getPos _unit];
				};
				_foundgood = true;
			};
		};
		if (isNil "_civtemp" || {!_foundgood || {getPos _civtemp # 0 < 100 || {getPos _civtemp # 1 < 100 || {side _unit == civilian && {!((_unit) call d_fnc_isinhouse)}}}}}) then {
			__TRACE("still a bad position after 99 attempts, giving up and removing the unit")
			if (side _unit == civilian) then {
				d_cur_tgt_civ_units deleteAt (d_cur_tgt_civ_units find _unit);
			};
			deleteVehicle _unit;
		};
	};
};

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