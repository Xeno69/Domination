// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_aboxcreate.sqf"
#include "..\x_setup.sqf"

params ["_ma"];
private _bpos = markerPos _ma;
private _box = createVehicle [d_the_base_box, _bpos, [], 0, "NONE"];
_box setPos _bpos;
_box setDir (markerDir _ma);
if (surfaceIsWater _bpos && {!isNil "d_the_carrier"}) then {
	// we assume it is the carrier
	private _aslh = d_the_carrier getVariable "d_asl_height";
	if (!isNil "_aslh") then {
		_box setPosASL [_bpos # 0, _bpos # 1, _aslh];
	};
};
_box setVariable ["d_bpos", getPosASL _box];
_box setVariable ["d_bdir", markerDir _ma];
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearItemCargoGlobal _box;
_box enableRopeAttach false;
_box enableSimulationGlobal false;
_box addEventhandler ["killed", {call d_fnc_playerboxkilled}];
_box
