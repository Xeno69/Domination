// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

{
	_x addCuratorEditableObjects [_this, true];
} forEach allCurators;