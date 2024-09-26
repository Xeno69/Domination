//#define __DEBUG__
#include "..\x_setup.sqf"

//create civilian vehicles
//adapted from script by h8ermaker https://www.youtube.com/watch?v=pE47H8lG8uc

_make_veh = {
	params ["_pos", "_veh_type", "_direction", "_current_road"];
	private _veh = _veh_type createVehicle _pos;
	// measure distance from center, a midline is created by two points (road begPos and endPos) and the third point is the center position of the vehicle
	// If the line passes through two points P1=(x1,y1) and P2=(x2,y2) then the distance of (x0,y0) from the line is:
	private _P1 = (getRoadInfo _current_road) select 6; // road begPos
	private _P2 = (getRoadInfo _current_road) select 7; // road endPos
	// P1
	private _x1 = _P1 select 0;
	private _y1 = _P1 select 1;
	// P2
	private _x2 = _P2 select 0;
	private _y2 = _P2 select 1;
	// (x0, y0)
	private _x0 = (getPos _veh) select 0;
	private _y0 = (getPos _veh) select 1;
	// calculate
	private _distanceFromCenterLineOfRoad = abs((_y2 - _y1) * _x0 - (_x2 - _x1) * _y0 + (_x2 * _y1) - (_y2 * _x1)) / (_P1 distance2D _P2);
	// vehicle checks
	// check the vehicle after it is created, actual position may not be the same as _pos
	private _minDistanceFromCenterLineOfRoad = 0.75;
	private _maxDistanceFromCenterLineOfRoad = 5;
	if (_distanceFromCenterLineOfRoad < _minDistanceFromCenterLineOfRoad) exitWith {
		// too close to the center line, delete the vehicle and exit
		deleteVehicle _veh;
	};
	if (_distanceFromCenterLineOfRoad > _maxDistanceFromCenterLineOfRoad) exitWith {
		// too far from the center line, delete the vehicle and exit
		deleteVehicle _veh;
	};
	if (count (_veh nearRoads 15) > 2) exitWith {
		// too many nearroads and might be an intersection, delete the vehicle and exit
		deleteVehicle _veh;
	};
	// vehicle created successfully, add vehicle to global array
	d_cur_tgt_civ_vehicles pushBack _veh;
	// remove cargo items, some cars initialize with items
	clearItemCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearWeaponCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	if (d_enable_civ_vehs_locked == 1) then {
		_veh lockInventory true;
		_veh lockCargo true;
		_veh lock true;
		_veh setVehicleLock "LOCKED";
	};
	_veh allowDamage false;
	if (_direction isNotEqualTo []) then {
		_veh setdir _direction;
	};
	// make the damage to cars better by preventing unrealistic car explosions and adding more realistic shattering of glass
	_veh addEventHandler ["HandleDamage",{
		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
		// glass or sklo (Czech)
		if (["glass", _selection] call BIS_fnc_inString || { ["sklo", _selection] call BIS_fnc_inString }) then {
			// special handling for glass only
			_ammoConfig = configFile >> "CfgAmmo" >> _projectile;
			_isExplosive = if (getNumber (_ammoConfig >> "indirectHitRange") > 0.2 || !(_directHit) || ["HE", _projectile] call BIS_fnc_inString) then { true } else { false };
			if (_isExplosive && { random 100 > 50 }) then {
				// explosion damage, handle glass damage differently
				99
			} else {
				if (_unit getHit _selection > 2) then {
					// lots of hit damage, glass will be completely shattered
					// do not modify the damage, do nothing and let the glass shatter
				} else {;
					if ((_unit getHitIndex _hitIndex) < 1) then {
						// glass is not already completely shattered
						if (_unit getHit _selection > 0.9) then {
							_damage = 0.9; // glass completely shatters if damage is 1, don't let it completely break from bullet damage
						} else {
							_damage = (_damage * 3) min 0.9; // make the glass damage value higher, car glass doesn't show visible damage at low values
						};
					};
				};
			};			
		} else {
			// handling for general damage
			if (_damage > 0.89) then {
				_damage = 0.89; // max damage to prevent exploding
			};
		};
		_damage;
	}];
	if (d_enable_civ_vehs_damaged_appearance == 1) then {
		_veh setVariable ["d_damage_this_vehicle", true];
	};
};

