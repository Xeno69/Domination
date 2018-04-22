// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getconfiggroup.sqf"
#include "..\..\x_setup.sqf"

"true" configClasses(configFile>>"CfgGroups">>(param [0])>>(param [1])>>(param [2])>>(param [3])) apply {getText (_x>>"vehicle")}
