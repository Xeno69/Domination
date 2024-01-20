/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_player", "_heli", "_rappelPoint"];

if (local _player) then {
	[_player] orderGetIn false;
	moveOut _player;
	waitUntil {vehicle _player == _player};
	private _playerStartPosition = AGLtoASL (_heli modelToWorldVisual _rappelPoint);
	_playerStartPosition set [2, (_playerStartPosition select 2) - 1];
	_playerStartPosition set [1, (_playerStartPosition select 1) - (((random 100) - 50) / 25)];
	_playerStartPosition set [0, (_playerStartPosition select 0) - (((random 100) - 50) / 25)];
	_player setPosWorld _playerStartPosition;

	private _anchor = "Land_Can_V2_F" createVehicle position _player;
	_anchor allowDamage false;
	hideObject _anchor;
	[_anchor] remoteExecCall ["AR_fnc_Hide_Object_Global", 2];
	_anchor attachTo [_heli, _rappelPoint];

	private _rappelDevice = "B_static_AA_F" createVehicle position _player;
	_rappelDevice setPosWorld _playerStartPosition;
	_rappelDevice allowDamage false;
	hideObject _rappelDevice;
	[_rappelDevice] remoteExecCall ["AR_fnc_Hide_Object_Global", 2];

	[_player, _rappelDevice, _anchor] remoteExecCall ["AR_fnc_Play_Rappelling_Sounds", 2];

	private _bottomRopeLength = 60;
	private _bottomRope = ropeCreate [_rappelDevice, [-0.15, 0, 0], _bottomRopeLength];
	_bottomRope allowDamage false;
	private _topRopeLength = 3;
	private _topRope = ropeCreate [_rappelDevice, [0, 0.15, 0], _anchor, [0, 0, 0], _topRopeLength];
	_topRope allowDamage false;

	[_player] spawn AR_fnc_Enable_Rappelling_Animation_Client;

	private _velocityVec = [0, 0, 0];
	private _lastTime = diag_tickTime;
	private _lastPosition = AGLtoASL (_rappelDevice modelToWorldVisual [0, 0, 0]);
	private _lookDirFreedom = 50;
	private _dir = (random 360) + (_lookDirFreedom / 2);
	private _dirSpinFactor = (((random 10) - 5) / 5) max 0.1;

	private _ropeKeyDownHandler = -1;
	private _ropeKeyUpHandler = -1;

	if (_player == player) then {
		_player setVariable ["AR_DECEND_PRESSED", false];
		_player setVariable ["AR_FAST_DECEND_PRESSED", false];
		_player setVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", 0];

		_ropeKeyDownHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", {
			if ((_this # 1) in (actionKeys "MoveBack")) then {
				player setVariable ["AR_DECEND_PRESSED", true];
			} else {
				if ((_this # 1) in (actionKeys "Turbo")) then {
					player setVariable ["AR_FAST_DECEND_PRESSED", true];
				};
			};
			false
		}];

		_ropeKeyUpHandler = (findDisplay 46) displayAddEventHandler ["KeyUp", {
			if ((_this # 1) in (actionKeys "MoveBack")) then {
				player setVariable ["AR_DECEND_PRESSED", false];
			} else {
				if ((_this # 1) in (actionKeys "Turbo")) then {
					player setVariable ["AR_FAST_DECEND_PRESSED", false];
				};
			};
			false
		}];
	} else {
		_player setVariable ["AR_DECEND_PRESSED", false];
		_player setVariable ["AR_FAST_DECEND_PRESSED", false];
		_player setVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", (random 2) - 1];

		[_player] spawn {
			scriptName "spawn_ar_decend_pressed";
			params ["_player"];
			sleep 2;
			_player setVariable ["AR_DECEND_PRESSED", true];
		};
	};

	// Cause player to fall from rope if heli is moving too fast
	_this spawn {
		scriptName "spawn_ar_is_rappelling";
		params ["_player","_heli"];
		while {_player getVariable ["AR_Is_Rappelling", false]} do {
			if (speed _heli > 150) then {
				if (isPlayer _player) then {
					hint "Moving too fast! You've lost grip of the rope.";
				};
				[_player] call AR_fnc_Rappel_Detach_Action;
			};
			sleep 2;
		};
	};

	while {true} do {
		private _currentTime = diag_tickTime;
		private _timeSinceLastUpdate = _currentTime - _lastTime;
		_lastTime = _currentTime;
		if (_timeSinceLastUpdate > 1) then {
			_timeSinceLastUpdate = 0;
		};

		_velocityVec = _velocityVec vectorAdd (([0, 0, -9.8] vectorAdd ((wind vectorAdd (_velocityVec vectorMultiply -1) vectorAdd ((vectorUp _heli) vectorMultiply -30)) vectorMultiply (9.8/53))) vectorMultiply _timeSinceLastUpdate);
		private _newPosition = _lastPosition vectorAdd (_velocityVec vectorMultiply _timeSinceLastUpdate);

		private _heliPos = AGLtoASL (_heli modelToWorldVisual _rappelPoint);

		if (_newPosition distance _heliPos > _topRopeLength) then {
			_newPosition = _heliPos vectorAdd ((vectorNormalized (_heliPos vectorFromTo _newPosition)) vectorMultiply _topRopeLength);
			private _surfaceVector = vectorNormalized (_newPosition vectorFromTo _heliPos);
			_velocityVec = _velocityVec vectorAdd ((_surfaceVector vectorMultiply (_velocityVec vectorDotProduct _surfaceVector)) vectorMultiply -1);
		};

		_rappelDevice setPosWorld (_lastPosition vectorAdd ((_newPosition vectorDiff _lastPosition) vectorMultiply 6));

		_rappelDevice setVectorDir (vectorDir _player);
		_player setPosWorld (_newPosition vectorAdd [0, 0, -0.6]);
		_player setVelocity [0, 0, 0];

		// Handle rappelling down rope
		if (_player getVariable ["AR_DECEND_PRESSED", false]) then {
			private _decendSpeedMetersPerSecond = 3.5;
			if (_player getVariable ["AR_FAST_DECEND_PRESSED", false]) then {
				_decendSpeedMetersPerSecond = 5;
			};
			_decendSpeedMetersPerSecond = _decendSpeedMetersPerSecond + (_player getVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT", 0]);
			_bottomRopeLength = _bottomRopeLength - (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
			_topRopeLength = _topRopeLength + (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
			ropeUnwind [_topRope, _decendSpeedMetersPerSecond, _topRopeLength - 0.5];
			ropeUnwind [_bottomRope, _decendSpeedMetersPerSecond, _bottomRopeLength];
		};

		// Fix player direction
		_dir = _dir + ((360/1000) * _dirSpinFactor);
		if (isPlayer _player) then {
			private _currentDir = getDir _player;
			private _minDir = (_dir - (_lookDirFreedom/2)) mod 360;
			private _maxDir = (_dir + (_lookDirFreedom/2)) mod 360;
			private _minDegreesToMax = 0;
			private _minDegreesToMin = 0;
			if (_currentDir > _maxDir) then {
				_minDegreesToMax = (_currentDir - _maxDir) min (360 - _currentDir + _maxDir);
			} else {
				if (_currentDir < _maxDir) then {
					_minDegreesToMax = (_maxDir - _currentDir) min (360 - _maxDir + _currentDir);
				};
			};
			if (_currentDir > _minDir) then {
				_minDegreesToMin = (_currentDir - _minDir) min (360 - _currentDir + _minDir);
			} else {
				if (_currentDir < _minDir) then {
					_minDegreesToMin = (_minDir - _currentDir) min (360 - _minDir + _currentDir);
				};
			};
			if (_minDegreesToMin > _lookDirFreedom || {_minDegreesToMax > _lookDirFreedom}) then {
				if (_minDegreesToMin < _minDegreesToMax) then {
					_player setDir _minDir;
				} else {
					_player setDir _maxDir;
				};
			} else {
				_player setDir (_currentDir  + ((360/1000) * _dirSpinFactor));
			};
		} else {
			_player setDir _dir;
		};

		_lastPosition = _newPosition;

		if ((getPos _player) select 2 < 1 || {!alive _player || {vehicle _player != _player || {_bottomRopeLength <= 1 || {_player getVariable ["AR_Detach_Rope", false]}}}}) exitWith {};

		sleep 0.01;
	};

	if (_bottomRopeLength > 1 && {alive _player && {vehicle _player == _player}}) then {
		private _playerStartASLIntersect = getPosASL _player;
		private _intersectionASL = [];
		{
			scopeName "surfaceLoop";
			private _objectFileName = str (_x select 2);
			if ((_objectFileName find " t_") == -1 && {(_objectFileName find " b_") == -1}) then {
				_intersectionASL = _x select 0;
				breakOut "surfaceLoop";
			};
		} forEach (lineIntersectsSurfaces [_playerStartASLIntersect, _playerStartASLIntersect vectorAdd [0, 0, -5], _player, objNull, true, 10]);

		if (count _intersectionASL != 0) then {
			_player allowDamage false;
			_player setPosASL _intersectionASL;
		};

		if (_player getVariable ["AR_Detach_Rope", false]) then {
			// Player detached from rope. Don't prevent damage
			// if we didn't find a position on the ground
			if (count _intersectionASL == 0) then {
				_player allowDamage true;
			};
		};

		// Allow damage if you get out of a heli with no engine on
		if (!isEngineOn _heli) then {
			_player allowDamage true;
		};
	};

	ropeDestroy _topRope;
	ropeDestroy _bottomRope;
	deleteVehicle [_anchor, _rappelDevice];

	if (!isNil {_player getVariable "AR_Is_Rappelling"}) then {
		_player setVariable ["AR_Is_Rappelling", nil, true];
	};
	if (!isNil {_player getVariable "AR_Rappelling_Vehicle"}) then {
		_player setVariable ["AR_Rappelling_Vehicle", nil, true];
	};
	_player setVariable ["AR_Detach_Rope", nil];

	if (_ropeKeyDownHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", _ropeKeyDownHandler];
	};

	if (_ropeKeyUpHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyUp", _ropeKeyUpHandler];
	};

	sleep 2;

	_player allowDamage true;
} else {
	_this remoteExec ["AR_fnc_Client_Rappel_From_Heli", _player];
};