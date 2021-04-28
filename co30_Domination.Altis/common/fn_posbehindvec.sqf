// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

(boundingBoxReal _this) params ["_p1", "_p2"];

 private _pos = _this modelToWorldVisual [0, -(((abs ((_p2 # 1) - (_p1 # 1))) / 2) + 2.5), 0];
 _pos set [2, 0];
 _pos