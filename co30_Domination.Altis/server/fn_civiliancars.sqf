//create civilian vehicles
//adapted from script by h8ermaker https://www.youtube.com/watch?v=pE47H8lG8uc
if (d_enable_civ_vehs > 0) then {
	_roadList = _trg_center nearroads d_enable_civ_vehs_rad;
	
	{
		_roadConnectedTo = roadsConnectedTo _x;
		
		if (count _roadConnectedTo > 2 || {count (roadsConnectedTo (_roadConnectedTo # 0)) > 2 || {count (roadsConnectedTo (_roadConnectedTo # 1)) > 2 || {((nearestBuilding _x) distance2D _x) > 20}}}) then {
			//only has 2 connections, children also only have 2 connections, is within 20m of a building
			_roadList=_roadList - [_x];	
		};
	} foreach _roadList;

	_roadList=_roadList call BIS_fnc_arrayShuffle;
	
	private _max_car_count = floor(d_enable_civ_vehs * 2.25); // sanity check, avoid spawning too many cars
	_carSpawns = round((count _roadList) * d_enable_civ_vehs / 100) min _max_car_count;
	diag_log [format ["creating %1 cars (calculated allowable is %2)", _carSpawns, _max_car_count]];
	
	for "_i" from 1 to _carSpawns do {
		_currentRoad = _roadList # _i;
		if (!isNil "_currentRoad" && {!isNull _currentRoad}) then {
			_roadConnectedTo = roadsConnectedTo _currentRoad;
			_connectedRoad = _roadConnectedTo # 0;
			if (isNil "_connectedRoad" || {isNull _connectedRoad}) exitWith {};
			_direction = [_currentRoad, _connectedRoad] call BIS_fnc_DirTo;
			
			private _pos_flat_empty = [];
			private _pos_flat_empty_attempts = 0;
			private _tmp_pos = getPosASL _currentRoad;
			while {_pos_flat_empty isEqualTo [] && {_pos_flat_empty_attempts < 99}} do {
				_pos_flat_empty = [_tmp_pos, [1, -1, 0.1, 1, -1, false, objNull]] call d_fnc_isFlatEmpty;
				if (_pos_flat_empty isEqualTo []) then {
					_tmp_pos = [[[_tmp_pos, 25]],[]] call BIS_fnc_randomPos;
					//_tmp_pos = ATLToASL ([[[_tmp_pos, 25]],[]] call BIS_fnc_randomPos);
					_pos_flat_empty_attempts = _pos_flat_empty_attempts + 1;
				};
			};
			if (_pos_flat_empty isEqualTo []) then {
				diag_log ["fn_civiliancars could not find a flat and empty spot after 99 attempts, giving up"];
			} else {
				// isFlatEmpty, Resulting position will be original PositionAGL + getTerrainHeightASL			
				_pos_flat_empty = [(_pos_flat_empty # 0), (_pos_flat_empty # 1), (_pos_flat_empty # 2 - getTerrainHeightASL _pos_flat_empty)];	
				_veh = createVehicle [selectRandomWeighted d_civ_vehicles_weighted, _pos_flat_empty, [], 0, "NONE"];
				if (d_enable_civ_vehs_locked == 1) then {
					_veh lock true;
				};
				_veh enableSimulationGlobal false;
				_veh allowDamage false;
				_veh setDamage 0;
				_veh setdir _direction;
				_veh setPos [(getPos _veh # 0) + 5.5, getPos _veh # 1, getPos _veh # 2];
				d_cur_tgt_civ_vehicles pushBack _veh;
			};
		};
	};
	
	sleep 10;
	_badCars = 0;
	{
		if ((vectorUp _x) # 2 < 0.8) then {
			_badCars = _badCars + 1;
		};
		_x enableSimulationGlobal true;
		_x allowDamage true;
		_x setDamage 0;
	} forEach d_cur_tgt_civ_vehicles;
	//hint format["badCars count: %1", _badCars];
};