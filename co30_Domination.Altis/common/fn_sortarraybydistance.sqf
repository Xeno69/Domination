//by Jezuro edited by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

// how about using the sort command?

params ["_unitArray", "_fromPosition"];
private _unsorted = _unitArray;
private _sorted = [];
private _pos =+ _fromPosition;

private "_closest";
{
	_closest = _unsorted # 0;
	{if ((getPos _x distance _pos) < (getPos _closest distance _pos)) then {_closest = _x}} forEach _unsorted;
	_sorted pushBack _closest;
	_unsorted = _unsorted - [_closest]
} forEach _unsorted;

_sorted