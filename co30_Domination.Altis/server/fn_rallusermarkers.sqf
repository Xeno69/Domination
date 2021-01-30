// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rallusermarkers.sqf"
#include "..\x_setup.sqf"

{
	deleteMarker _x;
} forEach (allMapMarkers select {_x find "_USER_DEFINED #" > -1});
