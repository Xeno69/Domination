// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createtrigger.sqf"
#include "..\..\x_setup.sqf"

private _trig = createTrigger ["EmptyDetector", param [0], true];
_trig setTriggerArea (param [1]);
_trig setTriggerActivation (param [2]);
_trig setTriggerStatements (param [3]);
_trig