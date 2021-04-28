// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _trig = createTrigger ["EmptyDetector", _this # 0, true];
_trig setTriggerArea (_this # 1);
_trig setTriggerActivation (_this # 2);
_trig setTriggerStatements (_this # 3);
if (count _this > 4) then {_trig setTriggerInterval (_this # 4)};
_trig
