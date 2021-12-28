// by duda123
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];
private _cOfMass = getCenterOfMass _vec;
(0 boundingBoxReal _vec) params ["_p1", "_p2"];
private _wOffset = (((abs ((_p2 # 0) - (_p1 # 0))) / 2) - abs ( _cOfMass # 0 )) * 0.75;
private _lOffset = (((abs ((_p2 # 1) - (_p1 # 1))) / 2) - abs (_cOfMass # 1 )) * 0.75;
[[(_cOfMass # 0) + _wOffset, (_cOfMass # 1) - _lOffset, _cOfMass # 2], [(_cOfMass # 0) - _wOffset, (_cOfMass # 1) - _lOffset, _cOfMass # 2],
[(_cOfMass # 0) + _wOffset, (_cOfMass # 1) + _lOffset, _cOfMass # 2], [(_cOfMass # 0) - _wOffset, (_cOfMass # 1) + _lOffset, _cOfMass # 2]];