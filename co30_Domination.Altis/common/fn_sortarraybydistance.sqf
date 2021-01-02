//by Jezuro edited by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_sortarraybydistance.sqf"
#include "..\x_setup.sqf"

params ["_unitArray", "_fromPosition"];
_unsorted = _unitArray;
_sorted = [];
_pos = _fromPosition;

{
	_closest = _unsorted select 0;
	{if ((getPos _x distance _pos) < (getPos _closest distance _pos)) then {_closest = _x}} forEach _unsorted;
	_sorted pushBack _closest;
	_unsorted = _unsorted - [_closest]
} forEach _unsorted;

_sorted