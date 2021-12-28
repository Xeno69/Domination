// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];
_vec addEventHandler ["killed", {call d_fnc_mthardtargetkilled}];
if (d_MTTowerSatchelsOnly == 0) then {
	_vec addEventHandler ["handleDamage", {call d_fnc_CheckMTShotHD}];
};