if (d_enable_civ_vehs > 0) then {
	// all roads in defined civ radius
	private _road_seg_list_raw = _trg_center nearroads d_enable_civ_vehs_rad;
	
	// remove bad road segments
	private _road_seg_list_filtered = _road_seg_list_raw select {
		// road segment is not empty and road segment is not pedestrian and road segment is not bridge and road segment is ROAD or MAIN ROAD
		//_x isNotEqualTo [] && { !((getRoadInfo _x) select 2) && { !((getRoadInfo _x) select 8) && { ((getRoadInfo _x) select 0) == "ROAD" || ((getRoadInfo _x) select 0) == "MAIN ROAD" }}}
		_x isNotEqualTo [] && { !((getRoadInfo _x) select 2) && { !((getRoadInfo _x) select 8) }}
	};
	
	// remove more bad road segments (intersections)
	// roadsConnectedTo is 2 and count nearroads within 15m is less than 2 and nearestBuilding is within 10m and is length (begPos distance2D endPos) greater than 5m
	private _road_seg_list = _road_seg_list_filtered select { count (roadsConnectedTo _x) == 2 && { count (_x nearroads 15) < 2 && { ((nearestBuilding _x) distance2D _x) > 10 && { ((getRoadInfo _x) select 6) distance2D ((getRoadInfo _x) select 7) > 5 }}}};
		
	_road_seg_list = _road_seg_list call BIS_fnc_arrayShuffle;
	
	private _max_car_count = 499;
	_expected_car_spawn_count = (round((count _road_seg_list) * d_enable_civ_vehs / 100) * 2.5) min _max_car_count; // estimate 2.5 cars per road segment
	diag_log [format ["creating %1 cars (calculated max cars is %2, road segment count is %3 out of a raw road count of %4)", _expected_car_spawn_count, _max_car_count, count _road_seg_list, count _road_seg_list_raw]];
	private _spawned_count = 0;
	private _tries = 0;
	while { _tries < 999 && {_spawned_count < _expected_car_spawn_count && { count _road_seg_list > 0 }} } do {
		_tries = _tries + 1;
		private _current_road = _road_seg_list select 0;
		_road_seg_list deleteAt 0;
		private _veh_type = selectRandomWeighted d_civ_vehicles_weighted;
		if (!isNil "_current_road" && {!isNull _current_road}) then {			
			// direction
			private _connected_road = (roadsConnectedTo _current_road) select 0;
			private _direction = ([_current_road, _connected_road] call BIS_fnc_DirTo) + random [-7, 0, 7];
			// position
			private _pos_flat_empty = [];
			private _pos_flat_empty_attempts = 0;
			private _road_seg_width = ((getRoadInfo _current_road) select 1);
			private _road_seg_length = ((getRoadInfo _current_road) select 6) distance2D ((getRoadInfo _current_road) select 7);
			//private _min_distance_nearby_objects = (_road_seg_width * 0.1) min 2.25; // at most 2.25m
			private _min_distance_nearby_objects = 1;
			private _tmp_pos = getPosASL _current_road;
			while {_pos_flat_empty isEqualTo [] && {_pos_flat_empty_attempts < 99}} do {
				_pos_flat_empty_attempts = _pos_flat_empty_attempts + 1;
				
				if (_tmp_pos findEmptyPosition [1.25, 2.5, _veh_type] isEqualTo []) then {
					__TRACE("findEmptyPosition failed")
				};
				
				if (_tmp_pos isFlatEmpty [0.5, -1] isEqualTo []) then {
					// having problems with isFlatEmpty erroneously failing, deprecating it here
					__TRACE("isFlatEmpty failed")
				};
				
				if (_tmp_pos findEmptyPosition [1.25, 2.5, _veh_type] isNotEqualTo []) then {
                     _pos_flat_empty = _tmp_pos;
				};

				// if (_pos_flat_empty isNotEqualTo [] && { _tmp_pos isFlatEmpty [0.5, -1] isNotEqualTo [] }) then {
				if (_pos_flat_empty isEqualTo []) then {
					// pos is not suitable
					// find a new pos within 3m radius so we can try again
					_tmp_pos = [[[_tmp_pos, 3]],[]] call BIS_fnc_randomPos;
				};
			};
			if (_pos_flat_empty isEqualTo []) then {
				diag_log [format ["fn_civiliancars could not find a flat and empty spot after 99 attempts, giving up %1", _veh_type]];
			} else {
#ifdef __DEBUG__
				diag_log [format ["fn_civiliancars found a good position for %1 after %2 attempts", _veh_type, _pos_flat_empty_attempts]];
#endif
				// isFlatEmpty, Resulting position will be original PositionAGL + getTerrainHeightASL
				private _car_length_allowed = 5.25; // in meters
				private _car_extra_space = 0.75; // in meters
				private _num_cars_in_road_segment = (floor ((_road_seg_length * 0.75) / _car_length_allowed)) min 5;
				private _distance_between_cars = (_road_seg_length / _num_cars_in_road_segment) + _car_extra_space;
				if (_num_cars_in_road_segment > 0) then {
					// translate pos from road segment center to the right (+90) by a distance relative to road width (_road_seg_width * 0.35)
					private _pos_middle_right = [(_pos_flat_empty # 0), (_pos_flat_empty # 1), (_pos_flat_empty # 2 - getTerrainHeightASL _pos_flat_empty)] getPos [_road_seg_width * 0.35, (_direction + 90)];
					// translate middle right pos backward (-180) by length / 2
					private _pos_back_right = _pos_middle_right getPos [(_road_seg_length / 2), (_direction - 180)];
					private _last_pos = _pos_back_right; // start at back right position
					for "_i" from 1 to _num_cars_in_road_segment do {
						private _pos_veh = _last_pos getPos [_distance_between_cars, _direction];
						private _dir_slightly_randomized = _direction + random [-7,0,7];
						private _distance_slightly_randomized = random [0, 0.05, 0.1];
						private _pos_veh_slightly_randomized = _pos_veh getPos [_distance_slightly_randomized, _dir_slightly_randomized];
						// chance for no car
						if (random 100 < 80) then {
							_veh_type = selectRandomWeighted d_civ_vehicles_weighted;
							private _civ_veh_count_before = count d_cur_tgt_civ_vehicles;
							[_pos_veh_slightly_randomized, _veh_type, _dir_slightly_randomized, _current_road] call _make_veh;
							if (count d_cur_tgt_civ_vehicles > _civ_veh_count_before) then {
								// car was spawned successfully
								_spawned_count = _spawned_count + 1;
							};
						};
						_last_pos = _pos_veh;
					};	
				};
			};
		};
	};
	diag_log [format ["spawned %1 civilian cars in total, expected target was %2 cars", _spawned_count, _expected_car_spawn_count]];
	
	sleep 3;
	
	// iterate over civilian vehicles, enable damage, apply random damage to some vehicles
	{
		_x allowDamage true;
		if (_x getVariable ["d_damage_this_vehicle", false]) then {
			_x setDamage (random [0.3, 0.55, 0.89]);
		};
	} forEach d_cur_tgt_civ_vehicles;
};