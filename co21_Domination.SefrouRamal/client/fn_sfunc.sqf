// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_player_canu && {isNull objectParent player}) exitWith {
	d_objectID2 = cursorObject;
	__TRACE_1("","d_objectID2")
	if (!(d_objectID2 isKindOf "LandVehicle") && {!(d_objectID2 isKindOf "Air") && {!(d_objectID2 isKindOf "Ship")}}) exitWith {false};
	if (!alive d_objectID2) exitWith {false};
	(damage d_objectID2 > 0.05 || {fuel d_objectID2 < 0.95})
};
false
