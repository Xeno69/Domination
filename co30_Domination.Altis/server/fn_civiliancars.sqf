//#define __DEBUG__
#include "..\x_setup.sqf"

//create civilian vehicles
//adapted from script by h8ermaker https://www.youtube.com/watch?v=pE47H8lG8uc
if (d_enable_civ_vehs > 0) then {
	// all roads in defined civ radius
	_road_seg_list_raw = _trg_center nearroads d_enable_civ_vehs_rad;
	
	// remove possible intersection road segments, has more than 2 connections or is more than 20m from a building
	_road_seg_list = _road_seg_list_raw select { count (roadsConnectedTo _x) == 2 && { count (_x nearroads 7) < 2 && { ((nearestBuilding _x) distance2D _x) > 15 && { _x isNotEqualTo [] }}} };
	_road_seg_list = _road_seg_list call BIS_fnc_arrayShuffle;
	
	// sanity check, avoid spawning too many cars
	private _max_car_count = floor(d_enable_civ_vehs * 2.25);
	_expected_car_spawn_count = round(_max_car_count * d_enable_civ_vehs / 100) min _max_car_count;
	if (_expected_car_spawn_count > count _road_seg_list) then {
		_expected_car_spawn_count = count _road_seg_list;
	};
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
				// translate pos to the right (+90) by distance (road width * 0.35) to spawn the vehicle on the side of the road
				_pos_flat_empty = [(_pos_flat_empty # 0), (_pos_flat_empty # 1), (_pos_flat_empty # 2 - getTerrainHeightASL _pos_flat_empty)] getPos [_road_seg_width * 0.35, (_direction + 90)];
				_veh = _veh_type createVehicle _pos_flat_empty;
				if (d_enable_civ_vehs_locked == 1) then {
					_veh lock true;
				};
				_veh enableSimulationGlobal false;
				_veh allowDamage false;
				if (_direction isNotEqualTo []) then {
					_veh setdir _direction;
				};
				d_cur_tgt_civ_vehicles pushBack _veh;
				_spawned_count = _spawned_count + 1;
				private _cars_to_severely_damage = [
					"bus",
					"police",
					"ikarus",
					"idap",
					"army",
					"suv_ion",
					"ambulance"
				];
				{
					if ([_x, _veh_type] call BIS_fnc_inString) exitWith {
						// severely damage this car for the visual affect of a broken city
						_veh setVariable ["d_damage_this_vehicle", true];
					};
				} forEach _cars_to_severely_damage;
			};
		};
	};
	diag_log [format ["spawned %1 civilian cars in total, expected target was %2 cars", _spawned_count, _expected_car_spawn_count]];
	
	sleep 10;
	_badCars = 0;
	{
		if ((vectorUp _x) # 2 < 0.8) then {
			_badCars = _badCars + 1;
		};
		_x enableSimulationGlobal true;
		_x allowDamage true;
		private _desired_car_damage = random 0.6;
		if (_x getVariable ["d_damage_this_vehicle", false]) then {
			_desired_car_damage = 0.90;
		};
		_x setDamage (_desired_car_damage);
	} forEach d_cur_tgt_civ_vehicles;
	//hint format["badCars count: %1", _badCars];
};