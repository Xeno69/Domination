// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

{
	deleteMarker _x;
} forEach (allMapMarkers select {"_USER_DEFINED #" in _x});
