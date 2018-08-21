/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_player", "_rappelDevice", "_rappelAncor"];

if (!hasInterface || {!(call AR_fnc_Has_Addon_Sounds_Installed)}) exitWith {};

if (player distance _player < 15) then {
	[_player, "AR_Rappel_Start"] call AR_fnc_Play_3D_Sound;
	[_rappelDevice, "AR_Rappel_Loop"] call AR_fnc_Play_3D_Sound;
};
_this spawn {
	params ["_player", "_rappelDevice", "_rappelAncor"];
	private ["_lastDistanceFromAnchor", "_distanceFromAnchor"];
	
	_lastDistanceFromAnchor = _rappelDevice distance _rappelAncor;
	while {_player getVariable ["AR_Is_Rappelling", false]} do {
		_distanceFromAnchor = _rappelDevice distance _rappelAncor;
		if (_distanceFromAnchor > _lastDistanceFromAnchor + 1 && {player distance _player < 15}) then {
			[_player, "AR_Rappel_Loop"] call AR_fnc_Play_3D_Sound;
			sleep 0.2;
			[_rappelDevice, "AR_Rappel_Loop"] call AR_fnc_Play_3D_Sound;
		};
		sleep 0.9;
		_lastDistanceFromAnchor = _distanceFromAnchor;
	};
};
_this spawn {
	params ["_player"];
	while {_player getVariable ["AR_Is_Rappelling", false]} do {
		sleep 0.1;
	};
	if (player distance _player < 15) then {
		[_player, "AR_Rappel_End"] call AR_fnc_Play_3D_Sound;
	};
};