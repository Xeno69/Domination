//#define __DEBUG__
#include "..\x_macros.sqf"

params ["_injured"];

private _class = selectRandom [
    "a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Large_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Medium_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Large_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Medium_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Small_F.p3d",
	"a3\Props_F_Orange\Humanitarian\Garbage\BloodSpray_01_F.p3d"
];
private _bp = createSimpleObject [_class, _injured modelToWorldWorld [0, 0, 0]];
_bp setDir (random 359);
private _posb = getPosWorld _bp;
_bp setPosATL [_posb # 0, _posb # 1, 0.01];
_bp setVectorUp (surfaceNormal _posb);

_bp remoteExecCall ["d_fnc_addfifo", 2];