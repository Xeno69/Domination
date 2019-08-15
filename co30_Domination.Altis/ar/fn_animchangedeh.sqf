/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_player", "_animation"];

if (call AR_fnc_Has_Addon_Animations_Installed) then {
	//private _lanim = toLower _animation;
	private _lanim = toLowerANSI _animation;
	if (_lanim find "ar_" < 0) then {
		if (([_player] call AR_fnc_Current_Weapon_Type_Selected) isEqualTo "HANDGUN") then {
			_player switchMove "AR_01_Aim_Pistol";
			_player setVariable ["AR_Animation_Move", "AR_01_Aim_Pistol_No_Actions", true];
		} else {
			_player switchMove "AR_01_Aim";
			_player setVariable ["AR_Animation_Move", "AR_01_Aim_No_Actions", true];
		};
	} else {
		if (_lanim isEqualTo "ar_01_aim") then {
			_player setVariable ["AR_Animation_Move", "AR_01_Aim_No_Actions", true];
		};
		if (_lanim isEqualTo "ar_01_idle") then {
			_player setVariable ["AR_Animation_Move", "AR_01_Idle_No_Actions", true];
		};
		if (_lanim isEqualTo "ar_01_aim_pistol") then {
			_player setVariable ["AR_Animation_Move", "AR_01_Aim_Pistol_No_Actions", true];
		};
		if (_lanim isEqualTo "ar_01_idle_pistol") then {
			_player setVariable ["AR_Animation_Move", "AR_01_Idle_Pistol_No_Actions", true];
		};
	};
} else {
	_player switchMove "HubSittingChairC_idle1";
	_player setVariable ["AR_Animation_Move", "HubSittingChairC_idle1", true];
};