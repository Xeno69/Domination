// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rebbuil.sqf"
#include "..\..\x_setup.sqf"

private _house_objects =+ d_house_objects;
d_house_objects = [];
sleep 300;
{
	_x setDamage 0;
	false
} count _house_objects;