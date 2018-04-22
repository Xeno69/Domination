// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cleanerfnc.sqf"
#include "..\..\x_setup.sqf"

while {true} do {
	sleep (300 + random 150);
	private _allmisobjs = allMissionObjects "groundWeaponHolder";
	sleep 4;
	private _helperx = allMissionObjects "WeaponHolder";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = entities [["WeaponHolderSimulated", "Plane_Canopy_Base_F", "Ejection_Seat_Base_F"], []];
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "WeaponHolder_Single_F";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "Chemlight_green";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "Chemlight_red";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "Chemlight_yellow";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "Chemlight_blue";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "CraterLong";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 4;
	_helperx = allMissionObjects "CraterLong_small";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	if !(_allmisobjs isEqualTo []) then {
		{
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
					if ((_x nearEntities ["CAManBase", 50]) findIf {isPlayer _x} == -1) then {
						deleteVehicle _x;
					};
				};
			};
			sleep 0.212;
		} forEach (_allmisobjs select {!isNull _x});
	};
	_allmisobjs = nil;
	sleep 3;
	if (!isNil "d_player_created") then {
		{
			private _hastime = _x getVariable "d_end_time";
			if (!isNil "_hastime" && {time > _hastime}) then {
				if ((crew _x) findIf {alive _x} == -1) then {
					deleteVehicle _x;
				} else {
					if ((crew _x) findIf {isPlayer _x} > -1) then {
						_x setVariable ["d_end_time", time + 600];
					};
				};
			};
			false
		} count (d_player_created select {!isNull _x});
		d_player_created = d_player_created - [objNull];
	};
};