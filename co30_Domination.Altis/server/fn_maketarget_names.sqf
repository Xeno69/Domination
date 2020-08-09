// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_maketarget_names.sqf"
#include "..\x_setup.sqf"

{
	private _dtar = _x;
	private _name = _dtar getVariable "d_cityname";
	if (!isNil "_name") then {
		private _pos = getPosWorld _dtar;
		_pos set [2, 0];
		d_target_names pushBack [_pos, _name, _dtar getVariable ["d_cityradius", 300], _forEachIndex, _dtar];
	} else {
		private _nlocs = nearestLocations [getPosWorld _dtar, ["NameCityCapital", "NameCity", "NameVillage"], 500];
		// if _pos is more than 500m from a NameCityCapital/NameCity/NameVillage then try again with more location types
		if (_nlocs isEqualTo []) then {
			_nlocs = nearestLocations [getPosWorld _dtar, ["Area","BorderCrossing","CityCenter","CivilDefense","CulturalProperty","DangerousForces","Flag","FlatArea","FlatAreaCity","FlatAreaCitySmall","Hill","HistoricalSite","Invisible","Mount","Name","NameCity","NameCityCapital","NameLocal","NameMarine","NameVillage","RockArea","SafetyZone","Strategic","StrongpointArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint"], 500];
		};
		__TRACE_2("","_dtar","_nlocs")
		if !(_nlocs isEqualTo []) then {
			private _locposnl0 = locationPosition (_nlocs # 0);
			private _nl = nearestLocations [_locposnl0, ["CityCenter"], 300];
			// if _pos is more than 300m from a CityCenter then try again with more location types
			if (_nl isEqualTo []) then {
				_nl = nearestLocations [_locposnl0, ["Area","BorderCrossing","CityCenter","CivilDefense","CulturalProperty","DangerousForces","Flag","FlatArea","FlatAreaCity","FlatAreaCitySmall","Hill","HistoricalSite","Invisible","Mount","Name","NameCity","NameCityCapital","NameLocal","NameMarine","NameVillage","RockArea","SafetyZone","Strategic","StrongpointArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint"], 300];
			};
			__TRACE_2("","_locposnl0","_nl")
			private _pos = [_locposnl0, locationPosition (_nl # 0)] select !(_nl isEqualTo []);
			_pos set [2, 0];
			if (isServer) then {
				_dtar setPos _pos;
			};
			_name = text (_nlocs # 0);
			if (_name == "") then {
				_name = "Unnamed Target";
			};
			_dtar setVariable ["d_cityname", _name];
			d_target_names pushBack [_pos, _name, _dtar getVariable ["d_cityradius", 300], _forEachIndex, _dtar];
		} else {
			private _strx = format ["No city found near target location %1", str _dtar];
			hint _strx;
			diag_log _strx;
		};
	};
	if (isServer) then {
		_dtar enableSimulationGlobal false;
	};
} forEach ((allMissionObjects "LocationCityCapital_F") select {str _x select [0, 9] isEqualTo "d_target_"});
__TRACE_1("All targets found","d_target_names")