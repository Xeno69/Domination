// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_bonusvecfnc.sqf"
#include "..\x_setup.sqf"

params ["_vec"];

private _ma = _vec getVariable "d_abandoned_ma";
if (!isNil "_ma") then {
	deleteMarker _ma;
};

if (!surfaceIsWater (getPosASL _vec)) then {
	_vec execFSM "fsms\fn_Wreckmarker.fsm";
} else {
	_vec spawn {
		scriptName "spawn bonusvecfnc";
		#define __radius 20
		private _endpos = getPosWorld _this;
		private _markerpos = markerPos "xr_center";
		while {surfaceIsWater _endpos} do {
			_endpos = _endpos getPos [__radius, _endpos getDir _markerpos];
			sleep 0.01;
		};
		_endpos set [2, 0];
		_this setPos _endpos;
		_this execFSM "fsms\fn_Wreckmarker.fsm";
	};
};