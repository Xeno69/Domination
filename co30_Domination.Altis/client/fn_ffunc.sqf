// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_player_canu && {isNull objectParent player}) exitWith {
	d_objectID1 = cursorObject;
	if (isNull d_objectID1 || {!(d_objectID1 isKindOf "LandVehicle") || {!alive d_objectID1 || {player distance2D d_objectID1 > 8}}}) exitWith {false};
	private _vUp = vectorUpVisual d_objectID1;
	if ((_vUp # 2) < 0) exitWith {
		true
	};
	private _l = vectorMagnitude [_vUp # 0, _vUp # 1];
	[false, (_vUp # 2) atan2 _l < 30] select (_l != 0)
};
false
