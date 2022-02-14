//#define __DEBUG__
#include "..\x_setup.sqf"

private _plane = d_cas_metadata # 0;
private _planePos = d_cas_metadata # 1;
private _pos = d_cas_metadata # 2;
private _offset = d_cas_metadata # 3;
private _velocity = d_cas_metadata # 4;
private _vectorDir = d_cas_metadata # 5;
private _vectorUp = d_cas_metadata # 6;
private _time = d_cas_metadata # 7;
private _duration = d_cas_metadata # 8;
private _fireProgress = 0;

//--- Set the plane approach vector
_plane setVelocityTransformation [
	_planePos, [_pos # 0, _pos # 1, (_pos # 2) + _offset],
	_velocity, _velocity,
	_vectorDir, _vectorDir,
	_vectorUp, _vectorUp,
	(time - _time) / _duration
];
_plane setVelocity velocity _plane;
