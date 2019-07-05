// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointouterair.sqf"
#include "..\x_setup.sqf"

// get a random point at the borders of the current island for spawning air vehicles (no slope check, no is water check, etc)
private _width = (2 * (d_island_center # 0)) - 500;
private _height = (2 * (d_island_center # 1)) - 500;

private _px = 1;
private _py = 1;
switch (floor (random 4)) do {
	case 0: {
		_px = random _width;
		_py = _height / 10; // 250
	};
	case 1: {
		_px = _width / 10; // 250
		_py = random _height;
	};
	case 2: {
		_px = random _width;
		_py = _height - (_height / 10); // 250
	};
	case 3: {
		_px = _width - (_width / 10); // 250
		_py = random _height;
	};
};
[_px, _py, 300]
