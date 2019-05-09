// by Xeno
#define THIS_FILE "fn_vehirespawn2.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith{};

params ["_vec", "_delay"];
private _startpos = getPosATL _vec;
private _startdir = getDir _vec;
private _type = typeOf _vec;

_vec setVariable ["d_vec_islocked", (_vec call d_fnc_isVecLocked)];

_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck}}];

if (unitIsUAV _vec) then {
	_vec allowCrewInImmobile true;
} else {
	if (d_with_dynsim == 0) then {
		_vec spawn {
			scriptName "spawn enable dyn";
			sleep 10;
			if (alive _this) then {
				_this enableDynamicSimulation true;
			};
		};
	};
};

if (d_with_ranked) then {
	clearWeaponCargoGlobal _vec;
};

private _skinpoly = _vec call d_fnc_getskinpoly;
_vec setVariable ["d_veccustom", [_vec] call BIS_fnc_getVehicleCustomization];

while {true} do {
	sleep (_delay + random 15);

	if ((crew _vec) findIf {alive _x} == -1 && {damage _vec > 0.9 || {!alive _vec}}) then {
		private _isitlocked = _vec getVariable "d_vec_islocked";
		private _fuelleft = _vec getVariable ["d_fuel", 1];
		private _veccustom = _vec getVariable "d_veccustom";
		if (unitIsUAV _vec) then {
			{_vec deleteVehicleCrew _x} forEach (crew _vec);
		};
		deleteVehicle _vec;
		sleep 0.5;
		_vec = createVehicle [_type, _startpos, [], 0, "NONE"];
		_vec setDir _startdir;
		_vec setPos _startpos;
		_vec setVariable ["d_vec_islocked", _isitlocked];
		if (_isitlocked) then {_vec lock true};
		_vec setFuel _fuelleft;
		_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck}}];
		if (unitIsUAV _vec) then {
			createVehicleCrew _vec;
			_vec allowCrewInImmobile true;
		} else {
			if (d_with_dynsim == 0) then {
				_vec spawn {
					scriptName "spawn enable dyn";
					sleep 10;
					if (alive _this) then {
						_this enableDynamicSimulation true;
					};
				};
			};
		};
		[_vec, _skinpoly] call d_fnc_skinpolyresp;
		if (d_with_ranked) then {
			clearWeaponCargoGlobal _vec;
		};
		if (!isNil "_veccustom") then {
			[_vec, _veccustom # 0, _veccustom # 1] call BIS_fnc_initVehicle;
		};
	};
};
