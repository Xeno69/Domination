//#define __DEBUG__
#define THIS_FILE "fn_getflatarea.sqf"
#include "..\x_setup.sqf"

params ["_position", "_maxradius", ["_isFlat", []], ["_maxgradient", 0.1] , ["_radius", 10]];

while {count _isFlat < 3 && {_maxgradient < 0.7}} do {
	private _ang = random 360;
	private _bcount = floor (_radius * 2 * pi * 0.1);
	private _inc = 360/_bcount; 

	for "_i" from 1 to _bcount do {
		_ang = _inc * _i;		
		_isFlat = (_position getPos [_radius, _ang]) isFlatEmpty [10, 0, _maxgradient, 5, 0, false, objNull];
		if (count _isFlat == 3) then {
			_isFlat set [2, 0];
			if (count (_isFlat nearRoads 20) > 0) then {_isFlat = []};
		};
		if (count _isFlat == 3) exitWith{};
	};

	_radius = _radius + 10;
	if (_radius > _maxradius) then{
		_radius = 10;
		_maxgradient = _maxgradient + 0.1;
	};
};

if (_isFlat isEqualTo []) then {
	_isFlat = [(_position # 0) + _maxradius - random (2 * _maxradius), (_position # 1) + _maxradius - random (2 * _maxradius), 0];
};

_isFlat