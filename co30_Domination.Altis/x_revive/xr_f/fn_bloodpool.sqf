//#define __DEBUG__
#define THIS_FILE "fn_bloodpool.sqf"
#include "..\..\x_macros.sqf"

params ["_injured"];

private _bp = objNull;
private _bp_pos = _injured modelToWorldWorld [0,0,0];
private _class = selectRandom [
    "a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Large_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Medium_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Large_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Medium_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Small_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSpray_01_F.p3d"
];
_bp = createSimpleObject [_class, _bp_pos];
_bp setDir (random 359);
private _position = getPosWorld _bp;
_bp setPosATL [_position # 0, _position # 1, 0.01];
_bp setVectorUp (surfaceNormal _position);

_bp remoteExecCall ["d_fnc_addfifo", 2];