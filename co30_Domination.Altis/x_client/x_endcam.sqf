// by Xeno
#define THIS_FILE "x_endcam.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

d_end_cam_running = true;

if (visibleMap) then {
	openMap false;
	sleep 0.1;
};

showCinemaBorder false;
disableSerialization;
createDialog "d_RscAnimatedLetters";

private _line = 0;
d_animL_i = 0;
playMusic "Track02_SolarPower";

private _camera = "camera" camCreate getPosATLVisual player;
_camera cameraEffect ["External","back"];

_camera camSetTarget getPosATLVisual player;
_camera camSetRelPos [2.71,19.55,3.94];
_camera camSetFOV 1;
_camera camCommit 0.0;
waitUntil {camCommitted _camera};
0 spawn {
	scriptName "spawn_kickplayerendcam";
	private _vec = vehicle player;
	if (_vec != player && {_vec isKindOf "Air"}) then {
		private _posp = getPosATLVisual player;
		private _is_driver = driver _vec == player;
		player action ["getOut", _vec];
		waitUntil {isNull objectParent player};
		player setPos [_posp # 0, _posp # 1, 0];
		player setVelocity [0,0,0];
		if (_is_driver) then {
			waitUntil {(crew _vec) isEqualTo []};
			deleteVehicle _vec;
		};
	};
};

_camera camSetRelPos [80.80,120.29,633.07];
_camera camCommit 20;
d_intro_color = [1,1,1,1];
#ifndef __TT__
[5, localize "STR_DOM_MISSIONSTRING_231", 2] execVM "IntroAnim\animateLettersX.sqf"; _line = _line + 1; waitUntil {d_animL_i == _line};
sleep 5;
if (d_MissionType != 2) then {
	[0, localize "STR_DOM_MISSIONSTRING_232", 4] execVM "IntroAnim\animateLettersX.sqf"; _line = _line + 1; waitUntil {d_animL_i == _line};
} else {
	[0, localize "STR_DOM_MISSIONSTRING_233", 4] execVM "IntroAnim\animateLettersX.sqf"; _line = _line + 1; waitUntil {d_animL_i == _line};
};
#else
private _str = "";
private _str2 = "";
d_points_array params ["_points_blufor", "_points_opfor"];
if (_points_blufor > _points_opfor) then {
	_str = localize "STR_DOM_MISSIONSTRING_234";
	_str2 = format [localize "STR_DOM_MISSIONSTRING_235", _points_blufor, _points_opfor];
} else {
	if (_points_opfor > _points_blufor) then {
		_str = localize "STR_DOM_MISSIONSTRING_236";
		_str2 = format [localize "STR_DOM_MISSIONSTRING_237", _points_opfor, _points_blufor];
	} else {
		if (_points_opfor == _points_blufor) then {
			_str = localize "STR_DOM_MISSIONSTRING_238";
			_str2 = format [localize "STR_DOM_MISSIONSTRING_239", _points_blufor, _points_opfor];
		};
	};
};
[4, _str, 2] execVM "IntroAnim\animateLettersX.sqf"; _line = _line + 1; waitUntil {d_animL_i == _line};
sleep 5;
[6, _str2, 4] execVM "IntroAnim\animateLettersX.sqf"; _line = _line + 1; waitUntil {d_animL_i == _line};
#endif
waitUntil {camCommitted _camera};

_camera camSetFOV 2;

_camera camCommit 20;
[2, localize "STR_DOM_MISSIONSTRING_240", 6] execVM "IntroAnim\animateLettersX.sqf";_line = _line + 1; waitUntil {d_animL_i == _line};
waitUntil {camCommitted _camera};

_camera cameraEffect ["terminate","front"];
camDestroy _camera;

3 FADEMUSIC 0;
