/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_player", "_heli"];

if (isServer) then {
	if (!(_player in _heli) || {_player getVariable ["AR_Is_Rappelling", false]}) exitWith {};

	// Find next available rappel anchor
	private _rappelPoints = [_heli] call AR_fnc_Get_Heli_Rappel_Points;
	private _rappelPointIndex = 0;
	{
		private _rappellingPlayer = _heli getVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, objNull];
		if (isNull _rappellingPlayer) exitWith {};
		_rappelPointIndex = _rappelPointIndex + 1;
	} forEach _rappelPoints;

	// All rappel anchors are taken by other players. Hint player to try again.
	if (count _rappelPoints == _rappelPointIndex) exitWith {
		if (_player call d_fnc_isplayer) then {
			[24] remoteExecCall ["d_fnc_csidechat", _player];
		};
	};

	_heli setVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, _player];

	_player setVariable ["AR_Is_Rappelling", true, true];

	// Start rappelling (client side)
	[_player, _heli, _rappelPoints select _rappelPointIndex] spawn AR_fnc_Client_Rappel_From_Heli;

	// Wait for player to finish rappeling before freeing up anchor
	[_player, _heli, _rappelPointIndex] spawn {
		scriptName "spawn_AR_rappel_from_heli";
		params ["_player", "_heli", "_rappelPointIndex"];

		while {true} do {
			if (!alive _player || {!(_player getVariable ["AR_Is_Rappelling", false])}) exitWith {};
			sleep 2;
		};
		_heli setVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, nil];
	};
} else {
	_this remoteExecCall ["AR_fnc_Rappel_From_Heli", 2];
};