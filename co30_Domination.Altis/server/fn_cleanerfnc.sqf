// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cleanerfnc.sqf"
#include "..\x_setup.sqf"

while {true} do {
	sleep (300 + random 150);
	private _allmisobjs = allMissionObjects "groundWeaponHolder";
	sleep 8;
	private _helperx = allMissionObjects "WeaponHolder";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 8;
	_helperx = entities [["WeaponHolderSimulated", "Plane_Canopy_Base_F", "Ejection_Seat_Base_F"], []];
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 8;
	_helperx = allMissionObjects "WeaponHolder_Single_F";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 8;
	_helperx = allMissionObjects "Chemlight_base";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 8;
	_helperx = allMissionObjects "Crater";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 8;
	_helperx = allMissionObjects "CraterLong";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 8;
	if !(_allmisobjs isEqualTo []) then {
		{
			if (!isNull _x) then {
				private _ct = _x getVariable ["d_checktime", -1];
				if (_ct == -1) then {
					_x setVariable ["d_checktime", time];
				} else {
#ifndef __TT__
					if (_x distance2D d_FLAG_BASE < 20) then {
#else
					if (_x distance2D d_WFLAG_BASE < 20 || {_x distance2D d_EFLAG_BASE < 20}) then {
#endif
						deleteVehicle _x;
					} else {
						if ((_x nearEntities ["CAManBase", 50]) findIf {_x call d_fnc_isplayer} == -1) then {
							deleteVehicle _x;
						};
					};
				};
				sleep 0.212;
			};
		} forEach (_allmisobjs select {!isNull _x});
	};
	_allmisobjs = nil;
	sleep 4;
	if (!isNil "d_player_created") then {
		{
			private _hastime = _x getVariable "d_end_time";
			if (!isNil "_hastime" && {time > _hastime}) then {
				if ((crew _x) findIf {alive _x} == -1) then {
					deleteVehicle _x;
				} else {
					if ((crew _x) findIf {_x call d_fnc_isplayer} > -1) then {
						_x setVariable ["d_end_time", time + 600];
					};
				};
			};
		} forEach (d_player_created select {!isNull _x});
		d_player_created = d_player_created - [objNull];
	};
	sleep 4;
	if (!isNil "d_airboxes" && {!(d_airboxes isEqualTo [])}) then {
		{
			private _mname = _x getVariable "d_mname";
			if (!isNil "_mname") then {
				deleteMarker _mname;
			};
			deleteVehicle _x;
		} forEach (d_airboxes select {time > _x getVariable ["d_airboxtime", -1]});
		d_airboxes = d_airboxes - [objNull];
	};
};