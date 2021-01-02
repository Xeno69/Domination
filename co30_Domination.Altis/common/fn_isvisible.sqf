//by sarogahtyp edited by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_isvisible.sqf"
#include "..\x_setup.sqf"

params ["_unit", "_target"];
_visibleThreshold = 0.015;
_targetEye = eyepos _target;
_unitEye = eyepos _unit;

//vector origins are half meter away from looker and target (uses 0.5 of a normalized vector which by definition is 1 meter)
_unit_in_dir = _unitEye vectorAdd ((_unitEye vectorFromTo _targetEye) vectorMultiply 0.5);
_target_in_dir = _targetEye vectorAdd ((_targetEye vectorFromTo _unitEye) vectorMultiply 0.5);

_visiblity = parseNumber str ([objNull, "VIEW"] checkVisibility [_target_in_dir, _unit_in_dir]);

(_visiblity > _visibleThreshold)