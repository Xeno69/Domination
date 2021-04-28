//by sarogahtyp edited by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_unit", "_target"];
private _targetEye = eyepos _target;
private _unitEye = eyepos _unit;

//vector origins are half meter away from looker and target (uses 0.5 of a normalized vector which by definition is 1 meter)
([objNull, "VIEW"] checkVisibility [_targetEye vectorAdd ((_targetEye vectorFromTo _unitEye) vectorMultiply 0.5), _unitEye vectorAdd ((_unitEye vectorFromTo _targetEye) vectorMultiply 0.5)]) > 0.015