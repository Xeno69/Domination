//#define __DEBUG__
#include "..\x_setup.sqf"

d_cas_metadata params ["_plane", "_planePos", "_pos", "_offset", "_velocity", "_vectorDir", "_vectorUp", "_time", "_duration"];

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
