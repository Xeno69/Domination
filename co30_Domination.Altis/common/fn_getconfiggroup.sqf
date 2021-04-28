// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

"true" configClasses(configFile>>"CfgGroups">>(_this # 0)>>(_this # 1)>>(_this # 2)>>(_this # 3)) apply {getText (_x>>"vehicle")}
