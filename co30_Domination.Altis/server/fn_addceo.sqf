// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addceo.sqf"
#include "..\x_setup.sqf"

{
	_x addCuratorEditableObjects [_this, true];
} forEach allCurators;