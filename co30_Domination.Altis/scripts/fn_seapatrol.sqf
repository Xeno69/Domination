//#define __DEBUG__
#include "..\x_setup.sqf"
if (!isServer || {diag_fps < 15}) exitWith {};

params["_pos", "_radius"];

private _water = [_pos, 130, _radius * 3, 0, 2, 0, 0, [], [], false] call d_fnc_findSafePos;
sleep 0.1;
if (_water isEqualTo []) then {
	_water = [_pos, 130, _radius * 5, 0, 2, 0, 0, [], [], false] call d_fnc_findSafePos;
	sleep 0.1;
};

if (_water isEqualTo [] || {(getTerrainHeightASL _water) > -5}) exitWith {
	__TRACE("No water")
};

#ifdef __VN__
private _ran = selectRandom [1, 2];
#else
private _ran = [2, 4] call d_fnc_getrandomrangeint;
#endif

for "_i" from 1 to _ran do {
	private _radiusw = 200;
	private _estart_pos = [];
	for "_i" from 0 to 49 do {
		_estart_pos = [_water, _radiusw, 2, 0.7, 4, 2] call d_fnc_getranpointcircle;
		if (_estart_pos isNotEqualTo [] && {surfaceIsWater _estart_pos && {(getTerrainHeightASL _estart_pos) < -5}}) exitWith {};
		_radiusw = _radiusw + 50;
	};
	_pos = [];
	private _speedboat = if (d_sm_speedboat isEqualType []) then {selectRandom d_sm_speedboat} else {d_sm_speedboat};
	for "_i" from 0 to 49 do {
		_pos = _estart_pos findEmptyPosition [20, _radiusw, _speedboat];
		if (_estart_pos isNotEqualTo [] && {surfaceIsWater _estart_pos && {(getTerrainHeightASL _estart_pos) < -5}}) exitWith {};
	};
	__TRACE_1("","_pos")
	if (_pos isNotEqualTo []) then {
		private _bestpos = selectBestPlaces [_pos, 15, "waterdepth", 2, 5];
		if (_bestpos isNotEqualTo []) then {
			_pos = (_bestpos # 0) # 0;
			_pos set [2, 0];
			private _newgrp = [d_side_enemy] call d_fnc_creategroup;
			([_pos, ceil random 360, _speedboat, _newgrp] call d_fnc_spawnvehicle) params ["_veh", "_crew"];
			_veh setDamage 0;
			[_veh, 5] call d_fnc_setekmode;
			addToRemainsCollector [_veh];
			[_veh, 2] remoteExec ["setFeatureType", [0, -2] select isDedicated, _veh];
			_veh setCollisionLight true;
			if (sunOrMoon != 1) then {
				_veh setPilotLight true;
			};
			{
				_x disableAI "LIGHTS";
			} forEach _crew;
			d_delvecsmt pushBack _veh;
			d_delinfsm append _crew;
			{
				private _grpUnit = _x;
				{
					if (_x in ["HandGrenade", "MiniGrenade"]) then {
						_grpUnit removeMagazine _x;
					};
				} forEach (magazines _grpUnit);
				private _swimDepth = random [getTerrainHeightASL (getPosWorld _x), (getTerrainHeightASL (getPosWorld _x)) / 2, -1];
				_grpUnit swimInDepth _swimDepth;
			} forEach (units _newgrp);
			[_newgrp, _pos, [_water, _radius], [5, 15, 30], "", 1, true, 2] spawn d_fnc_makepatrolwpx;
			[_newgrp, 10] spawn d_fnc_enabledynsim;
		};
	};
	sleep 1;
};