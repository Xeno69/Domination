// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_player_canu && {isNull objectParent player}) exitWith {
	d_objectID1 = cursorObject;
	if (isNull d_objectID1 || {!(d_objectID1 isKindOf "LandVehicle") || {!alive d_objectID1 || {player distance2D d_objectID1 > 8}}}) exitWith {false};
	d_objectID1 getEntityInfo 6
};
false

