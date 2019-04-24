// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vdhandler.sqf"
#include "..\..\x_setup.sqf"

#ifndef __DEBUG__
sleep 30;
#else
sleep 5;
#endif

private _isreduced = false;
private _curvd = -1;
private _curovd = -1;

waitUntil {sleep 1; !(d_cur_tgt_pos isEqualTo [])};

while {true} do {
	if (!_isreduced && {viewDistance > 800 && {isNull objectParent player && {positionCameraToWorld [0,0,0] distance2D d_cur_tgt_pos < 300}}}) then {
		_curvd = viewDistance;
		_curovd = getObjectViewDistance;
		setViewDistance 800;
		setObjectViewDistance 900;
		_isreduced = true;
	} else {
		if (_isreduced && {!isNull objectParent player || {positionCameraToWorld [0,0,0] distance2D d_cur_tgt_pos >= 300}}) then {
			setViewDistance _curvd;
			setObjectViewDistance _curovd;
			_isreduced = false;
		};
	};
	sleep 10;
};