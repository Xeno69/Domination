/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_player", ["_globalExec", false]];

if (local _player && {_globalExec}) exitWith {};

if (local _player && {!_globalExec}) then {
	[_player, true] remoteExec ["AR_fnc_Enable_Rappelling_Animation_Client", 0];
};

if (_player != player) then {
	_player enableSimulation false;
};

if (call AR_fnc_Has_Addon_Animations_Installed) then {
	if ([_player] call AR_fnc_Current_Weapon_Type_Selected isEqualTo "HANDGUN") then {
		if (local _player) then {
			if (missionNamespace getVariable ["AR_DISABLE_SHOOTING_OVERRIDE", false]) then {
				_player switchMove "AR_01_Idle_Pistol_No_Actions";
			} else {
				_player switchMove "AR_01_Idle_Pistol";
			};
			_player setVariable ["AR_Animation_Move", "AR_01_Idle_Pistol_No_Actions", true];
		} else {
			_player setVariable ["AR_Animation_Move", "AR_01_Idle_Pistol_No_Actions"];
		};
	} else {
		if (local _player) then {
			if(missionNamespace getVariable ["AR_DISABLE_SHOOTING_OVERRIDE", false]) then {
				_player switchMove "AR_01_Idle_No_Actions";
			} else {
				_player switchMove "AR_01_Idle";
			};
			_player setVariable ["AR_Animation_Move", "AR_01_Idle_No_Actions", true];
		} else {
			_player setVariable ["AR_Animation_Move", "AR_01_Idle_No_Actions"];
		};
	};
	if !(local _player) then {
		// Temp work around to avoid seeing other player as standing
		_player switchMove (_player getVariable ["AR_Animation_Move", "HubSittingChairC_idle1"]);
		sleep 1;
		_player switchMove (_player getVariable ["AR_Animation_Move", "HubSittingChairC_idle1"]);
		sleep 1;
		_player switchMove (_player getVariable ["AR_Animation_Move", "HubSittingChairC_idle1"]);
		sleep 1;
		_player switchMove (_player getVariable ["AR_Animation_Move", "HubSittingChairC_idle1"]);
	};
} else {
	if (local _player) then {
		_player switchMove "HubSittingChairC_idle1";
		_player setVariable ["AR_Animation_Move", "HubSittingChairC_idle1", true];
	} else {
		_player setVariable ["AR_Animation_Move", "HubSittingChairC_idle1"];
	};
};

private _animationEventHandler = -1;
if (local _player) then {
	_animationEventHandler = _player addEventHandler ["AnimChanged", {_this call ar_fnc_animchangedeh}];
};

if (!local _player) then {
	[_player] spawn {
		scriptName "spawn_ar_is_rappelling_2";
		params ["_player"];
		private ["_currentState", "_newState"];
		while {_player getVariable ["AR_Is_Rappelling", false]} do {
			_currentState = toLowerANSI animationState _player;
			_newState = toLowerANSI (_player getVariable ["AR_Animation_Move", ""]);
			if !(call AR_fnc_Has_Addon_Animations_Installed) then {
				_newState = "HubSittingChairC_idle1";
			};
			if (_currentState != _newState) then {
				_player switchMove _newState;
				_player switchGesture "";
				sleep 1;
				_player switchMove _newState;
				_player switchGesture "";
			};
			sleep 0.1;
		};
	};
};

waitUntil {!(_player getVariable ["AR_Is_Rappelling", false])};

if (_animationEventHandler != -1) then {
	_player removeEventHandler ["AnimChanged", _animationEventHandler];
};

_player switchMove "";
_player enableSimulation true;