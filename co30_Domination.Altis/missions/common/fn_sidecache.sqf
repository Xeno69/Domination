//#define __DEBUG__
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_poss", ["_createarmor", false], ["_createinf", false]];

__TRACE_1("","_this")

if (_createarmor) then {
	sleep 2.22;
	__TRACE("Creating armor")
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};

if (_createinf) then {
	sleep 2.123;
	__TRACE("Creating inf")
	["specops", 2, "allmen", (floor (random 4)) min 2, _poss, 150, true] spawn d_fnc_CreateInf;
};

private _houseArray = nearestTerrainObjects [_poss, ["House"], 150, false, true];
{
	_x setDamage 0;
} forEach _houseArray;
__TRACE_1("","_houseArray")
private _created = false;
private _cache = objNull;

while {!_created} do {
    private _idx = floor random count _houseArray;
	__TRACE_2("","floor random count _houseArray","_idx")
	private _house = _houseArray # _idx;
	if (!isNil "_house" && {!isNull _house}) then {
		__TRACE_1("","_house")
		private	_pos = [_house] call bis_fnc_buildingPositions;
		_houseArray deleteAt _idx;
		__TRACE_1("","_pos")
		if (_pos isNotEqualTo []) then {
			_pos = _pos # (floor random count _pos);
			_pos set [2, (_pos # 2) + 0.3];
			__TRACE_1("","_pos")
			_cache = createVehicle [selectRandom d_sm_cache, _pos, [], 0, "NONE"];
			if (!isNull _cache) then {
				_cache setPos _pos;
				_cache setDir ceil random 360;
				__TRACE_1("","_cache")
			
				_cache call d_fnc_addKilledEHSM;
				_created = true;
#ifdef __DEBUG__
				[format["cache_%1",_cache], _pos,"ICON","ColorBlack",[0.5,0.5],"Cache",0,"n_Ordnance"] call d_fnc_CreateMarkerGlobal;
#endif
				clearWeaponCargoGlobal _cache;
				_cache setVariable ["d_nocheck", true, true];
				private _unitstog = [
					[[[_pos, 30]],[]] call BIS_fnc_randomPos,
					selectRandom [3, 4, 5],			//unit count
					10,		//fillRadius
					false,		//fillRoof
					false,		//fillEvenly
					false,		//fillTopDown
					false,		//disableTeleport
					0		//unitMovementMode
				] call d_fnc_garrisonUnits;
				d_x_sm_rem_ar append _unitstog;
				sleep 1;
				for "_ii" from 0 to 1 do {
					_unitstog = [
						[[[_pos, 30]],[]] call BIS_fnc_randomPos,
						selectRandom [2, 3, 4],			//unit count
						50,		//fillRadius
						false,		//fillRoof
						false,		//fillEvenly
						false,		//fillTopDown
						false,		//disableTeleport
						0		//unitMovementMode
					] call d_fnc_garrisonUnits;
					d_x_sm_rem_ar append _unitstog;
					sleep 1;
				};
			};
		};
	} else {
		_houseArray deleteAt _idx;
	};
	if (!_created && {_houseArray isEqualTo []}) exitWith {};
	if (d_sm_resolved) exitWith {};
	sleep 1;
};

if (d_sm_resolved) exitWith {
	if (!isNull _cache) then {
		deleteVehicle _cache;
	};
};

if (isNull _cache) exitWith {
	d_sm_winner = -2;
	d_sm_resolved = true;
};

private _num_mines = (floor (random 15)) max 10;

for "_i" from 0 to (_num_mines - 1) do {
	private _idx = floor random count _houseArray;
	private _house = _houseArray # _idx;
	if (!isNil "_house" && {!isNull _house}) then {
		private	_pos_b = [_house] call bis_fnc_buildingPositions;
		_houseArray deleteAt _idx;
		if (_pos_b isNotEqualTo []) then {
			_pos_b = _pos_b # (floor random count _pos_b);
			_pos_b set [2,(_pos_b # 2) + 0.01];
			private _mine = createMine [selectRandom ["APERSBoundingMine", "APERSTripMine", "APERSMine"], _pos_b, [], 0];
			d_side_enemy revealMine _mine;
			d_x_sm_vec_rem_ar pushBack _mine;
#ifdef __DEBUG__
			[format["mines_%1",_mine], _mine,"ICON","ColorWhite",[0.5,0.5],"Mine",0,"Minefield"] call d_fnc_CreateMarkerGlobal;
#endif
		};
	} else {
		_houseArray deleteAt _idx;
	};
};

private _cachemarker = ["d_sm_cache123", _poss, "ELLIPSE", "ColorWhite", [150, 150], "", 0, "", "BDiagonal", 0.4] call d_fnc_CreateMarkerGlobal;

private _cache_dest = false;
private _endtime = time + 3600;
private _mtimes = [time + 600, time + 1000, time + 1300, time + 1500];
private _curmtime = 0;
private _cmnpos =+ _poss;
private _cursize = 150;
private _curalpha = 0.5;

private _cmfunc = {
	_cmnpos = _cmnpos getPos [(_cmnpos distance2D _cache) / 2, _cmnpos getDir _cache];
	_cachemarker setMarkerAlphaLocal _curalpha;
	_curalpha = _curalpha + 0.1;
	_cachemarker setMarkerPosLocal _cmnpos;
	_cursize = _cursize - 30;
	_cachemarker setMarkerSize [_cursize, _cursize];
};

while {true} do {
	if (isMultiplayer && {(call d_fnc_PlayersNumber) == 0}) then {
		_endtime = _endtime - time;
		while {true} do {
			sleep (1.012 + random 1);
			if ((call d_fnc_PlayersNumber) > 0) exitWith {};
		};
		_endtime = time + _endtime;
	};
	sleep 0.1;
	if (_curmtime < 4 && {time > (_mtimes # _curmtime)}) then {
		call _cmfunc;		
		_curmtime = _curmtime + 1;
	};
	if (time > _endtime) exitWith {
		_cache_dest = true;
		if (!isNull _cache) then {
			_cache removeAllEventHandlers "killed";
			_cache removeAllEventHandlers "handleDamage";
			deleteVehicle _cache;
		};
	};
	sleep 5.123;
	if (d_sm_resolved) exitWith {};
};

deleteMarker _cachemarker;

if (!d_sm_resolved) then {
	if (_cache_dest) then {
		d_sm_winner = -2;
	};
	d_sm_resolved = true;
};
