//#define __DEBUG__
#define THIS_FILE "fn_objectsmapper.sqf"
#include "..\x_setup.sqf" 

/*
	File: objectMapper.sqf
	Author: Joris-Jan van 't Land

	Description:
	Takes an array of data about a dynamic object template and creates the objects.

	Parameter(s):
	_this select 0: position of the template - Array [X, Y, Z]
	_this select 1: azimuth of the template in degrees - Number 
	_this select 2: objects for the template - Array / composition class - String / tag list - Array
	_this select 3: (optional) randomizer value (how much chance each object has of being created. 0.0 is 100% chance) - Number

	Returns:
	Created objects (Array)
*/

params ["_pos", "_azi", "_objs", ["_rdm", 0]];

//_pos = _this param [0, [0, 0], [[]]];
//_azi = _this param [1, 0, [-1]];

if (_rdm < 0.0) then {
	_rdm = 0;
} else {
	if (_rdm > 1) then {
		_rdm = 1;
	};
};

if (isNil "d_struct_patches_ar") then {
	d_struct_patches_ar = getArray(configFile>>"CfgPatches">>"A3_Structures_F_Ind_Transmitter_Tower">>"units") apply {toLowerANSI _x};
};

//See if an object array, specific composition class or tag array was given
private ["_script"];
private _cfgObjectComps = configFile >> "CfgObjectCompositions";

if (_objs isEqualType "") then {
	//Composition class was given
	_script = getText(_cfgObjectComps >> _objs >> "objectScript");
	_objs = [];
} else {
	_objs params ["_testSample"];
	if !(_testSample isEqualType[]) then {
		//Tag list was given
		private _queryTags = +_objs;
		_objs = [];
		
		//Make a list of candidates which match all given tags
		private _candidates = [];
		
		for "_i" from 0 to ((count _cfgObjectComps) - 1) do {
			private _candidate = _cfgObjectComps select _i;
			private _candidateTags = getArray(_candidate >> "tags");
			
			//Are all tags in this candidate?
			if ({_x in _candidateTags} count _queryTags == count _queryTags) then {
				_candidates pushBack getText(_candidate >> "objectScript");
			};
		};
		
		//Select a random candidate
		_script = selectRandom _candidates;
	};
};

//If the object array is in a script, call it
if (!isNil "_script") then {
	_objs = call (compile (preprocessFileLineNumbers _script));
};

//Make sure there are definitions in the final object array
if (count _objs == 0) exitWith {
	__TRACE("[BIS_fnc_objectMapper] No elements in the object composition array!")
};

private _newObjs = [];

_pos params ["_posX", "_posY"];

//Function to multiply a [2, 2] matrix by a [2, 1] matrix
private _multiplyMatrixFunc = {
	params ["_array1", "_array2"];
	private _result = [
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];

	_result
};

{
	//Check randomizer for each object
	if (random 1 > _rdm) then  {
		private ["_fuel", "_damage", "_orientation", "_varName", "_init", "_simulation", "_ASL"];
		_x params ["_type", "_relPos", "_azimuth"];
		
		//Optionally map certain features for backwards compatibility
		if (count _x > 3) then {_fuel = _x select 3};
		if (count _x > 4) then {_damage = _x select 4};
		if (count _x > 5) then {_orientation = _x select 5};
		if (count _x > 6) then {_varName = _x select 6};
		if (count _x > 7) then {_init = _x select 7};
		if (count _x > 8) then {_simulation = _x select 8};
		if (count _x > 9) then {_ASL = _x select 9};
		if (isNil "_ASL") then {_ASL = false;};
	
		//Rotate the relative position using a rotation matrix
		private _rotMatrix = [
			[cos _azi, sin _azi],
			[-(sin _azi), cos _azi]
		];
		private _newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;
	
		//Backwards compatability causes for height to be optional
		private ["_z"];
		if (count _relPos > 2) then {_z = _relPos select 2} else {_z = 0};
	
		private _newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
	
		//Create the object and make sure it's in the correct location
		//_newObj = _type createVehicle _newPos;
		//_newObj = createSimpleObject [_type, AGLToASL _newPos];
		private _dosurface = true;
		private "_newObj";
		if (_type isKindOf "StaticWeapon" || {_type isKindOf "BagBunker_base_F"}) then {
			_newObj = createVehicle [_type, _newPos, [], 0, "CAN_COLLIDE"];
			_newObj setDir (_azi + _azimuth);
			_newObj setPos _newPos;
			if (d_with_dynsim == 0) then {
				[_newObj, 10] spawn d_fnc_enabledynsim;
			};
		} else {
			if (_type isKindOf "Car") then {
				_newPos = _newPos vectorAdd [0,0,0.1];
			};
			_newObj = [_type, AGLToASL _newPos, 0, true] call d_fnc_createSimpleObject;
			_newObj setDir (_azi + _azimuth);
			_newObj setPosWorld (getPosWorld _newObj);
			if (toLowerANSI _type in d_struct_patches_ar) then {
				_dosurface = false;
			};
		};
		if (_dosurface) then {
			_newObj setVectorUp (surfaceNormal (getPos _newObj));
			__TRACE_3("setVectorUp surfaceNormal","_type","_newObj","surfaceNormal _newPos")
		} else {
			__TRACE_2("setVectorUp 001","_type","_newObj")
			_newObj setVectorUp [0, 0, 1];
		};
		
		//if (!_ASL) then {_newObj setPos _newPos;} else {_newObj setPosASL _newPos; _newObj setVariable ["BIS_DynO_ASL", true];};
		
		//If fuel and damage were grabbed, map them
		if (!isNil "_fuel") then {_newObj setFuel _fuel};
		if (!isNil "_damage") then {_newObj setDamage _damage;};
		if (!isNil "_orientation") then  {
			if ((count _orientation) > 0) then {
				__TRACE_2("do orientation","_type","_newObj")
				([_newObj] + _orientation) call BIS_fnc_setPitchBank;
			};
		};
		if (!isNil "_varName") then  {
			if (_varName != "") then  {
				_newObj setVehicleVarName _varName;
				call (compile (_varName + " = _newObj;"));
			};
		};
		if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));}; //TODO: remove defining this hotfix?
		if (!isNil "_simulation") then {_newObj enableSimulation _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};
	
		_newObjs pushBack _newObj;
	};
} forEach _objs;

_newObjs