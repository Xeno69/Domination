//#define __DEBUG__
#include "..\x_setup.sqf"

d_cas_metadata params ["_plane", "_planePos", "_pos", "_offset", "_velocity", "_vectorDir", "_vectorUp", "_time", "_duration"];

//--- Set the plane approach vector
_plane setVelocityTransformation [
	_planePos, _pos vectorAdd [0, 0, _offset],
	_velocity, _velocity,
	_vectorDir, _vectorDir,
	_vectorUp, _vectorUp,
	(time - _time) / _duration
];
_plane setVelocity velocity _plane;
